<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\UploadedFile;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use App\Models\Generic;
use App\Models\Manufacturer;
use App\Models\Products;
use App\Models\ProductVariants;
use App\Models\ProductDocument;
use App\Models\ProductPhoto;
use App\Models\Quotation;
use App\Models\Supplier;
use App\Models\Vender;
use App\Models\Inquire;
use App\Models\InquiryHistory;
use App\Models\InquireStatusHistory;
use App\Models\QuotationHistory;
use App\Models\QuotationQuery;
use App\Models\User;
use Illuminate\Support\Facades\Log;
use App\Services\OneSignalService;
use App\Models\UserDeviceToken;
use App\Models\Notification;
use Carbon\Carbon;


class QuotationController extends Controller
{
    protected $oneSignalService;

    public function __construct(OneSignalService $oneSignalService)
    {
        $this->middleware('permission:quotation-list', ['only' => ['index', 'show']]);
        $this->middleware('permission:quotation-create', ['only' => ['create', 'store']]);
        $this->middleware('permission:quotation-edit', ['only' => ['edit', 'update']]);
        $this->oneSignalService = $oneSignalService;
    }

    // Display a listing of the resource.
    public function index(Request $request)
    {
        $perPageOptions = [10, 25, 50, 100];
        $defaultPerPage = $perPageOptions[0];
        $perPage = $request->input('perPage', $defaultPerPage);
        $search = $request->input('search', '');
        $status = $request->input('status', 'open'); 

        // Build the base query
        $baseQuery = Inquire::with([
            'quotations', 
            'quotations.productDocuments', 
            'quotations.productPhotos',
            'quotations.suppliers',
            'brand',
            'generic',
        ])->orderBy('id', 'desc');

        // Apply search filter
        if (!empty($search)) {
            $baseQuery->where(function ($query) use ($search) {
                $query->where('quote_number', 'like', "%$search%")
                    ->orWhereHas('brand', function ($query2) use ($search) {
                        $query2->where('name', 'like', "%$search%");
                    })
                    ->orWhereHas('generic', function ($query2) use ($search) {
                        $query2->where('name', 'like', "%$search%");
                    });

                // Handle date-only search (dd/mm/yyyy) on quotations.created_at
                if (preg_match('/^\d{2}\/\d{2}\/\d{4}$/', $search)) {
                    $dateParts = explode('/', $search);
                    if (count($dateParts) === 3) {
                        $formattedDate = "{$dateParts[2]}-{$dateParts[1]}-{$dateParts[0]}"; // Convert to YYYY-MM-DD
                        
                        if (strtotime($formattedDate)) {
                            $query->orWhereHas('quotations', function ($subQuery) use ($formattedDate) {
                                $subQuery->whereDate('created_at', '=', $formattedDate);
                            });
                        }
                    }
                }
                // Handle full datetime search (both hh:mm A and hh:mm:ss A) on quotations.created_at
                elseif (preg_match('/^\d{2}\/\d{2}\/\d{4} \d{2}:\d{2} [APap][Mm]$/', $search) || 
                        preg_match('/^\d{2}\/\d{2}\/\d{4} \d{2}:\d{2}:\d{2} [APap][Mm]$/', $search)) {
                    try {
                        // First, attempt parsing with seconds
                        $searchDate = null;
                        $startDate = null;
                        $endDate = null;

                        if (preg_match('/^\d{2}\/\d{2}\/\d{4} \d{2}:\d{2}:\d{2} [APap][Mm]$/', $search)) {
                            // Full datetime with seconds
                            $searchDate = Carbon::createFromFormat('d/m/Y h:i:s A', $search, 'Asia/Kolkata')
                                                ->setTimezone('UTC')
                                                ->format('Y-m-d H:i:s');
                        } else {
                            // Datetime without seconds (hh:mm A), search full minute range
                            $startDate = Carbon::createFromFormat('d/m/Y h:i A', $search, 'Asia/Kolkata')
                                                ->setTimezone('UTC')
                                                ->format('Y-m-d H:i:00');
                            $endDate = Carbon::createFromFormat('d/m/Y h:i A', $search, 'Asia/Kolkata')
                                                ->setTimezone('UTC')
                                                ->format('Y-m-d H:i:59');
                        }

                        if ($searchDate) {
                            $query->orWhereHas('quotations', function ($subQuery) use ($searchDate) {
                                $subQuery->where('created_at', '=', $searchDate);
                            });
                        } elseif ($startDate && $endDate) {
                            $query->orWhereHas('quotations', function ($subQuery) use ($startDate, $endDate) {
                                $subQuery->whereBetween('created_at', [$startDate, $endDate]);
                            });
                        }
                    } catch (\Exception $e) {
                        // Ignore invalid date formats
                    }
                }
            });
        }

        // Clone query for tab counts
        $openQuery = clone $baseQuery;
        $closeQuery = clone $baseQuery;
        $pendingQuery = clone $baseQuery;

        // Apply status filter
        if ($status === 'open') {
            $baseQuery->whereIn('status', ['open', 'reopen'])->whereHas('quotations');
        } elseif ($status === 'close') {
            $baseQuery->where('status', 'close');
        } elseif ($status === 'pending') {
            $baseQuery->where('status', 'pending');
        }
        
        // Get paginated results
        $inquires = $baseQuery->paginate($perPage)->appends([
            'search' => $search,
            'status' => $status,
            'perPage' => $perPage,
        ]);

        // Get dynamic counts
        $openAndReopenCount = $openQuery->whereIn('status', ['open', 'reopen'])->whereHas('quotations')->count();
        $closeCount = $closeQuery->where('status', 'close')->count();
        $pendingCount = $pendingQuery->where('status', 'pending')->count();

        // Fetch necessary data for display
        $brands = Products::all();
        $generics = Generic::all();
        $manufacturers = Manufacturer::all();
        $venders = Vender::all();
        $productVariants = ProductVariants::all();

        return view('quotations.index', compact(
            'inquires',
            'perPageOptions',
            'perPage',
            'search',
            'status',
            'brands',
            'generics',
            'manufacturers',
            'venders',
            'productVariants',
            'openAndReopenCount',
            'closeCount',
            'pendingCount'
        ));
    }

