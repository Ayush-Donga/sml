<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use App\Models\Order;
use App\Models\OrderProduct;
use App\Models\Products;
use App\Models\ProductVariants;
use App\Models\OrderPackageProduct;
use App\Services\OneSignalService;
use App\Models\UserDeviceToken;
use App\Models\User;
use App\Models\Notification;

class OrderProductController extends Controller
{
    protected $oneSignalService;

    public function __construct(OneSignalService $oneSignalService)
    {
        $this->middleware('permission:bd-department-list', ['only' => ['index', 'show']]);
        $this->middleware('permission:bd-department-edit', ['only' => ['edit', 'update']]);
        $this->oneSignalService = $oneSignalService;
    }

    public function create(Request $request)
    {
        $id = $request->query('id');

        $order = Order::findOrFail($id);
        $products = Products::with('productVariants')->get();
        $productVariants = ProductVariants::get();
    
        $productsData = [];
        foreach ($products as $product) {
            $variants = [];
            foreach ($product->productVariants as $variant) {
                $variants[] = [
                    "id" => $variant->id,
                    "product_id" => $variant->product_id,
                    "name" => $variant->name,
                    "status" => $variant->status
                ];
            }

            $productsData[] = [
                "id" => $product->id,
                "name" => $product->name,
                "status" => $product->status,
                "variants" => $variants
            ];
        }

        $productResponse = [
            "products" => $productsData
        ];
        
        $redirectUrl = urldecode($request->query('redirect', url()->previous()));

        return view('orderProducts.create', compact('order','productResponse', 'products', 'productVariants', 'redirectUrl'));
    }

