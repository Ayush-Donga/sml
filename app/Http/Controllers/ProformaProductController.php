<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\Proforma;
use App\Models\ProformaProduct;
use App\Models\Products;
use App\Models\ProductVariants;


class ProformaProductController extends Controller
{
    public function create(Request $request)
    {
          $id = $request->query('id');
          $proforma = Proforma::findOrFail($id);
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
          
          return view('proformaProducts.create', compact('proforma','productResponse','products', 'productVariants','redirectUrl'));
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

        $id = $request->input('proforma_id');

        if ($request->first) {
            foreach ($request->first as $value) {
                if ($value['product_id'] && $value['product_variant_id'] && $value['quantity'] && $value['price_per_set'] && $value['total']) {
                    $proformaProduct = new ProformaProduct([
                        'proforma_id' => $id,
                        'product_id' => $value['product_id'],
                        'product_variant_id' => $value['product_variant_id'],
                        'quantity' => $value['quantity'],
                        'price_per_set' => $value['price_per_set'],
                        'total' => $value['total']
                    ]);
                    $proformaProduct->save();
                }
            }
        }

        $shipping = $request->input('shipping') ?? null;
        $softBoxes = $request->input('soft_boxes') ?? null;
        $dataLogger = $request->input('data_logger') ?? null;
        $clearance = $request->input('clearance') ?? null;

        Proforma::where('id', $id)->update([
            'shipping' => $shipping,
            'soft_boxes' => $softBoxes,
            'data_logger' => $dataLogger,
            'clearance' => $clearance
        ]);

        $redirectUrl =  $url = route('proformas.index');
        $proforma = Proforma::findOrFail($id);

        $urlComponents = parse_url($redirectUrl);
        $queryParams = [];

        if (isset($urlComponents['query'])) {
            parse_str($urlComponents['query'], $queryParams);
        }

        $queryParams['month'] = $proforma->serve_date;

        $newQueryString = http_build_query($queryParams);

        $newRedirectUrl = $urlComponents['scheme'] . '://' . $urlComponents['host'] .
            (isset($urlComponents['port']) ? ':' . $urlComponents['port'] : '') .
            (isset($urlComponents['path']) ? $urlComponents['path'] : '') .
            ($newQueryString ? '?' . $newQueryString : '');

        return response()->json([
            'success' => 'Proforma products created successfully',
            'redirect' => $newRedirectUrl
        ]);
    }
    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Request $request,string $id)
    {
          $proforma = Proforma::findOrFail($id);
          $proformaProducts = Proforma::with('proformaProducts.products','proformaProducts.productVariants')->findOrFail($id);
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
          
          return view('proformaProducts.edit', compact('proforma', 'proformaProducts','productResponse','products', 'productVariants','redirectUrl'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
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

        if ($request->first) {
            foreach ($request->first as $value) {
                if ($value['product_id'] && $value['product_variant_id'] && $value['quantity'] && $value['price_per_set'] && $value['total']) {
                    $proformaProduct = new ProformaProduct([
                        'proforma_id' => $id,
                        'product_id' => $value['product_id'],
                        'product_variant_id' => $value['product_variant_id'],
                        'quantity' => $value['quantity'],
                        'price_per_set' => $value['price_per_set'],
                        'total' => $value['total']
                    ]);
                    $proformaProduct->save();
                }
            }
        }
    
        if ($request->product) {
            foreach ($request->product as $index => $productData) {
                if (isset($productData['id'])) {
                    $proformaProduct = ProformaProduct::findOrFail($productData['id']);
                    $proformaProduct->update($productData);
                } else {
                    if ($productData['product_id'] && $productData['product_variant_id'] && $productData['quantity'] && $productData['price_per_set'] && $productData['total']) {
                        $proformaProduct = new ProformaProduct($productData);
                        $proformaProduct->proforma_id = $id;
                        $proformaProduct->save();
                    }
                }
            }
        }
    
        $shipping = $request->input('shipping') ?? null;
        $softBoxes = $request->input('soft_boxes') ?? null;
        $dataLogger = $request->input('data_logger') ?? null;
        $clearance = $request->input('clearance') ?? null;

        Proforma::where('id', $id)->update([
            'shipping' => $shipping,
            'soft_boxes' => $softBoxes,
            'data_logger' => $dataLogger,
            'clearance' => $clearance
        ]);

        $redirectUrl = urldecode($request->input('redirect'));

        return response()->json([
            'success' => 'Proforma products updated successfully',
            'redirect' => $redirectUrl
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        try {
            $proformaProduct = ProformaProduct::findOrFail($id);
            $proformaProduct->delete();
            // Optionally, return a JSON response if you're using AJAX
            return response()->json(['message' => 'Product deleted successfully.']);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Unable to delete Product.'], 500);
        }
    }
}