    // Show the form for creating a new resource.
    public function create(Request $request)
    {
        $id = $request->query('id');
        $inquire = Inquire::findOrFail($id);
        $brands = Products::all();
        $generics = Generic::all();
        $manufacturers = Manufacturer::all();
        $venders = Vender::all();
        $users = User::all();
        $productVariants = ProductVariants::all();
    
        $perPageOptions = [10, 25, 50, 100];
        $defaultPerPage = $perPageOptions[0]; // Default per page value
        $perPage = $request->input('perPage', $defaultPerPage);

        $inquireQuery = Inquire::with([
            'quotations', 
            'quotations.productDocuments', 
            'quotations.productPhotos',
            'quotations.suppliers',
            'brand',
            'generic',
        ])->where('id', $id);    

        $inquiryHistory = InquiryHistory::with([
            'quotationHistory',
            'quotationHistory.ProductDocumentHistory',
            'quotationHistory.ProductPhotoHistory',
            'quotationHistory.SupplierHistory',
            ])->where('inquiry_id', $id)
            ->orderBy('id', 'desc')
            ->get();

        $inquires = $inquireQuery->paginate($perPage);
        
        $redirectUrl = urldecode($request->query('redirect', url()->previous()));
        
        return view('quotations.create', compact('brands', 'inquire', 'inquires', 'generics', 'manufacturers', 'venders', 'inquiryHistory','perPageOptions', 'users', 'productVariants','perPage', 'redirectUrl'));
    }