    public function store(Request $request)
    {
        $rules = [
            // Newly added items:
            'first.*.product_id'           => ['required','integer'],
            'first.*.product_variant_id'   => ['required_with:first.*.product_id','integer'],
            'first.*.quantity'             => ['required','numeric','max:99999999'],
            'first.*.price_per_set'        => ['required','numeric','max:99999999.99'],
            'first.*.total'                => ['required','numeric','max:999999999.99'],
        
            // Other fields:
            'shipping'     => ['nullable','numeric','max:99999999'],
            'soft_boxes'   => ['nullable','numeric','max:99999999'],
            'data_logger'  => ['nullable','numeric','max:99999999'],
            'clearance'    => ['nullable','numeric','max:99999999'],
        ];
        
        $messages = [
           
            'first.*.product_id.required'        => 'The product description field is required.',
            'first.*.product_variant_id.required_with' => 'The pack size field is required.',
            'first.*.quantity.required'          => 'The pack quantity is required.',
            'first.*.quantity.max'               => 'Pack Quantity cannot exceed 8 digits.',
            'first.*.price_per_set.required'     => 'The price per set is required.',
            'first.*.price_per_set.max'          => 'Price Per Set cannot exceed 8 digits.',
            'first.*.total.required'             => 'The total is required.',
            'first.*.total.max'                  => 'Total cannot exceed 8 digits.',
        
            'shipping.max'     => 'Shipping cannot exceed 8 digits.',
            'soft_boxes.max'   => 'Soft boxes cannot exceed 8 digits.',
            'data_logger.max'  => 'Data logger cannot exceed 8 digits.',
            'clearance.max'    => 'Clearance cannot exceed 8 digits.',
        ];
        
        // 4) Custom attribute labels:
        $attributes = [
            // Newly added items:
            'first.*.product_id'           => 'product description',
            'first.*.product_variant_id'   => 'pack size',
            'first.*.quantity'             => 'pack quantity',
            'first.*.price_per_set'        => 'price per set',
            'first.*.total'                => 'total',
        
            // Other fields
            'shipping'   => 'shipping',
            'soft_boxes' => 'soft boxes',
            'data_logger'=> 'data logger',
            'clearance'  => 'clearance',
        ];
        
        // Now create the validator with the 4th parameter for custom attributes
        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        
        if ($validator->fails()) {
            return response()->json([
                'errors' => $validator->errors()
            ], 422);
        }

        $id = $request->input('order_id');
        $invoice_no = $request->input('invoice_no');

         // Get the order details for the serve_date
         $order = Order::findOrFail($id);

         // Generate the redirect URL using Laravel helpers
         $redirectUrl = route('orders.index', ['month' => $order->serve_date]);
         
        try {
            if ($request->has('first')) {
                $newProductIds = [];
                foreach ($request->input('first') as $value) {
                    if (!empty($value['product_id']) && !empty($value['product_variant_id']) && !empty($value['quantity']) && !empty($value['price_per_set']) && !empty($value['total'])) {
                       $orderProduct = OrderProduct::create([
                            'order_id' => $id,
                            'product_id' => $value['product_id'],
                            'product_variant_id' => $value['product_variant_id'],
                            'quantity' => $value['quantity'],
                            'price_per_set' => $value['price_per_set'],
                            'total' => $value['total']
                        ]);

                         // Add the newly created order product ID to the array
                         $newProductIds[] = $orderProduct->id;
                    }
                }

                // Build the new redirect URL
                $productIdList = implode(',', $newProductIds);
                $encodedProductIdList = urlencode($productIdList);
                $newRedirectUrl = $redirectUrl . '#products=' . $encodedProductIdList;

                // Notify for new order product creation
                $this->sendOrderProductNotification($invoice_no,$newRedirectUrl);
            }

            $shipping = $request->input('shipping') ?? null;
            $softBoxes = $request->input('soft_boxes') ?? null;
            $dataLogger = $request->input('data_logger') ?? null;
            $clearance = $request->input('clearance') ?? null;
            
            // Update order details
            Order::where('id', $id)->update([
                'shipping' => $shipping,
                'soft_boxes' => $softBoxes,
                'data_logger' => $dataLogger,
                'clearance' => $clearance
            ]);
            
            $heading = [];
            if ($order) {
                if ($order->shipping != $shipping) {
                    $heading[] = 'Shipping Cost';
                }
                if ($order->soft_boxes != $softBoxes) {
                    $heading[] = 'Soft Box Price';
                }
                if ($order->data_logger != $dataLogger) {
                    $heading[] = 'Data Logger Price';
                }
                if ($order->clearance != $clearance) {
                    $heading[] = 'Clearance Cost';
                }
    
                // Send a single notification with all heading
                if (!empty($heading)) {
                    $encodedOrder = urlencode($order->id);
                    $changedFields = urlencode(implode(',', $heading));
                    $newRedirectUrl = $redirectUrl . '#order=' . $encodedOrder . '&fields=' . $changedFields;

                    $this->sendFieldNotification(implode(', ', $heading), $invoice_no, $newRedirectUrl);
                }
            }
    
            return response()->json([
                'success' => 'Order products created successfully',
                'redirect' => $redirectUrl
            ]);
    
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    public function edit(Request $request, $id)
    { 
        // Fetch the specific order with its related order products
        $order = Order::findOrFail($id);
        $orderProducts = Order::with('orderProducts.products','orderProducts.productVariants')->findOrFail($id);
        // Fetch all products wise veriants
        $products = Products::with('productVariants')->get();
        $productVariants = ProductVariants::get();
       
        $productsData = [];
        foreach ($products as $product) {
            $variants = [];
            foreach ($product->productVariants as $variant) {
                $variants[] = [
                    "id" => $variant->id,
                    "product_id" => $variant->product_id,
                    "name" => $variant->name,
                    "status" => $variant->status
                ];
            }

            $productsData[] = [
                "id" => $product->id,
                "name" => $product->name,
                "status" => $product->status,
                "variants" => $variants
            ];
        }

        $productResponse = [
            "products" => $productsData
        ];

        $redirectUrl = urldecode($request->query('redirect', url()->previous()));
        
        return view('orderProducts.edit', compact('order', 'orderProducts','productResponse','products', 'productVariants','redirectUrl'));
    }

    public function update(Request $request, $id)
    {
        $rules = [
            // Existing items:
            'product.*.product_id'         => ['required', 'integer'],
            'product.*.product_variant_id' => ['required_with:product.*.product_id','integer'],
            'product.*.quantity'           => ['required','numeric','max:99999999'],
            'product.*.price_per_set'      => ['required','numeric','max:99999999.99'],
            'product.*.total'              => ['required','numeric','max:99999999.99'],
        
            // Newly added items:
            'first.*.product_id'           => ['required','integer'],
            'first.*.product_variant_id'   => ['required_with:first.*.product_id','integer'],
            'first.*.quantity'             => ['required','numeric','max:99999999'],
            'first.*.price_per_set'        => ['required','numeric','max:99999999.99'],
            'first.*.total'                => ['required','numeric','max:999999999.99'],
        
            // Other fields:
            'shipping'     => ['nullable','numeric','max:99999999'],
            'soft_boxes'   => ['nullable','numeric','max:99999999'],
            'data_logger'  => ['nullable','numeric','max:99999999'],
            'clearance'    => ['nullable','numeric','max:99999999'],
        ];
        
        $messages = [
            'product.*.product_id.required'      => 'The product description field is required.',
            'product.*.product_variant_id.required_with' => 'The pack size field is required.',
            'product.*.quantity.required'        => 'The pack quantity is required.',
            'product.*.quantity.max'             => 'Pack Quantity cannot exceed 8 digits.',
            'product.*.price_per_set.required'   => 'The price per set is required.',
            'product.*.price_per_set.max'        => 'Price Per Set cannot exceed 8 digits.',
            'product.*.total.max'                => 'Total cannot exceed 8 digits.',
        
            'first.*.product_id.required'        => 'The product description field is required.',
            'first.*.product_variant_id.required_with' => 'The pack size field is required.',
            'first.*.quantity.required'          => 'The pack quantity is required.',
            'first.*.quantity.max'               => 'Pack Quantity cannot exceed 8 digits.',
            'first.*.price_per_set.required'     => 'The price per set is required.',
            'first.*.price_per_set.max'          => 'Price Per Set cannot exceed 8 digits.',
            'first.*.total.required'             => 'The total is required.',
            'first.*.total.max'                  => 'Total cannot exceed 8 digits.',
        
            'shipping.max'     => 'Shipping cannot exceed 8 digits.',
            'soft_boxes.max'   => 'Soft boxes cannot exceed 8 digits.',
            'data_logger.max'  => 'Data logger cannot exceed 8 digits.',
            'clearance.max'    => 'Clearance cannot exceed 8 digits.',
        ];
        
        // 4) Custom attribute labels:
        $attributes = [
            // Existing items:
            'product.*.product_id'         => 'product description',
            'product.*.product_variant_id' => 'pack size',
            'product.*.quantity'           => 'pack quantity',
            'product.*.price_per_set'      => 'price per set',
            'product.*.total'              => 'total',
        
            // Newly added items:
            'first.*.product_id'           => 'product description',
            'first.*.product_variant_id'   => 'pack size',
            'first.*.quantity'             => 'pack quantity',
            'first.*.price_per_set'        => 'price per set',
            'first.*.total'                => 'total',
        
            // Other fields
            'shipping'   => 'shipping',
            'soft_boxes' => 'soft boxes',
            'data_logger'=> 'data logger',
            'clearance'  => 'clearance',
        ];
        
        // Now create the validator with the 4th parameter for custom attributes
        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        
        if ($validator->fails()) {
            return response()->json([
                'errors' => $validator->errors()
            ], 422);
        }        
        
        $invoice_no = $request->input('invoice_no');
        $redirectUrl = urldecode($request->input('redirect'));

        // Process new records
        if ($request->first) {
            $newProductIds = [];
            foreach ($request->first as $value) {
                if ($value['product_id'] && $value['product_variant_id'] && $value['quantity'] && $value['price_per_set'] && $value['total']) {
                    $orderProduct = new OrderProduct([
                        'order_id' => $id,
                        'product_id' => $value['product_id'],
                        'product_variant_id' => $value['product_variant_id'],
                        'quantity' => $value['quantity'],
                        'price_per_set' => $value['price_per_set'],
                        'total' => $value['total']
                    ]);
                    $orderProduct->save();

                    // Add the newly created order product ID to the array
                    $newProductIds[] = $orderProduct->id;
                }
            }

            // Build the new redirect URL
            $productIdList = implode(',', $newProductIds);
            $encodedProductIdList = urlencode($productIdList);
            $newRedirectUrl = $redirectUrl . '#products=' . $encodedProductIdList;

            // Notify for new order product creation
            $this->sendOrderProductNotification($invoice_no, $newRedirectUrl);
        }

        // Process product updates or creations
        if ($request->product) {
            if ($request->product) {
                $newProductIds = [];
                $updatedProducts = [];
                foreach ($request->product as $index => $productData) {
                    // Check if the product has an existing ID
                    if (isset($productData['id'])) {
                        // Find existing product and track changes
                        $orderProduct = OrderProduct::findOrFail($productData['id']);
                        $originalData = $orderProduct->toArray();
                        $orderProduct->update($productData);
            
                        // Get changed fields
                        $changedFields = array_keys(array_diff_assoc($orderProduct->toArray(), $originalData));
    
                        if(!empty($changedFields)){

                            $updatedProducts[] = [
                                'id' => $productData['id'],
                                'fields' => $changedFields
                            ];

                            $encodedUpdatedProducts = urlencode(json_encode($updatedProducts));
                            $newRedirectUrl = $redirectUrl . '#updatedProducts=' . $encodedUpdatedProducts;

                            // Notify with dynamic fields
                            $this->sendOrderProductUpdateNotification($invoice_no, $newRedirectUrl, $changedFields);
                        }
                    } else {
                        // If it doesn't have an ID, create a new product
                        if ($productData['product_id'] && $productData['product_variant_id'] && $productData['quantity'] && $productData['price_per_set'] && $productData['total']) {
                            $orderProduct = new OrderProduct($productData);
                            $orderProduct->order_id = $id; // Set the order_id
                            $orderProduct->save();
                            // Add the newly created order product ID to the array
                             $newProductIds[] = $orderProduct->id;
                             
                            // Build the new redirect URL
                            $productIdList = implode(',', $newProductIds);
                            $encodedProductIdList = urlencode($productIdList);
                            $newRedirectUrl = $redirectUrl . '#products=' . $encodedProductIdList;

                            // Notify for new order product creation
                            $this->sendOrderProductNotification($invoice_no, $newRedirectUrl);
                        }
                    }
                }
            }
        }

        $originalOrder = Order::find($id);

        $shipping = $request->input('shipping') ?? null;
        $softBoxes = $request->input('soft_boxes') ?? null;
        $dataLogger = $request->input('data_logger') ?? null;
        $clearance = $request->input('clearance') ?? null;
        
        // Update order details
        Order::where('id', $id)->update([
            'shipping' => $shipping,
            'soft_boxes' => $softBoxes,
            'data_logger' => $dataLogger,
            'clearance' => $clearance
        ]);
        
        $heading = [];
        if ($originalOrder) {
            if ($originalOrder->shipping != $shipping) {
                $heading[] = 'Shipping Cost';
            }
            if ($originalOrder->soft_boxes != $softBoxes) {
                $heading[] = 'Soft Box Price';
            }
            if ($originalOrder->data_logger != $dataLogger) {
                $heading[] = 'Data Logger Price';
            }
            if ($originalOrder->clearance != $clearance) {
                $heading[] = 'Clearance Cost';
            }

            // Send a single notification with all heading
            if (!empty($heading)) {
                $encodedOrder = urlencode($originalOrder->id);
                $changedFields = urlencode(implode(',', $heading));
                $newRedirectUrl = $redirectUrl . '#order=' . $encodedOrder . '&fields=' . $changedFields;
            
                $this->sendFieldNotification(implode(', ', $heading), $invoice_no, $newRedirectUrl);
            }
            
        }

        return response()->json([
            'success' => 'Order products updated successfully',
            'redirect' => $redirectUrl
        ]);
    }

    /**
     * Send notification for order product creation
     */
    private function sendOrderProductNotification($invoice_no, $url)
    {
        $user_ids = User::whereHas('roles', function ($query) {
            $query->whereIn('type', ['PURCHASE', 'LOGISTIC']);
        })->where('status', '!=', 0)->pluck('id')->toArray();

        $player_ids_map = UserDeviceToken::whereIn('user_id', $user_ids)
        ->pluck('player_id', 'user_id')
        ->toArray(); 

        $heading = $invoice_no . " New Order Won!!";
        $content = "Let the hunt for the best deal begin!";

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
     * Send notification for field updates
     */
    private function sendFieldNotification($field, $invoice_no, $url)
    {
        $user_ids = User::whereHas('roles', function ($query) {
            $query->whereIn('type', ['LOGISTIC']);
        })->where('status', '!=', 0)->pluck('id')->toArray();

        $player_ids_map = UserDeviceToken::whereIn('user_id', $user_ids)
        ->pluck('player_id', 'user_id')
        ->toArray(); 

        $heading = $invoice_no . " " . $field . " Added!!";
        $content = "The " . strtolower($field) . " have been added!";

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
     * Send notification for updated order product with dynamic content.
     */
    public function sendOrderProductUpdateNotification($invoice_no, $url, $changedFields)
    {
        $user_ids = User::whereHas('roles', function ($query) {
            $query->whereIn('type', ['PURCHASE', 'LOGISTIC']);
        })
        ->where('status', '!=', 0)
        ->pluck('id')
        ->toArray();

        $player_ids_map = UserDeviceToken::whereIn('user_id', $user_ids)
            ->pluck('player_id', 'user_id')
            ->toArray(); 

        // Field mapping from database fields to user-friendly names
        $fieldMapping = [
            'product_id'         => 'product description',
            'product_variant_id' => 'pack size',
            'quantity'           => 'pack quantity',
            'price_per_set'      => 'price per set',
            'total'              => 'total'
        ];

        // Convert changed fields to readable names
        $headingFields = array_map(function ($field) use ($fieldMapping) {
            return $fieldMapping[$field] ?? str_replace('_', ' ', $field);
        }, $changedFields);

        // Build a comma/and-separated list for the notification content
        if (count($headingFields) > 2) {
            $lastField  = array_pop($headingFields);
            $fieldList  = implode(', ', $headingFields) . ' and ' . $lastField;
        } elseif (count($headingFields) === 2) {
            $fieldList  = implode(' and ', $headingFields);
        } else {
            $fieldList  = $headingFields[0] ?? '';
        }

        $heading = $invoice_no . " Order Details Revised!!";
        $content = "The value " . $fieldList . " has been updated!";

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

    public function destroy($id)
    {
        try {
            $packageProduct = OrderPackageProduct::where('order_product_id', $id)->get();
            if($packageProduct->isNotEmpty()){
                return response()->json(['error' => 'This product is used.']);
            } else {
                $orderProduct = OrderProduct::findOrFail($id);
                $orderProduct->delete();
                
                // Optionally, return a JSON response if you're using AJAX
                return response()->json(['message' => 'Product deleted successfully.']);
            }
        } catch (\Exception $e) {
            return response()->json(['error' => 'Unable to delete Product.'], 500);
        }
    }
}
 