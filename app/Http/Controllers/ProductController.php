<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Products;
use App\Models\ProductVariants;
use App\Models\OrderProduct;
use App\Models\ProformaProduct;
use App\Models\Quotation;
use App\Models\Inquire;


class ProductController extends Controller
{
    public function __construct()
    {
        $this->middleware('permission:product-list', ['only' => ['index', 'show']]);
        $this->middleware('permission:product-create', ['only' => ['create', 'store']]);
        $this->middleware('permission:product-edit', ['only' => ['edit', 'update']]);
        $this->middleware('permission:product-delete', ['only' => ['destroy']]);
    }

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $perPageOptions = [10, 25, 50, 100];
        $defaultPerPage = $perPageOptions[0]; 
        $perPage = $request->input('perPage', $defaultPerPage);
        $search  = $request->input('search', '');
        $page    = (int) $request->input('page', 1);
        $sortBy  = $request->input('sortBy', 'id'); // Default sort column
        $sortOrder = $request->input('sortOrder', 'desc'); // Default sort order

        if (! in_array($perPage, $perPageOptions)) {
            $perPage = $defaultPerPage;
        }

        $productsQuery = Products::with('productVariants')->orderBy($sortBy, $sortOrder);

        if (!empty($search)) {
            $productsQuery->where(function ($query) use ($search) {
                $query->where('name', 'like', "%$search%")
                ->orWhere('generic_name', 'like', "%$search%")
                ->orWhere('manufactured_by', 'like', "%$search%")
                ->orWhere('hsn_code', 'like', "%$search%");

                // Convert search input date to database format
                if (preg_match('/\d{2}\/\d{2}\/\d{4}/', $search)) {
                    $dateParts = explode('/', $search);
                    if (count($dateParts) === 3) {
                        $formattedDate = "{$dateParts[2]}-{$dateParts[1]}-{$dateParts[0]}"; // Convert dd/mm/yyyy to yyyy-mm-dd
                        $query->orWhereDate('created_at', $formattedDate);
                    }
                }
            })
            ->orWhereHas('productVariants', function ($subQuery) use ($search) {
                $subQuery->where('name', 'like', "%$search%");
            });
        }

        $products = $productsQuery->paginate($perPage, ['*'], 'page', $page);

        if ($request->ajax()) {
            return response()->json([
                'html' => view('products.partials.product_table', compact('products'))->render()
            ]);
        }