    public function store(Request $request)
    {
        $validator = \Validator::make($request->all(), [
            'quotation.*.product_variant_id' => 'required',
            'quotation.*.gst' => 'nullable|string|max:15',
            'quotation.*.storage_condition' => 'nullable|string|max:255',
            'quotation.*.supplier.*.price_per_pack' => 'required|regex:/^\d{1,8}(\.\d{1,2})?$/',
            'quotation.*.supplier.*.lead_time' => 'required|integer|min:0|max:255',
            'quotation.*.supplier.*.expiry_date' => 'required|date_format:Y-m',
        ], [
            'quotation.*.product_variant_id.required' => 'The pack size field is required.',
            'quotation.*.supplier.*.price_per_pack.required' => 'The price per pack field is required.',
            'quotation.*.supplier.*.price_per_pack.regex' => 'The price per pack must be a valid number.',
            'quotation.*.supplier.*.lead_time.required' => 'The lead time field is required.',
            'quotation.*.supplier.*.lead_time.integer' => 'The lead time must be a valid number.',
            'quotation.*.supplier.*.lead_time.min' => 'The lead time must be a positive number.',
            'quotation.*.supplier.*.lead_time.max' => 'The lead time must be less than 255.',
            'quotation.*.supplier.*.expiry_date.required' => 'The expiry date field is required.',
            'quotation.*.supplier.*.expiry_date.date_format' => 'The expiry date does not match the format MM-YYYY.',
        ]);
        
        if ($validator->fails()) {
            return redirect()->back()->withInput()->withErrors($validator);
        }        

        // Validate and fetch the incoming request
        $quotations = $request->input('quotation', []);
        $hasPendingDetails = false; // Flag to check if any details are pending
        $inquire = Inquire::findOrFail($request->input('inquire_id'));

        if($inquire->type == 'brand'){
            $existingQuotation = Quotation::where('inquire_id', $inquire->id)->exists();
            if ($existingQuotation) {
                return redirect()
                    ->route('quotations.create', ['id' => $inquire->id, 'redirect' => urlencode(url()->full())])
                    ->with('error', 'A quotation for this brand inquiry already exists multiple quotations are not allowed!');
            }
        }

        // Dynamically check required fields from the inquire model
        $requiredFields = [
            'is_generic_name' => 'generic_id',
            'is_brand_name' => 'brand_id',
            'is_pack_size' => 'product_variant_id',
            'is_manufacturer_name' => 'manufacturer_id',
            'is_gst' => 'gst',
            'is_storage_condition' => 'storage_condition',
            'is_product_photo' => 'product_photos',
            'is_product_doc' => 'product_documents',
            'is_vendor_name' => 'supplier.*.vender_id',
            'is_price_per_pack' => 'supplier.*.price_per_pack',
            'is_expiry' => 'supplier.*.expiry_date',
            'is_lead_time' => 'supplier.*.lead_time',
        ];

        $requiredSupplierCount = $inquire->no_of_supplier; // Fetch required supplier count
        $quotationCount = count($quotations); // Count total quotation entries

        // Validate quotation count for "generic" type
        if ($inquire->type === 'generic' && $quotationCount < $inquire->no_of_brand) {
            $hasPendingDetails = true; // Not enough quotations for generic type
        }

        foreach ($quotations as $quotationIndex => $quotationData) {
            $quotation = new Quotation();
            $quotation->inquire_id = $request->input('inquire_id') ?? null;
            $quotation->generic_id = $quotationData['generic_id'] ?? null;
            $quotation->brand_id = $quotationData['brand_id'] ?? null;
            $quotation->manufacturer_id = $quotationData['manufacturer_id'] ?? null;
            $quotation->product_variant_id = $quotationData['product_variant_id'] ?? null;
            $quotation->gst = $quotationData['gst'] ?? null;
            $quotation->storage_condition = $quotationData['storage_condition'] ?? null;
            $quotation->created_by = Auth::id() ?? null;
            $quotation->save();

            // Validate required fields dynamically
            foreach ($requiredFields as $inquireField => $quotationField) {
                if ($inquire->$inquireField) {
                    $isFieldValid = validateField($quotationData, $quotationField, $request, $quotationIndex);
                    if (!$isFieldValid) {
                        $hasPendingDetails = true;
                    }
                }
            }

            // Validate supplier count and fields
            if (!empty($quotationData['supplier'])) {
                $supplierCount = count($quotationData['supplier']);

                if ($supplierCount < $requiredSupplierCount) {
                    $hasPendingDetails = true; // Not enough suppliers
                } else {
                    foreach ($quotationData['supplier'] as $supplierData) {
                        // Check if all required supplier fields are filled
                        if (
                            empty($supplierData['vender_id']) ||
                            empty($supplierData['price_per_pack']) ||
                            empty($supplierData['expiry_date']) ||
                            empty($supplierData['lead_time'])
                        ) {
                            $hasPendingDetails = true;
                        }
                    }
                }

                // Save supplier details
                foreach ($quotationData['supplier'] as $supplierData) {
                    Supplier::create([
                        'quotation_id' => $quotation->id,
                        'vender_id' => $supplierData['vender_id'] ?? null,
                        'price_per_pack' => $supplierData['price_per_pack'] ?? null,
                        'expiry_date' => $supplierData['expiry_date'] ?? null,
                        'lead_time' => $supplierData['lead_time'] ?? null,
                    ]);
                }
            } else {
                // If no supplier details, mark as pending
                $hasPendingDetails = true;
            }

            // Handle product photos
            if ($request->hasFile("quotation.$quotationIndex.product_photos")) {
                foreach ($request->file("quotation.$quotationIndex.product_photos") as $file) {
                    $fileName = time() . '_' . uniqid() . '.' . $file->extension();
                    $file->move(public_path('productPhotos'), $fileName);

                    ProductPhoto::create([
                        'quotation_id' => $quotation->id,
                        'photo' => $fileName,
                        'created_by' => Auth::id()
                    ]);
                }
            }

            // Handle product documents
            if ($request->hasFile("quotation.$quotationIndex.product_documents")) {
                foreach ($request->file("quotation.$quotationIndex.product_documents") as $file) {
                    $fileName = time() . '_' . uniqid() . '.' . $file->extension();
                    $file->move(public_path('productDocuments'), $fileName);

                    ProductDocument::create([
                        'quotation_id' => $quotation->id,
                        'document' => $fileName,
                        'created_by' => Auth::id()
                    ]);
                }
            }
        }

        // Set status based on the presence of pending details
        $inquiryStatus = $hasPendingDetails ? "pending" : "close";

        // Update inquire status
        $inquire->update([
            'status' => $inquiryStatus,
            'updated_by' => Auth::id(),
        ]);

        // Store the status history
        InquireStatusHistory::create([
            'inquiry_id' => $inquire->id,
            'status' => $inquiryStatus,
            'remarks' => $inquiryStatus === 'close' 
                    ? 'Closed by the system based on complete details'
                    : 'Pending due to incomplete details',
            'created_by' => Auth::id(),
        ]);

        $url = route('quotations.create', ['id' => $inquire->id, 'redirect' => urlencode(url()->full())]);

        $this->sendNotificationBasedOnStatus($inquire, $url);

        return redirect()->route('quotations.create', ['id' => $inquire->id, 'redirect' => urlencode(url()->full())])
            ->with('success', 'Quotation added successfully!');
    }

