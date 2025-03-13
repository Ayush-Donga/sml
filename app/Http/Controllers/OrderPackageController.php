<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\Order;
use App\Models\OrderPackage;
use App\Models\OrderPackageProduct;
use App\Models\Products;
use App\Services\OneSignalService;
use App\Models\UserDeviceToken;
use App\Models\User;
use App\Models\Notification;

class OrderPackageController extends Controller
{
    protected $oneSignalService;
    protected $updatedPackageProducts;

    public function __construct(OneSignalService $oneSignalService)
    {
        $this->middleware('permission:wareHouse-packing-list-edit', ['only' => ['edit', 'update']]);
        $this->oneSignalService = $oneSignalService;
    }
    
    public function edit(Request $request, $id)
    {
        // $order = Order::with(['orderPackages.orderPackageProducts'])->findOrFail($id);
        // $orderProducts = Order::with('orderProducts')->findOrFail($id);
        $products = Products::with('productVariants')->get();
        $order = Order::with(['orderPackages.orderPackageProducts', 'orderProducts.products','orderProducts.productVariants'])->findOrFail($id);
        $redirectUrl = urldecode($request->query('redirect', url()->previous()));

        return view('orderPackage.edit', compact('order','products','redirectUrl'));
    }

    public function update(Request $request, $id)
    {
        $rules = [
            // Existing "package" items
            'package.*.box_no'       => ['required', 'string', 'max:255'],
            'package.*.dimension'    => ['nullable', 'string', 'max:255'],
            'package.*.gross_weight' => ['nullable', 'numeric', 'max:99999999'],
            'package.*.net_weight'   => ['nullable', 'numeric', 'max:99999999'],

            // NESTED: packageProducts
            //    'package.*.*.packageProducts.order_product_id' => ['required','integer'],
            'package.*.*.packageProducts.quantity'         => ['nullable','integer','max:99999999'],
   
        
            // Newly added first items
            'first.*.box_no'       => ['required', 'string', 'max:255'],
            'first.*.dimension'    => ['nullable', 'string', 'max:255'],
            'first.*.gross_weight' => ['nullable', 'numeric', 'max:99999999'],
            'first.*.net_weight'   => ['nullable', 'numeric', 'max:99999999'],
        
            // NESTED: firstProduct
            // 'first.*.*.firstProduct.order_product_id' => ['required', 'integer'],
            'first.*.*.firstProduct.quantity'         => ['nullable', 'integer', 'max:99999999'],
        ];
        
        $messages = [
            'package.*.box_no.required'        => 'The box number field is required.',
            'package.*.box_no.max'             => 'Box number may not be greater than 255 characters.',
            'package.*.dimension.max'          => 'Box dimension may not be greater than 255 characters.',
            'package.*.gross_weight.numeric'   => 'Gross weight must be a number.',
            'package.*.gross_weight.max'       => 'Gross weight may not exceed 8 digits.',
            'package.*.net_weight.numeric'     => 'Net weight must be a number.',
            'package.*.net_weight.max'         => 'Net weight may not exceed 8 digits.',

            // 'package.*.*.packageProducts.order_product_id.required' => 'The product name field is required.',
            'package.*.*.packageProducts.quantity.integer'         => 'Quantity must be a number.',
            'package.*.*.packageProducts.quantity.max'         => 'Quantity may not exceed 8 digits.',
        
            'first.*.box_no.required'             => 'The box number field is required.',
            'first.*.box_no.max'             => 'Box number may not be greater than 255 characters.',
            'first.*.dimension.max'          => 'Box dimension may not be greater than 255 characters.',
            'first.*.gross_weight.numeric'   => 'Gross weight must be a number.',
            'first.*.gross_weight.max'       => 'Gross weight may not exceed 8 digits.',
            'first.*.net_weight.numeric'     => 'Net weight must be a number.',
            'first.*.net_weight.max'         => 'Net weight may not exceed 8 digits.',

            // 'first.*.*.firstProduct.order_product_id.required' => 'The product name field is required.',
            'first.*.*.firstProduct.quantity.integer'         => 'Quantity must be a number.',
            'first.*.*.firstProduct.quantity.max'         => 'Quantity may not exceed 8 digits.',
        ];
        
        // 4) Custom attribute labels:
        $attributes = [
            // Existing package items
            'package.*.box_no'        => 'box number',
            'package.*.dimension'     => 'dimension',
            'package.*.gross_weight'  => 'gross weight',
            'package.*.net_weight'    => 'net weight',

            // 'package.*.*.packageProducts.order_product_id' => 'order product ID',
            'package.*.*.packageProducts.quantity'         => 'quantity',

            // Newly added items:
            'first.*.box_no'              => 'box number',
            'first.*.dimension'           => 'dimension',
            'first.*.gross_weight'        => 'gross weight',
            'first.*.net_weight'          => 'net weight',

            // 'first.*.*.firstProduct.order_product_id' => 'order product ID',
            'first.*.*.firstProduct.quantity'         => 'quantity',
        ];
        
        // Now create the validator with the 4th parameter for custom attributes
        $validator = Validator::make($request->all(), $rules, $messages, $attributes);
        
        if ($validator->fails()) {
            return response()->json([
                'errors' => $validator->errors()
            ], 422);
        }        

        $created_by = (int)$request->input('created_by');
        $invoice_no = $request->input('invoice_no');
        $redirectUrl = urldecode($request->input('redirect'));

        if ($request->has('first')) {
            $newPackageIds = [];
            $newPackageProductIds = [];
            foreach ($request->first as $package) {
                $boxNo = $package['box_no'] ?? null;
                $dimension = $package['dimension'] ?? null;
                $grossWeight = $package['gross_weight'] ?? null;
                $netWeight = $package['net_weight'] ?? null;
               if($boxNo !== null){
                    // Create the package regardless of null values
                    $newPackage = OrderPackage::create([
                        'box_no' => $boxNo,
                        'order_id' => $id,
                        'dimension' => $dimension,
                        'gross_weight' =>  $grossWeight,
                        'net_weight' =>  $netWeight
                    ]);

                    $newPackageIds[] = $newPackage->id;

                    // Create package product if 
                    foreach ($package as $key => $value) {
                        if (is_array($value)) {
                        $packageProductData = $value['firstProduct'];
                        $productId = $packageProductData['order_product_id'] ?? null;
                        $quantity = $packageProductData['quantity'] ?? null;
                                        
                          $packageProduct = OrderPackageProduct::create([
                                'order_package_id' => $newPackage->id,
                                'order_product_id' => $productId,
                                'quantity' => $quantity
                            ]);

                            $newPackageProductIds[] = $packageProduct->id;
                        }
                    }

                    // Build the new redirect URL
                    $packageIdList = implode(',', $newPackageIds);
                    $encodedPackageIdList = urlencode($packageIdList);
                    $packageProductIdList = implode(',', $newPackageProductIds);
                    $encodedPackageProductIdList = urlencode($packageProductIdList);
                   
                    $newRedirectUrl = $redirectUrl . '#package=' . $encodedPackageIdList . '&packageProduct=' . $encodedPackageProductIdList;

                    // Send notification for order package product creation
                    $this->sendOrderPackageNotification($created_by, $invoice_no, $newRedirectUrl);
                }
            }
        }

        if ($request->has('package')) {
            $updatedPackages                     = [];
            $newPackageProductIds               = [];
            $this->updatedPackageProducts       = [];
            $isOrderPackageproduct              = false;
            $isPackageUpdated                   = false;
            $changedPackageFields               = [];
            $changedUpdatedPackageProductFields = [];
        
            foreach ($request->package as $packageIndex => $packageData) {
                // Make sure we have an existing package ID
                if (!empty($packageData['id'])) {
                    
                    // 1) Load the existing package
                    $orderPackage = OrderPackage::findOrFail($packageData['id']);
        
                    // For comparing changes
                    $originalData          = $orderPackage->only(['box_no', 'dimension', 'gross_weight', 'net_weight']);
                    $originalDataNormalized = array_map(function ($value) {
                        return is_numeric($value)
                            ? number_format((float)$value, 2, '.', '')
                            : strval($value);
                    }, $originalData);
        
                    // 2) Prepare updated fields
                    $updatedData = [
                        'box_no'       => $packageData['box_no']       ?? null,
                        'dimension'    => $packageData['dimension']    ?? null,
                        'gross_weight' => $packageData['gross_weight'] ?? null,
                        'net_weight'   => $packageData['net_weight']   ?? null,
                    ];
                    $updatedDataNormalized = array_map(function ($value) {
                        return is_numeric($value)
                            ? number_format((float)$value, 2, '.', '')
                            : strval($value);
                    }, $updatedData);
        
                    // 3) Update the OrderPackage
                    $orderPackage->update($updatedData);
        
                    // 4) Identify changed fields
                    $changedFields = array_keys(array_diff_assoc($updatedDataNormalized, $originalDataNormalized));
                    if (!empty($changedFields)) {
                        $isPackageUpdated     = true;
                        // Merge into our global changed fields array if needed
                        $changedPackageFields = array_merge($changedPackageFields, $changedFields);
        
                        $updatedPackages[] = [
                            'id'     => $orderPackage->id,
                            'fields' => $changedFields,
                        ];
        
                        // Optionally mark each product as “touched” if you want
                        foreach ($orderPackage->orderPackageProducts as $op) {
                            $this->updatedPackageProducts[] = [
                                'id'     => $op->id,
                                'fields' => [],
                            ];
                        }
                    }
        
                    // 5) Now handle nested package products
                    foreach ($packageData as $key => $value) {
                        if (is_numeric($key) && isset($value['packageProducts'])) {
                            $packageProductData = $value['packageProducts'];
        
                            // Update existing product if "id" is present
                            if (!empty($packageProductData['id'])) {
                                $orderPackageProduct = OrderPackageProduct::findOrFail($packageProductData['id']);
        
                                // Compare old vs new for changes
                                $originalProd = $orderPackageProduct->only(['order_product_id', 'quantity']);
                                $originalProdNormalized = [
                                    'order_product_id' => (string)(int)$originalProd['order_product_id'],
                                    'quantity'         => (string)(int)$originalProd['quantity'],
                                ];
        
                                $updatedProd = [
                                    // Force it to the same package ID to prevent it from “jumping”
                                    'order_package_id' => $orderPackage->id,
                                    'order_product_id' => $packageProductData['order_product_id'],
                                    'quantity'         => $packageProductData['quantity'],
                                ];
                                $updatedProdNormalized = [
                                    'order_product_id' => (string)(int)$updatedProd['order_product_id'],
                                    'quantity'         => (string)(int)$updatedProd['quantity'],
                                ];
        
                                // Perform the update
                                $orderPackageProduct->update($updatedProd);
        
                                // Check if fields changed
                                $changedFieldsP = array_keys(array_diff_assoc($updatedProdNormalized, $originalProdNormalized));
                                if (!empty($changedFieldsP)) {
                                    $isPackageUpdated = true; // Mark that something changed
                                    $changedUpdatedPackageProductFields = array_merge(
                                        $changedUpdatedPackageProductFields,
                                        $changedFieldsP
                                    );
        
                                    $this->updatedPackageProducts[] = [
                                        'id'     => $orderPackageProduct->id,
                                        'fields' => $changedFieldsP,
                                    ];
        
                                    $updatedPackages[] = [
                                        'id'     => $orderPackage->id,
                                        'fields' => [],
                                    ];
                                }
                            } else {
                                // 6) Create a new product if no "id"
                                $orderPackageProduct = OrderPackageProduct::create([
                                    'order_package_id' => $orderPackage->id,
                                    'order_product_id' => $packageProductData['order_product_id'],
                                    'quantity'         => $packageProductData['quantity'],
                                ]);
        
                                if ($orderPackageProduct) {
                                    $isOrderPackageproduct = true;
                                    $newPackageProductIds[] = $orderPackageProduct->id;
                                }
                            }
                        }
                    }
                }
            }
        
            // 7) Send notifications if packages or products changed
            if ($isPackageUpdated) {
                $allChangedFields = array_merge($changedPackageFields, $changedUpdatedPackageProductFields);
        
                $encodedUpdatedPackages        = urlencode(json_encode($updatedPackages));
                $encodedUpdatedPackageProducts = urlencode(json_encode($this->updatedPackageProducts));
                $newRedirectUrl = $redirectUrl
                    . '#updatedPackages=' . $encodedUpdatedPackages
                    . '&updatedPackageProducts=' . $encodedUpdatedPackageProducts;
        
                $this->sendOrderPackageUpdateNotification($created_by, $invoice_no, $newRedirectUrl, $allChangedFields);
            }
        
            // If any new products were created
            if ($isOrderPackageproduct) {
                $packageProductIdList        = implode(',', $newPackageProductIds);
                $encodedPackageProductIdList = urlencode($packageProductIdList);
        
                $newRedirectUrl = $redirectUrl . '#packageProduct=' . $encodedPackageProductIdList;
                $this->sendOrderPackageNotification($created_by, $invoice_no, $newRedirectUrl);
            }
        }

        return response()->json([
            'success' => 'Order product package updated successfully',
            'redirect' => $redirectUrl
        ]);
    }