        return view('products.index', compact('products', 'perPageOptions', 'perPage', 'search', 'sortBy', 'sortOrder'));
    }


    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        $redirectUrl = urldecode($request->query('redirect', url()->previous()));

        return view('products.create', compact('redirectUrl'));
    }

    /**
     * Store a newly created resource in storage.
     */

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'heading' => 'nullable|string|max:100',
            'generic_name' => 'nullable|string|max:255',
            'manufactured_by' => 'nullable|string|max:255',
            'hsn_code' => 'nullable|max:25',
            'variant.*.name' => 'nullable|string|max:255',
        ], [
            'name.required' => 'The product name field is required.',
            // 'heading.required' => 'The heading field is required.',
            // 'generic_name.required' => 'The generic name field is required.',
            // 'manufactured_by.required' => 'The manufactured by field is required.',
            // 'hsn_code.required' => 'The HSN code field is required.',
            // 'variant.*.name.required' => 'The variant name field is required.',
            'variant.*.name.max' => 'The variant name must not be greater than 255 characters.', 
        ]);

        if ($request->has('name')) {
            $newProduct = Products::create([
                'name' => $request['name'],
                'heading' => $request['heading'],
                'generic_name' => $request['generic_name'],
                'manufactured_by' => $request['manufactured_by'],
                'hsn_code' => $request['hsn_code'],
                'status' => 1
            ]);

            foreach ($request->variant as $variantData) {
                if (isset($variantData['name'])) {
                    ProductVariants::create([
                        'product_id' => $newProduct->id,
                        'name' => $variantData['name'],
                        'status' => 1
                    ]);
                }
            }
        }

        $redirectUrl = urldecode($request->input('redirect'));

        return redirect($redirectUrl)->with('success', 'Product create successfully');
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Request $request, string $id)
    {
        $product = Products::with('productVariants')->findOrFail($id);

        $redirectUrl = urldecode($request->query('redirect', url()->previous()));

        return view('products.edit', compact('product',  'redirectUrl'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //dd($request->all());
        $request->validate([
            'name' => 'required|string|max:255',
            'heading' => 'nullable|string|max:100',
            'generic_name' => 'nullable|string|max:255',
            'manufactured_by' => 'nullable|string|max:255',
            'hsn_code' => 'nullable|max:25',
            'variant.*.name' => 'nullable|string|max:255',
        ], [
            'name.required' => 'The product name field is required.',
            'variant.*.name.max' => 'The variant name must not be greater than 255 characters.',
        ]);

        if ($request->has('name')) {
            // Update the main product details
            Products::where('id', $id)->update([
                'name' => strtoupper($request->name),
                'heading' => strtoupper($request->heading),
                'generic_name' => strtoupper($request->generic_name),
                'manufactured_by' => strtoupper($request->manufactured_by),
                'hsn_code' => strtoupper($request->hsn_code),
                'status' => 1
            ]);

            // Process the variants
            foreach ($request->variant as $variantData) {
                if (isset($variantData['id']) && $variantData['name'] !== null) {
                    // Update existing variant
                    ProductVariants::where('id', $variantData['id'])->update([
                        'product_id' => $variantData['product_id'],
                        'name' => strtoupper($variantData['name']),
                        'status' => 1
                    ]);
                } elseif (isset($variantData['id']) && $variantData['name'] === null) {
                    // Delete variant with null name
                    ProductVariants::where('id', $variantData['id'])->delete();
                } elseif (isset($variantData['name'])) {
                    // Create new variant
                    ProductVariants::create([
                        'product_id' => $id,
                        'name' => strtoupper($variantData['name']),
                        'status' => 1
                    ]);
                }
            }
        }

        $redirectUrl = urldecode($request->input('redirect'));

        // Redirect back to the paginated list with the correct page number
        return redirect($redirectUrl)->with('success', 'Product updated successfully.');
    }


    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        try {
            $orderProducts = OrderProduct::where('product_id', $id)->exists();
            $proformaProducts = ProformaProduct::where('product_id', $id)->exists();
            $quotation = Quotation::where('brand_id', $id)->exists();
            $inquire = Inquire::where('brand_id', $id)->exists();

            if ($orderProducts || $proformaProducts || $quotation || $inquire) {
                return response()->json(['error' => 'This product is used.']);
            } else {
                $product = Products::findOrFail($id);
                $product->delete();

                // Optionally, return a JSON response if you're using AJAX
                return response()->json(['message' => 'Product deleted successfully.']);
            }

        } catch (\Exception $e) {
            return response()->json(['error' => 'Unable to delete product.'], 500);
        }
    }


    public function variantDestroy($id)
    {
        try {
            $orderProducts = OrderProduct::where('product_variant_id', $id)->exists();
            $proformaProducts = ProformaProduct::where('product_variant_id', $id)->exists();
            $quotation = Quotation::where('product_variant_id', $id)->exists();

            if ($orderProducts || $proformaProducts || $quotation) {
                return response()->json(['error' => 'This variant is used.']);
            } else {
                $productVariant = ProductVariants::findOrFail($id);
                $productVariant->delete();

                return response()->json(['message' => 'Variant deleted successfully.']);
            }
        } catch (\Exception $e) {
            return response()->json(['error' => 'Unable to delete variant.'], 500);
        }
    }

    public function updateStatus(Request $request, $id)
    {
        $product = Products::find($id);

        if (!$product) {
            return response()->json(['error' => 'Product not found'], 404);
        }

        $product->status = $request->input('status');
        $product->save();

        ProductVariants::where('product_id', $id)->update(['status' => $request->input('status')]);

        return response()->json(['message' => 'Product status updated successfully']);
    }
}