    // Show the form for editing the specified resource.
    public function edit(Request $request, string $id)
    {
        $inquire = Inquire::with([
            'quotations', 
            'quotations.productDocuments', 
            'quotations.productPhotos',    
            'quotations.suppliers', 
        ])->find($id);
   
        $perPageOptions = [10, 25, 50, 100];
        $defaultPerPage = $perPageOptions[0]; // Default per page value
        $perPage = $request->input('perPage', $defaultPerPage);
        
        $inquireQuery = Inquire::with([
            'quotations', 
            'quotations.productDocuments', 
            'quotations.productPhotos',
            'quotations.suppliers',
            'brand',
            'generic',
        ])->where('id', $id);

        $inquiryHistory = InquiryHistory::with([
            'quotationHistory',
            'quotationHistory.ProductDocumentHistory',
            'quotationHistory.ProductPhotoHistory',
            'quotationHistory.SupplierHistory',
            ])->where('inquiry_id', $id)
            ->orderBy('id', 'desc')
            ->get();

        $inquires = $inquireQuery->paginate($perPage);
        $brands = Products::all();
        $generics = Generic::all();
        $manufacturers = Manufacturer::all();
        $venders = Vender::all();
        $users = User::all();
        $productVariants = ProductVariants::all();

        $redirectUrl = urldecode($request->query('redirect', url()->previous()));

        return view('quotations.edit', compact('brands', 'inquire','inquires','generics', 'manufacturers', 'venders', 'inquiryHistory','perPageOptions', 'users', 'productVariants','perPage', 'redirectUrl'));
    }

