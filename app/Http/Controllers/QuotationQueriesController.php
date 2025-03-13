<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use App\Models\QuotationQuery; 
use App\Models\Quotation; 
use App\Models\User;
use App\Models\Inquire;
use App\Services\OneSignalService;
use App\Models\UserDeviceToken;
use App\Models\Notification;

class QuotationQueriesController extends Controller
{

    protected $oneSignalService;

    public function __construct(OneSignalService $oneSignalService)
    {
        $this->oneSignalService = $oneSignalService;
    }

    public function index($quotationId)
    {
        $comments = QuotationQuery::where('quotation_id', $quotationId)
            ->join('users', 'users.id', '=', 'quotation_queries.created_by')
            ->select('quotation_queries.comment', 'quotation_queries.created_at', 'users.name as username')
            ->orderBy('quotation_queries.id', 'desc') 
            ->get();
    
        return response()->json($comments);
    }
    
    public function store(Request $request, $quotationId)
    {
        try {
            $inquiry = Inquire::findOrFail($request->inquire_id);

            if (!$inquiry) {
                return response()->json([
                    'success' => false,
                    'message' => 'Inquiry not found.'
                ], 404);
            }
    
             $authUserRole = Auth::user()->roles->pluck('type')->toArray();
        
            // Update the inquiry status based on the role type
            if (in_array('BD', $authUserRole)) {
                $inquiry->status = 'reopen';
            } elseif (in_array('PURCHASE', $authUserRole)) {
                $inquiry->status = 'close';
            }
    
             $inquiry->save();
    
            $comment = new QuotationQuery();
            $comment->quotation_id = $quotationId;
            $comment->comment = $request->text;
            $comment->created_by = Auth::id();
            $comment->save();

            // Send notification based on the status
            $this->sendNotificationBasedOnStatus($inquiry, $request->page_url);

            $user = Auth::user();
            return response()->json([
                'success' => true,
                'message' => 'Your comment was successfully added.',
                'comment' => $comment->comment,
                'created_at' => $comment->created_at->toISOString(),
                'username' => $user->name
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'An error occurred while adding the comment.',
                'error' => $e->getMessage()
            ], 500);
        }
    } 
    
    private function sendNotificationBasedOnStatus($inquire, $redirectUrl)
    {
        $brandOrGenericName = $this->getBrandOrGenericName($inquire);
        $notificationDetails = $this->getNotificationDetails($inquire->status, $inquire->quote_number, $brandOrGenericName);

        if ($notificationDetails) {
            // Determine the recipient based on status
            $recipientUserId = null;
            if ($inquire->status == "reopen") {
                $recipientUserId = $inquire->assigned_user_id;
            } elseif ($inquire->status == "close") {
                $recipientUserId = $inquire->created_by;
            }
    
            // Send notification only if recipient is determined
            if ($recipientUserId) {
                $this->sendNotification(
                    $recipientUserId,
                    $notificationDetails['heading'],
                    $notificationDetails['content'],
                    $redirectUrl
                );
            }
        }
    }

    private function getBrandOrGenericName($inquire)
    {
        return $inquire->type === 'generic'
            ? $inquire->generic->name ?? ''
            : $inquire->brand->name ?? '';
    }

    private function getNotificationDetails($status, $quoteNo, $brandOrGenericName)
    {
        $details = [
            'reopen' => [
                'heading' => "$quoteNo $brandOrGenericName Client's Query Generated!!",
                'content' => "Time to put on our detective hats and crack the case!",
            ],
            'close' => [
                'heading' => "$quoteNo $brandOrGenericName Query Resolved!!",
                'content' => "Mission accomplished!",
            ],
        ];

        return $details[$status] ?? null; // Return null if the status is not recognized
    }

    private function sendNotification($user_id, $heading, $content, $url)
    {
        // Filter only active users
        $user_ids = User::whereIn('id', [$user_id])
            ->where('status', '!=', 0) // Exclude inactive users
            ->pluck('id')
            ->toArray();

        if (!empty($user_ids)) {
            $player_ids_map = UserDeviceToken::whereIn('user_id', $user_ids)
            ->pluck('player_id', 'user_id')
            ->toArray(); 

            $notifications = [];
            $userUrls = [];

            // Create notifications and store their updated URLs per user
            foreach ($user_ids as $user_id) {
                $notification = Notification::create([
                    'user_id'  => $user_id,
                    'heading'  => $heading,
                    'content'  => $content,
                    'url'      => $url, 
                    'is_read'  => false,
                ]);

                // Generate updated URL with notification ID
                $updatedUrl = addNotificationIdToUrl($url, $notification->id);
                $notification->update(['url' => $updatedUrl]);

                // Store updated URL for each user
                $userUrls[$user_id] = $updatedUrl;
            }

            // Send push notifications to users with their respective updated URLs
            foreach ($player_ids_map as $user_id => $player_id) {
                if (!empty($player_id) && isset($userUrls[$user_id])) {
                    $this->oneSignalService->sendNotification([$player_id], $heading, $content, $userUrls[$user_id]);
                }
            }
        }
    }
}
