<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Order;
use App\Models\OrderProduct;
use App\Models\OrderProductStock;
use Illuminate\Support\Facades\Validator;
use App\Services\OneSignalService;
use App\Models\UserDeviceToken;
use App\Models\User;
use App\Models\Notification;

class OrderProductStockController extends Controller
{
    protected $oneSignalService;

    public function __construct(OneSignalService $oneSignalService)
    {
        $this->middleware('permission:wareHouse-department-edit', ['only' => ['edit', 'update']]);
        $this->oneSignalService = $oneSignalService;
    }
    
    public function edit(Request $request, $id)
    {
        // Fetch the specific order with its related order products
        $orderProduct = OrderProduct::with('products','productVariants')->findOrFail($id);
        $order = Order::findOrFail($orderProduct->order_id);
        $orderProductStocks = OrderProduct::with('orderProductStocks')->findOrFail($id);
        $redirectUrl = urldecode($request->query('redirect', url()->previous()));
    
        return view('orderProductStock.edit', compact('order','orderProduct', 'orderProductStocks','redirectUrl'));
    }
    
    public function update(Request $request, $id)
    {
        $redirectUrl = urldecode($request->input('redirect'));
        $created_by = (int)$request->input('created_by');
        $invoice_no = $request->input('invoice_no');

        // Process product stock updates or creations
        if ($request->productStock) {
            $isStockCreated = false;
            $newStockIds = [];
            $allChangedFields = []; 
            $allUpdatedStocks = [];
            foreach ($request->productStock as $index => $productStockData) {
        
                if (isset($productStockData['id'])) {
                    $orderProductStock = OrderProductStock::findOrFail($productStockData['id']);
                    $originalData = $orderProductStock->only(['batch_no', 'mfg_date', 'exp_date', 'quantity', 'is_stock_received']);
                    
                    // Prepare the updated data
                    $updatedData = $productStockData['is_stock_received'] === 'yes' ? [
                        'batch_no' => $productStockData['batch_no'],
                        'mfg_date' => $productStockData['mfg_date'],
                        'exp_date' => $productStockData['exp_date'],
                        'quantity' => $productStockData['quantity'],
                        'is_stock_received' => $productStockData['is_stock_received']
                    ] : [
                        'batch_no' => null,
                        'mfg_date' => null,
                        'exp_date' => null,
                        'quantity' => null,
                        'is_stock_received' => $productStockData['is_stock_received']
                    ];
            
                    // Identify changed fields before saving
                    $changedFields = array_keys(array_diff_assoc($updatedData, $originalData));
                    $allChangedFields = array_unique(array_merge($allChangedFields, $changedFields));
            
                    // Update the record
                    $orderProductStock->update($updatedData);
            
                    // Collect all updated stocks for later use
                    if (!empty($changedFields)) {
                        $allUpdatedStocks[] = [
                            'id' => $orderProductStock->id,
                            'fields' => $changedFields
                        ];
                    }
                } else {
                    if(isset($productStockData['is_stock_received'])){

                        $isStockReceived = $productStockData['is_stock_received'];
                        $batchNo = ($isStockReceived == 'no') ? null : $productStockData['batch_no'];
                        $mfgDate = ($isStockReceived == 'no') ? null : $productStockData['mfg_date'];
                        $expDate = ($isStockReceived == 'no') ? null : $productStockData['exp_date'];
                        $quantity = ($isStockReceived == 'no') ? null : $productStockData['quantity'];

                       $productStock = OrderProductStock::create([
                            'order_product_id' => $id,
                            'is_stock_received' => $isStockReceived,
                            'batch_no' => $batchNo,
                            'mfg_date' => $mfgDate,
                            'exp_date' => $expDate,
                            'quantity' => $quantity,
                        ]);

                        if(!empty($productStock)){
                            $isStockCreated = true;
                            $newStockIds[] = $productStock->id;
                        }
                  } 
                }
            }

            // Send a single consolidated notification if there are changes
            if (!empty($allChangedFields)) {
                $encodedUpdatedStocks = urlencode(json_encode($allUpdatedStocks));
                $newRedirectUrl = $redirectUrl . '#updatedStocks=' . $encodedUpdatedStocks;

                $this->sendOrderProductStockUpdateNotification($created_by, $invoice_no, $newRedirectUrl, $allChangedFields);
            }

            // Send notifications for newly created stock entries
            if($isStockCreated){
                // Build the new redirect URL
                $stockIdList = implode(',', $newStockIds);
                $encodedStockIdList = urlencode($stockIdList);
                $newRedirectUrl = $redirectUrl . '#productStocks=' . $encodedStockIdList;

                // send notification for order product stock creation
                $this->sendOrderProductNotification($created_by, $invoice_no, $newRedirectUrl);
            }
        }
        
        return response()->json([
            'success' => 'Order product stocks updated successfully',
            'redirect' => $redirectUrl
        ]);
    }

    public function destroy($id)
    {
        try {
            $orderProductStock = OrderProductStock::findOrFail($id);
            $orderProductStock->delete();
            
            // Optionally, return a JSON response if you're using AJAX
            return response()->json(['message' => 'Product stock deleted successfully.']);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Unable to delete product stock.'], 500);
        }
    }

    /**
     * Send notification for order product stock creation
     */
    private function sendOrderProductNotification($created_by, $invoice_no, $url)
    {
        // Fetch users with specific roles
        $user_ids = User::whereHas('roles', function ($query) {
            $query->whereIn('type', ['PURCHASE', 'BILLING', 'LOGISTIC']);
        })->where('status', '!=', 0)->pluck('id')->toArray();

        // Include the creator of the order
        if (User::where('id', $created_by)->where('status', '!=', 0)->exists()) {
            $user_ids[] = $created_by;
        }

        $player_ids_map = UserDeviceToken::whereIn('user_id', $user_ids)
        ->pluck('player_id', 'user_id')
        ->toArray(); 

        // Prepare notification content
        $heading = $invoice_no . " Stock has entered the warehouse!!";
        $content = "Let the unpacking party begin!";

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

    /**
     * Send notification for order product stock update
     */
    private function sendOrderProductStockUpdateNotification($created_by, $invoice_no, $url, $changedFields)
    {
        // Fetch users with specific roles
        $user_ids = User::whereHas('roles', function ($query) {
            $query->whereIn('type', ['PURCHASE', 'BILLING', 'LOGISTIC']);
        })->where('status', '!=', 0)->pluck('id')->toArray();

        // Include the creator of the order
        if (User::where('id', $created_by)->where('status', '!=', 0)->exists()) {
            $user_ids[] = $created_by;
        }

        $player_ids_map = UserDeviceToken::whereIn('user_id', $user_ids)
        ->pluck('player_id', 'user_id')
        ->toArray(); 

        // Map field names to user-friendly labels
        $fieldMapping = [
            'batch_no' => 'batch number',
            'mfg_date' => 'manufacturing date',
            'exp_date' => 'expiry date',
            'quantity' => 'quantity',
            'is_stock_received' => 'stock received'
        ];

        $headingFields = array_map(function ($field) use ($fieldMapping) {
            return $fieldMapping[$field] ?? str_replace('_', ' ', $field);
        }, $changedFields);

        $fieldList = '';
        if (count($headingFields) > 1) {
            $lastField = array_pop($headingFields);
            $fieldList = implode(', ', $headingFields) . ' and ' . $lastField;
        } elseif (count($headingFields) == 1) {
            $fieldList = implode(' ', $headingFields);
        }

        $heading = $invoice_no . " Stock Details Revised!";
        $content = "The value " . $fieldList . " updated at!";

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