    // Update the specified resource in storage.
    public function update(Request $request, string $id)
    {
        // -----------------------------------------------
        // 1) Validate or do basic checks
        // -----------------------------------------------
        $validator = Validator::make($request->all(), [
            'inquire_id' => 'required|exists:inquires,id',
            'existing.*.product_variant_id' => 'required',
            'existing.*.gst' => 'nullable|string|max:15',
            'existing.*.storage_condition' => 'nullable|string|max:255',
            'existing.*.supplier.*.price_per_pack' => 'required|regex:/^\d{1,8}(\.\d{1,2})?$/',
            'existing.*.supplier.*.lead_time' => 'required|integer|min:0|max:255',
            'existing.*.supplier.*.expiry_date' => 'required|date_format:Y-m',
            'new.*.product_variant_id' => 'required',
            'new.*.gst' => 'nullable|string|max:15',
            'new.*.storage_condition' => 'nullable|string|max:255',
            'new.*.supplier.*.price_per_pack' => 'required|regex:/^\d{1,8}(\.\d{1,2})?$/',
            'new.*.supplier.*.lead_time' => 'required|integer|min:0|max:255',
            'new.*.supplier.*.expiry_date' => 'required|date_format:Y-m',
        ], [
            'inquire_id.required' => 'The inquiry ID is required.',
            'inquire_id.exists' => 'The inquiry ID is invalid.',
            'existing.*.product_variant_id.required' => 'The pack size field is required.',
            'existing.*.supplier.*.price_per_pack.required' => 'The price per pack field is required.',
            'existing.*.supplier.*.price_per_pack.regex' => 'The price per pack must be a valid number.',
            'existing.*.supplier.*.lead_time.required' => 'The lead time field is required.',
            'existing.*.supplier.*.lead_time.integer' => 'The lead time must be a valid number.',
            'existing.*.supplier.*.lead_time.min' => 'The lead time must be a positive number.',
            'existing.*.supplier.*.lead_time.max' => 'The lead time must be less than 255.',
            'existing.*.supplier.*.expiry_date.required' => 'The expiry date field is required.',
            'existing.*.supplier.*.expiry_date.date_format' => 'The expiry date must be in the format MM-YYYY.',
            'new.*.product_variant_id.required' => 'The pack size field is required.',
            'new.*.supplier.*.price_per_pack.required' => 'The price per pack field is required.',
            'new.*.supplier.*.price_per_pack.regex' => 'The price per pack must be a valid number.',
            'new.*.supplier.*.lead_time.required' => 'The lead time field is required.',
            'new.*.supplier.*.lead_time.integer' => 'The lead time must be a valid number.',
            'new.*.supplier.*.lead_time.min' => 'The lead time must be a positive number.',
            'new.*.supplier.*.lead_time.max' => 'The lead time must be less than 255.',
            'new.*.supplier.*.expiry_date.required' => 'The expiry date field is required.',
            'new.*.supplier.*.expiry_date.date_format' => 'The expiry date must be in the format MM-YYYY.',
        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput();
        }

        // Retrieve the Inquiry
        $inquire = Inquire::findOrFail($request->input('inquire_id'));
        $hasPendingDetails = false;

        // -----------------------------------------------
        // 2) Retrieve "existing" data & files
        //    - "existing" => [ <quotationId> => [...], ... ]
        // -----------------------------------------------
        // Text-based data
        $existingQuotationsData = $request->input('existing', []);

        // File-based data
        // This will be an array like [ <quotationId> => ['product_photos' => [...UploadedFile...], 'product_documents' => [...], ... ], ... ]
        $existingQuotationsFiles = $request->file('existing', []);

        foreach ($existingQuotationsData as $quotationId => $quotationData) {
            // Find the existing Quotation
            $quotation = Quotation::find($quotationId);
            if (!$quotation) {
                continue; // skip or handle error
            }

            // Update Quotation text fields
            $quotation->brand_id           = $quotationData['brand_id']           ?? null;
            $quotation->generic_id         = $quotationData['generic_id']         ?? null;
            $quotation->product_variant_id = $quotationData['product_variant_id'] ?? null;
            $quotation->manufacturer_id    = $quotationData['manufacturer_id']    ?? null;
            $quotation->gst                = $quotationData['gst']                ?? null;
            $quotation->storage_condition  = $quotationData['storage_condition']  ?? null;
            $quotation->updated_by         = Auth::id();
            $quotation->save();

            // ---------------------------------
            // (A) Store Product Photos
            // ---------------------------------
            // Grab the file array from $existingQuotationsFiles
            $photoFiles = $existingQuotationsFiles[$quotationId]['product_photos'] ?? null;
            if (!empty($photoFiles) && is_array($photoFiles)) {
                foreach ($photoFiles as $photoFile) {
                    if ($photoFile instanceof UploadedFile) {
                        // Build a unique filename & move
                        $filename = time() . '_' . uniqid() . '.' . $photoFile->getClientOriginalExtension();
                        $photoFile->move(public_path('productPhotos'), $filename);

                        // Save record in product_photos table
                        ProductPhoto::create([
                            'quotation_id' => $quotation->id,
                            'photo'        => $filename,
                            'created_by'   => Auth::id(),
                        ]);
                    }
                }
            }

            // ---------------------------------
            // (B) Store Product Documents
            // ---------------------------------
            $docFiles = $existingQuotationsFiles[$quotationId]['product_documents'] ?? null;
            if (!empty($docFiles) && is_array($docFiles)) {
                foreach ($docFiles as $docFile) {
                    if ($docFile instanceof UploadedFile) {
                        $filename = time() . '_' . uniqid() . '.' . $docFile->getClientOriginalExtension();
                        $docFile->move(public_path('productDocuments'), $filename);

                        ProductDocument::create([
                            'quotation_id' => $quotation->id,
                            'document'     => $filename,
                            'created_by'   => Auth::id(),
                        ]);
                    }
                }
            }

            // ---------------------------------
            // (C) Update / Create Existing Suppliers
            // ---------------------------------
            // "supplier" => [ <supplierId or 'newKey'> => [id => X, vender_id => .., price_per_pack => ..] ]
            // Update or create suppliers for the existing quotation
              // Update suppliers for the quotation
            if (isset($quotationData['supplier']) && is_array($quotationData['supplier'])) {
                foreach ($quotationData['supplier'] as $supplierKey => $supplierData) {
                    if (!empty($supplierData['id'])) {
                        // Update existing supplier
                        $supplier = Supplier::find($supplierData['id']);
                        if ($supplier) {
                            $supplier->vender_id = $supplierData['vender_id'] ?? null;
                            $supplier->price_per_pack = $supplierData['price_per_pack'] ?? $supplier->price_per_pack;
                            $supplier->expiry_date = $supplierData['expiry_date'] ?? $supplier->expiry_date;
                            $supplier->lead_time = $supplierData['lead_time'] ?? $supplier->lead_time;
                            $supplier->updated_by = Auth::id();
                            $supplier->save();
                        }
                    } else {
                        // Create new supplier
                        Supplier::create([
                            'quotation_id' => $quotationId,
                            'vender_id' => $supplierData['vender_id'] ?? null,
                            'price_per_pack' => $supplierData['price_per_pack'] ?? null,
                            'expiry_date' => $supplierData['expiry_date'] ?? null,
                            'lead_time' => $supplierData['lead_time'] ?? null,
                            'created_by'   => Auth::id(),
                        ]);
                    }
                }
            }
        }

       // 1) Retrieve "new" data & "new" files as arrays.
        $newQuotationsData  = $request->input('new', []);

        // 2) Loop through each Quotation entry
        foreach ($newQuotationsData as $index => $quotationData) {
            $photoFiles = data_get($request->file('new'), "$index.product_photos", []);
  
            $docFiles   = data_get($request->file('new'), "$index.product_documents", []);
            // Create new Quotation
            $quotation = new Quotation();
            $quotation->inquire_id         = $inquire->id;
            $quotation->brand_id           = $quotationData['brand_id']           ?? null;
            $quotation->generic_id         = $quotationData['generic_id']         ?? null;
            $quotation->product_variant_id = $quotationData['product_variant_id'] ?? null;
            $quotation->manufacturer_id    = $quotationData['manufacturer_id']    ?? null;
            $quotation->gst                = $quotationData['gst']                ?? null;
            $quotation->storage_condition  = $quotationData['storage_condition']  ?? null;
            $quotation->created_by         = Auth::id();
            $quotation->save();

            // 2) Handle Product Photos
            $photoFiles = data_get($request->file('new'), "$index.product_photos", []);
            foreach ($photoFiles as $photoFile) {
                if ($photoFile && $photoFile->isValid()) {
                    $filename = time() . '_' . uniqid() . '.' . $photoFile->getClientOriginalExtension();
                    $photoFile->move(public_path('productPhotos'), $filename);

                    ProductPhoto::create([
                        'quotation_id' => $quotation->id,
                        'photo'        => $filename,
                        'created_by'   => Auth::id(),
                    ]);
                }
            }

            // 3) Handle Product Documents
            $docFiles = data_get($request->file('new'), "$index.product_documents", []);
            foreach ($docFiles as $docFile) {
                if ($docFile && $docFile->isValid()) {
                    $filename = time() . '_' . uniqid() . '.' . $docFile->getClientOriginalExtension();
                    $docFile->move(public_path('productDocuments'), $filename);

                    ProductDocument::create([
                        'quotation_id' => $quotation->id,
                        'document'     => $filename,
                        'created_by'   => Auth::id(),
                    ]);
                }
            }

            // 4) Handle Suppliers
            if (!empty($quotationData['supplier']) && is_array($quotationData['supplier'])) {
                foreach ($quotationData['supplier'] as $supplierData) {
                    Supplier::create([
                        'quotation_id'   => $quotation->id,
                        'vender_id'      => $supplierData['vender_id']      ?? null,
                        'price_per_pack' => $supplierData['price_per_pack'] ?? null,
                        'expiry_date'    => $supplierData['expiry_date']    ?? null,
                        'lead_time'      => $supplierData['lead_time']      ?? null,
                    ]);
                }
            }
        }
    
        // --------------------------------------------------------
        // 5) DETERMINE IF INQUIRY IS COMPLETE OR HAS PENDING DETAILS
        // --------------------------------------------------------
        // ... (Your logic to check if each Quotation meets the required fields,
        //     supplier counts, product photos, etc.)
        // If anything is incomplete, set $hasPendingDetails = true;
    
        // Example: check if at least no_of_brand quotations are fully complete
        // for a generic inquiry, or if all must be complete for brand type, etc.
        // (Pseudocode below — adapt to your needs.)
        $allQuotations = Quotation::where('inquire_id', $inquire->id)->get();
        if ($inquire->type === 'generic') {
            $completedCount = 0;
            foreach ($allQuotations as $quotation) {
                if ($this->isQuotationComplete($quotation, $inquire)) {
                    $completedCount++;
                }
            }
            if ($completedCount < $inquire->no_of_brand) {
                $hasPendingDetails = true;
            }
        } else {
            // Some other logic: if any Quotation is incomplete => pending
            foreach ($allQuotations as $quotation) {
                if (!$this->isQuotationComplete($quotation, $inquire)) {
                    $hasPendingDetails = true;
                    break;
                }
            }
        }
    
        // --------------------------------------------------------
        // 6) UPDATE INQUIRY STATUS & SAVE HISTORY
        // --------------------------------------------------------
        $inquire->status     = $hasPendingDetails ? 'pending' : 'close';
        $inquire->updated_by = Auth::id();
        $inquire->save();
    
        InquireStatusHistory::create([
            'inquiry_id' => $inquire->id,
            'status'     => $inquire->status,
            'remarks'    => $hasPendingDetails
                ? 'Pending due to incomplete details'
                : 'Closed by the system based on complete details',
            'created_by' => Auth::id(),
        ]);
    
        // --------------------------------------------------------
        // 7) REDIRECT WITH SUCCESS MESSAGE
        // --------------------------------------------------------
        $redirectUrl = urldecode($request->input('redirect', route('home')));

        // Send notification based on status
        $this->sendNotificationBasedOnStatus($inquire, $redirectUrl);

        return redirect($redirectUrl)->with('success', 'Quotation updated successfully.');
    }
    
    /**
     * Example helper method to check if a quotation is "complete"
     * based on the inquire's required fields. Adjust as needed.
     */
    private function isQuotationComplete(Quotation $quotation, Inquire $inquire): bool
    {
        // Check required fields at Quotation level:
        if ($inquire->is_brand_name && empty($quotation->brand_id)) {
            return false;
        }
        if ($inquire->is_generic_name && empty($quotation->generic_id)) {
            return false;
        }
        if ($inquire->is_pack_size && empty($quotation->product_variant_id)) {
            return false;
        }
        if ($inquire->is_manufacturer_name && empty($quotation->manufacturer_id)) {
            return false;
        }
        if ($inquire->is_gst && empty($quotation->gst)) {
            return false;
        }
        if ($inquire->is_storage_condition && empty($quotation->storage_condition)) {
            return false;
        }
    
        // Check product photos
        if ($inquire->is_product_photo) {
            $photoCount = ProductPhoto::where('quotation_id', $quotation->id)->count();
            if ($photoCount < 1) {
                return false;
            }
        }
    
        // Check product documents
        if ($inquire->is_product_doc) {
            $docCount = ProductDocument::where('quotation_id', $quotation->id)->count();
            if ($docCount < 1) {
                return false;
            }
        }
    
        // Check suppliers
        $supplierCount = Supplier::where('quotation_id', $quotation->id)->count();
        if (!empty($inquire->no_of_supplier) && $supplierCount < $inquire->no_of_supplier) {
            return false;
        }
    
        // Validate each supplier's required fields
        if ($inquire->is_vendor_name || $inquire->is_price_per_pack || $inquire->is_expiry || $inquire->is_lead_time) {
            $suppliers = Supplier::where('quotation_id', $quotation->id)->get();
            foreach ($suppliers as $supplier) {
                if ($inquire->is_vendor_name && empty($supplier->vender_id)) {
                    return false;
                }
                if ($inquire->is_price_per_pack && empty($supplier->price_per_pack)) {
                    return false;
                }
                if ($inquire->is_expiry && empty($supplier->expiry_date)) {
                    return false;
                }
                if ($inquire->is_lead_time && empty($supplier->lead_time)) {
                    return false;
                }
            }
        }
    
        return true; 
    }

    public function photoDestroy(string $id)
    {
        try {
            $productPhoto = ProductPhoto::findOrFail($id);
            $productPhoto->delete();
                
            return response()->json(['message' => 'Product photo deleted successfully.']);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Unable to delete photo.'], 500);
        }
    }

    public function documentDestroy(string $id)
    {
        try {
            $productDocument = ProductDocument::findOrFail($id);
            $productDocument->delete();
                
            return response()->json(['message' => 'Product document deleted successfully.']);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Unable to delete product.'], 500);
        }
    } 

    public function supplierDestroy(string $id)
    {
        try {
            $supplier = Supplier::findOrFail($id);
            $supplier->delete();
                
            return response()->json(['message' => 'Supplier deleted successfully.']);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Unable to delete supplier.'], 500);
        }
    }

    public function show(Request $request, string $id)
    {
        $quotation = Quotation::with([
            'productDocuments',
            'productPhotos',
            'suppliers'
        ])->find($id);

        $perPageOptions = [10, 25, 50, 100];
        $defaultPerPage = $perPageOptions[0]; // Default per page value
        $perPage = $request->input('perPage', $defaultPerPage);
        
        $quotationQuery = Quotation::with([
            'productDocuments',
            'productPhotos',
            'suppliers'
        ])->where('inquire_id', $quotation->inquire_id);

        $inquiryHistory = InquiryHistory::with([
            'quotationHistory',
            'quotationHistory.ProductDocumentHistory',
            'quotationHistory.ProductPhotoHistory',
            'quotationHistory.SupplierHistory',
            ])->where('inquiry_id', $quotation->inquire_id)
            ->orderBy('id', 'desc')
            ->get();
        
        $inquireStatusHistory = InquireStatusHistory::where('inquiry_id', $quotation->inquire_id)
            ->where('status', 'close')
            ->where('is_manually', 1)
            ->orderBy('id', 'desc')
            ->get();
 
        $quotations = $quotationQuery->paginate($perPage);
        $inquire = Inquire::findOrFail($quotation->inquire_id);
        $brands = Products::all();
        $generics = Generic::all();
        $manufacturers = Manufacturer::all();
        $venders = Vender::all();
        $users = User::all();
        $productVariants = ProductVariants::all();

        $redirectUrl = urldecode($request->query('redirect', url()->previous()));

        return view('quotations.show', compact('brands', 'inquire', 'generics', 'manufacturers', 'venders', 'quotation', 'quotations', 'inquiryHistory', 'inquireStatusHistory','perPageOptions', 'users', 'productVariants','perPage', 'redirectUrl'));
    }

    public function getPackSizes($brandId)
    {
        $packSizes = ProductVariants::where('product_id', $brandId)->get();

        return response()->json($packSizes);
    }

    private function sendNotificationBasedOnStatus($inquire, $redirectUrl)
    {
        $brandOrGenericName = $this->getBrandOrGenericName($inquire);
        $notificationDetails = $this->getNotificationDetails($inquire->status, $inquire->quote_number, $brandOrGenericName);

        if ($notificationDetails) {
            $this->sendNotification(
                $inquire->created_by,
                $notificationDetails['heading'],
                $notificationDetails['content'],
                $redirectUrl
            );
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
            'pending' => [
                'heading' => "$quoteNo $brandOrGenericName Partial Quotation Created!!",
                'content' => "Vendor's not giving a complete quotation—looks like we’re playing hide and seek with the details!",
            ],
            'close' => [
                'heading' => "$quoteNo $brandOrGenericName Complete Quote Created!!",
                'content' => "Finally, all the details are in one place, like a perfectly organized recipe!",
            ],
        ];

        return $details[$status] ?? null; // Return null if the status is not recognized
    }

    private function sendNotification($user_id, $heading, $content, $url)
    {
        // Filter only active users
        $user_ids = User::whereIn('id', [$user_id])
            ->where('status', '!=', 0) 
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

    public function destroy($id)
    {
        $quotation = Quotation::find($id);
    
        if (!$quotation) {
            return response()->json(['error' => 'Quotation not found'], 404);
        }
    
        $quotation->delete();
    
        return response()->json(['message' => 'Brand deleted successfully']);
    }
}