    public function destroy($id)
    {
        try {
            $orderPackage = OrderPackage::findOrFail($id);
            $orderPackage->delete();
            
            // Optionally, return a JSON response if you're using AJAX
            return response()->json(['message' => 'Package deleted successfully.']);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Unable to delete package.'], 500);
        }
    }

    public function destroyPackageProduct($id)
    {
        try {
            $orderPackageProduct = OrderPackageProduct::findOrFail($id);
            $orderPackageProduct->delete();
            
            // Optionally, return a JSON response if you're using AJAX
            return response()->json(['message' => 'Package product deleted successfully.']);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Unable to delete package product.'], 500);
        }
    }

    /**
     * Send notification for order package creation
     */
    private function sendOrderPackageNotification($created_by, $invoice_no, $url)
    {
        $user_ids = User::whereHas('roles', function ($query) {
            $query->whereIn('type', ['LOGISTIC']);
        })->where('status', '!=', 0)->pluck('id')->toArray();

        // Add the user who created the order
        if (User::where('id', $created_by)->where('status', '!=', 0)->exists()) {
            $user_ids[] = $created_by;
        }

        $player_ids_map = UserDeviceToken::whereIn('user_id', $user_ids)
        ->pluck('player_id', 'user_id')
        ->toArray(); 

        $heading = $invoice_no . " Packing List Created!!";
        $content = "Time to make sure everything fits like a puzzle... with a few extra bubble wraps!";

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
     * Send notification for order package update
     */
    private function sendOrderPackageUpdateNotification($created_by, $invoice_no, $url, $changedFields)
    {
        $user_ids = User::whereHas('roles', function ($query) {
            $query->whereIn('type', ['LOGISTIC']);
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
            'box_no' => 'box no',
            'dimension' => 'dimension',
            'gross_weight' => 'gross weight',
            'net_weight' => 'net weight',
            'order_product_id' => 'product name',
            'quantity' => 'quantity',
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

        $heading = $invoice_no . " Packing List Revised!";
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
