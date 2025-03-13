<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Order;
use App\Models\OrderProduct;
use App\Services\OneSignalService;
use App\Models\UserDeviceToken;
use App\Models\User;
use App\Models\Notification;
use Carbon\Carbon;

class OrderPurchaseController extends Controller
{
    protected $oneSignalService;

    public function __construct(OneSignalService $oneSignalService)
    {
         $this->middleware('permission:purchase-department-edit', ['only' => ['edit', 'update']]);
         $this->oneSignalService = $oneSignalService;
    }

    public function edit(Request $request, $id)
    {
        // Fetch the specific order with its related order products
        $order = Order::findOrFail($id);
        $orderProducts = Order::with('orderProducts.products','orderProducts.productVariants')->findOrFail($id);
        $redirectUrl = urldecode($request->query('redirect', url()->previous()));

        return view('orderPurchase.edit', compact('order', 'orderProducts','redirectUrl'));
    }

    public function update(Request $request, $id)
    {
        $redirectUrl = urldecode($request->input('redirect'));
        $invoice_no = $request->input('invoice_no');
        $created_by = (int)$request->input('created_by');

        $shouldSendPurchaseNotification = false;
        $newProductIds = [];
        $updatedPurchases = [];
        if ($request->has('product')) {
            $updatedPurchases = [];
            foreach ($request->product as $product) {
                if (isset($product['id']) && isset($product['is_order_placed'])) {
                    $isOrderPlaced = $product['is_order_placed'];
                    $note = ($isOrderPlaced == 'yes') ? null : $product['note'];
                    $expected_delivery_date = ($isOrderPlaced == 'no' || $isOrderPlaced == 'error') 
                        ? null 
                        : Carbon::parse($product['expected_delivery_date'])->format('Y-m-d');

                     $orderProduct = OrderProduct::where('id', $product['id'])->first();

                    if ($orderProduct) {
                        $originalExpectedDeliveryDate = $orderProduct->expected_delivery_date 
                            ? Carbon::parse($orderProduct->expected_delivery_date)->format('Y-m-d') 
                            : null;
                    
                        $updatedData = [
                            'is_order_placed' => $isOrderPlaced,
                            'note' => $note,
                            'expected_delivery_date' => $expected_delivery_date,
                        ];
                    
                        // Check if `expected_delivery_date` is being added for the first time
                        $expectedDeliveryDateAddedForFirstTime = is_null($originalExpectedDeliveryDate) && !empty($expected_delivery_date);
                    
                        if ($expectedDeliveryDateAddedForFirstTime) {
                            $shouldSendPurchaseNotification = true;
                            $newProductIds[] = $orderProduct->id; // Add to newProductIds only if `expected_delivery_date` is added
                        }
                    
                        // Check if `expected_delivery_date` has been updated
                        $expectedDeliveryDateChanged = 
                            $originalExpectedDeliveryDate !== $expected_delivery_date && 
                            !is_null($originalExpectedDeliveryDate) && 
                            !is_null($expected_delivery_date);
                    
                        // Update the order product
                        $orderProduct->update($updatedData);
                    
                        // Send notifications if necessary
                        if ($expectedDeliveryDateChanged) {
                            $updatedPurchases[] = [
                                'id' => $orderProduct->id,
                                'fields' => ['expected_delivery_date'],
                            ];
                    
                            // Encode `updatedPurchases` array into JSON and URL format
                            $encodedUpdatedPurchases = urlencode(json_encode($updatedPurchases));
                            $newRedirectUrl = $redirectUrl . '#updatedPurchases=' . $encodedUpdatedPurchases;
                    
                            $this->sendOrderPurchaseUpdateNotification($created_by, $invoice_no, $newRedirectUrl, ['expected_delivery_date'], $orderProduct);
                        }
                    }
                }
            }
        }

        // Send purchase creation notification only if `expected_delivery_date` is set for the first time
        if ($shouldSendPurchaseNotification) {
            // Build the new redirect URL
            $productIdList = implode(',', $newProductIds);
            $encodedProductIdList = urlencode($productIdList);
            $newRedirectUrl = $redirectUrl . '#purchase=' . $encodedProductIdList;
                
            $this->sendOrderPurchaseNotification($invoice_no, $created_by, $newRedirectUrl);
        }

        return response()->json([
            'success' => 'Products purchase updated successfully',
            'redirect' => $redirectUrl
        ]);
    }

    /**
     * Send notification for order purchase creation
     */
    private function sendOrderPurchaseNotification($invoice_no, $created_by, $url)
    {
        $user_ids = User::whereHas('roles', function ($query) {
            $query->whereIn('type', ['WAREHOUSE']);
        })->where('status', '!=', 0)->pluck('id')->toArray();

        // Add the user who created the order
        if (User::where('id', $created_by)->where('status', '!=', 0)->exists()) {
            $user_ids[] = $created_by;
        }

        $player_ids_map = UserDeviceToken::whereIn('user_id', $user_ids)
        ->pluck('player_id', 'user_id')
        ->toArray(); 

        $heading = $invoice_no . " The final order is placed!!";
        $content = "No turning back now, it’s in the vendor’s hands. Now wait for the delivery guy to find us!";

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
     * Send notification for order purchase update
     */
    private function sendOrderPurchaseUpdateNotification($created_by, $invoice_no, $url, $changedFields, $orderProduct)
    {
        $productName = $orderProduct->product ? $orderProduct->product->name : ' ';

        $user_ids = User::whereHas('roles', function ($query) {
            $query->whereIn('type', ['WAREHOUSE']);
        })->where('status', '!=', 0)->pluck('id')->toArray();

        // Add the user who created the order
        if (User::where('id', $created_by)->where('status', '!=', 0)->exists()) {
            $user_ids[] = $created_by;
        }

        $player_ids_map = UserDeviceToken::whereIn('user_id', $user_ids)
        ->pluck('player_id', 'user_id')
        ->toArray(); 

        // Map field names to user-friendly labels
        $fieldMapping = [
            'expected_delivery_date' => 'expected delivery date',
        ];

        $headingFields = array_map(function ($field) use ($fieldMapping) {
            return $fieldMapping[$field] ?? str_replace('_', ' ', $field);
        }, $changedFields);

        $fieldList = count($headingFields) === 1 ? implode(' ', $headingFields) : '';

        $heading = $invoice_no . " " . $productName . " Revised Date Added!!";
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
