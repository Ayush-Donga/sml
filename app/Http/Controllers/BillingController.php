<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\OrderProduct;
use App\Models\OrderProductStock;
use App\Models\Order;
use App\Services\OneSignalService;
use App\Models\UserDeviceToken;
use App\Models\User;
use App\Models\Notification;

class BillingController extends Controller
{
    protected $oneSignalService;

    public function __construct(OneSignalService $oneSignalService)
    {
        $this->middleware('permission:billing-edit', ['only' => ['edit', 'update']]);
        $this->oneSignalService = $oneSignalService;
    }

    public function edit(Request $request, $id)
    {
        // Fetch the specific order with its related order products
        $orderProduct = OrderProduct::with('products','productVariants')->findOrFail($id);
        $orderProductStocks = OrderProduct::with('orderProductStocks')->findOrFail($id);
        $order = Order::findOrFail($orderProduct->order_id);
        $redirectUrl = urldecode($request->query('redirect', url()->previous()));
    
        return view('billing.edit', compact('orderProduct', 'orderProductStocks','order','redirectUrl'));
    }


    public function update(Request $request, $id)
    {
        $redirectUrl = urldecode($request->input('redirect'));

        // Process product stock updates or creations
        if ($request->productStock) {
            $newProductStockIds = [];
            foreach ($request->productStock as  $productStock) {
                if(isset($productStock['is_purchase_entry_done'])){
          
                    $updatedData = [
                        'is_purchase_entry_done' => $productStock['is_purchase_entry_done'],
                    ];

                    $orderProductStock = OrderProductStock::find($productStock['id']);
                        if ($orderProductStock) {
                            $orderProductStock->update($updatedData);
                            $newProductStockIds[] = $orderProductStock->id; 
                        }

                    // Send and store notifications only if 'is_purchase_entry_done' is "yes"
                    if ($productStock['is_purchase_entry_done'] === 'yes') {
                        // Notification logic
                        $user_ids = User::whereHas('roles', function ($query) {
                            $query->whereIn('type', ['LOGISTIC', 'PURCHASE']);
                        })->where('status', '!=', 0)->pluck('id')->toArray();


                        $player_ids_map = UserDeviceToken::whereIn('user_id', $user_ids)
                        ->pluck('player_id', 'user_id')
                        ->toArray(); 

                        $heading = $request->input('invoice_no') . " System Entry Done!!";
                        $content = "Our system just gave your stock a warm digital welcome!";

                        // Build the new redirect URL
                        $stockIdList = implode(',', $newProductStockIds);
                        $encodedStockIdList = urlencode($stockIdList);
                        $url = $redirectUrl . '#billing=' . $encodedStockIdList;

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
        }
     
        return redirect($redirectUrl)->with('success', 'Order billing updated successfully');
    }
}
