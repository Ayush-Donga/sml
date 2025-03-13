<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use App\Models\Configurations;
use App\Models\Generic;
use App\Models\Inquire;
use App\Models\InquireStatusHistory;
use App\Models\Products;
use App\Models\User;
use App\Models\Quotation;
use App\Models\InquiryHistory;
use App\Models\QuotationHistory;
use App\Models\ProductPhotoHistory;
use App\Models\ProductDocumentHistory;
use App\Models\SupplierHistory;
use App\Services\OneSignalService;
use App\Models\UserDeviceToken;
use App\Models\Notification;

class InquireController extends Controller
{
    protected $oneSignalService;
    
    public function __construct(OneSignalService $oneSignalService)
    {
        $this->middleware('permission:inquire-list', ['only' => ['index', 'show']]);
        $this->middleware('permission:inquire-create', ['only' => ['create', 'store']]);
        $this->middleware('permission:inquire-edit', ['only' => ['edit', 'update']]);
        $this->middleware('permission:inquire-delete', ['only' => ['destroy']]);
        $this->oneSignalService = $oneSignalService;
    }

    // Display a listing of the resource.
    public function index(Request $request)
    {
        $perPageOptions = [10, 25, 50, 100];
        $defaultPerPage = $perPageOptions[0]; // Default per page
        $perPage = $request->input('perPage', $defaultPerPage);
        $search = $request->input('search', '');
       
        if (! in_array($perPage, $perPageOptions)) {
            $perPage = $defaultPerPage;
        }
    
        $page = (int) $request->input('page', 1);
    
        // Build the query
        $inquireQuery = Inquire::orderBy('id', 'desc');
    
        if (!empty($search)) {
            $inquireQuery->where(function ($query) use ($search) {
                $query->where('type', 'like', "%$search%")
                    ->orWhere('quantity', 'like', "%$search%")
                    ->orWhere('quote_number', 'like', "%$search%")
                    ->orWhere('status', 'like', "%$search%")
                    ->orWhereHas('generic', function ($q) use ($search) {
                        $q->where('name', 'like', "%$search%");
                    })
                    ->orWhereHas('brand', function ($q) use ($search) {
                        $q->where('name', 'like', "%$search%");
                    })
                    ->orWhereHas('assignedUser', function ($q) use ($search) {
                        $q->where('name', 'like', "%$search%");
                    })
                    ->orWhere('no_of_supplier', 'like', "%$search%")
                    ->orWhere('no_of_brand', 'like', "%$search%")
                    ->orWhere('created_by', 'like', "%$search%");

                // Convert search input date to database format
                if (preg_match('/\d{2}\/\d{2}\/\d{4}/', $search)) {
                    $dateParts = explode('/', $search);
                    if (count($dateParts) === 3) {
                        $formattedDate = "{$dateParts[2]}-{$dateParts[1]}-{$dateParts[0]}"; // Convert dd/mm/yyyy to yyyy-mm-dd
                        $query->orWhereDate('creation_date', $formattedDate);
                    }
                }
            });
        }
    
        // Exclude Inquires linked to a Quotation
        $usedInquireIds = Quotation::pluck('inquire_id')->toArray();
        $inquireQuery->whereNotIn('id', $usedInquireIds);
    
        // Permissions logic
        $user = Auth::user();
        $parents = User::where('parent_id', $user->id)->pluck('id')->toArray();
        $canListBDDepartment = $user->can('bd-department-list');
        $canEditBDDepartment = $user->can('bd-department-edit');
    
        if (!$canListBDDepartment && $canEditBDDepartment) {
            // Show inquires created by current authenticated user and their children
            $inquireQuery->where(function($q) use ($user, $parents) {
                $q->where('created_by', $user->id)
                  ->orWhereIn('created_by', $parents);
            });
        }
    
        $count = $inquireQuery->count();
        $lastPage = ($count === 0)
            ? 1
            : (int) ceil($count / $perPage);

        if ($page > $lastPage) {
            $page = $lastPage;
        }

        $inquires = $inquireQuery->paginate($perPage, ['*'], 'page', $page);
    
        $brands    = Products::all();
        $generics  = Generic::all();
        $users     = User::all();
    
        if ($request->ajax()) {
            return view('inquires.partials.inquire_table', compact('inquires','brands','generics','users'))
                   ->render();
        }

        return view('inquires.index', compact(
            'inquires',
            'brands',
            'generics',
            'users',
            'perPageOptions',
            'perPage',
            'search'
        ));
    }    

    // Show the form for creating a new resource.
    public function create(Request $request)
    {
        $brands = Products::all();
        $generics = Generic::all();
        $redirectUrl = urldecode($request->query('redirect', url()->previous()));

        return view('inquires.create', compact('brands','generics','redirectUrl'));
    }

    // Store a newly created resource in storage.
    public function store(Request $request)
    {
        // Validate the request data
        $validatedData = $request->validate([
            'type' => 'required|string|in:brand,generic',
            'brand_id' => 'required_if:type,brand|nullable|integer',
            'generic_id' => 'required_if:type,generic|nullable|integer',
            'quantity' => 'required|integer|min:1|max:1000000',
            'no_of_supplier' => 'required|integer|min:1|max:10000',
            'no_of_brand' => [
                'nullable', 
                'required_if:type,generic',
                'integer',
                'min:1',
                'max:10000',
            ],
        ],[
            'brand_id.required_if' => 'The brand name field is required when type is brand.',
            'generic_id.required_if' => 'The generic name field is required when type is generic.',
        ]);
       
        // Check for duplicate record
        $existingInquire = Inquire::where('brand_id', $validatedData['brand_id'])
        ->where('generic_id', $validatedData['generic_id'])
        ->latest('id')
        ->first();

        if ($existingInquire) {
            if (in_array($existingInquire->status, ['open', 'reopen','pending'])) {
                return redirect()->back()->with([
                    'error' => "This inquiry already exists with the status {$existingInquire->status}."
                ]);
            }
        
            DB::transaction(function () use ($existingInquire, $request) {
                // dd($existingInquire->id);
                $inquiresHistoriesData = [
                    'inquiry_id'             => $existingInquire->id ?? null,
                    'type'                   => $existingInquire->type ?? null,
                    'brand_id'               => $existingInquire->brand_id ?? null,
                    'generic_id'             => $existingInquire->generic_id ?? null,
                    'quantity'               => $existingInquire->quantity ?? null,
                    'quote_number'           => $existingInquire->quote_number ?? null,
                    'assigned_user_id'       => $existingInquire->assigned_user_id ?? null,
                    'status'                 => $existingInquire->status ?? null,
                    'no_of_supplier'         => $existingInquire->no_of_supplier ?? null,
                    'no_of_brand'            => $existingInquire->no_of_brand ?? null,
                    'is_generic_name'        => $existingInquire->is_generic_name ?? null,
                    'is_brand_name'          => $existingInquire->is_brand_name ?? null,
                    'is_pack_size'           => $existingInquire->is_pack_size ?? null,
                    'is_manufacturer_name'   => $existingInquire->is_manufacturer_name ?? null,
                    'is_gst'                => $existingInquire->is_gst ?? null,
                    'is_storage_condition'   => $existingInquire->is_storage_condition ?? null,
                    'is_product_photo'       => $existingInquire->is_product_photo ?? null,
                    'is_product_doc'         => $existingInquire->is_product_doc ?? null,
                    'is_vendor_name'         => $existingInquire->is_vendor_name ?? null,
                    'is_price_per_pack'      => $existingInquire->is_price_per_pack ?? null,
                    'is_lead_time'           => $existingInquire->is_lead_time ?? null,
                    'is_expiry'              => $existingInquire->is_expiry ?? null,
                    'created_by'             => $existingInquire->created_by ?? null,
                    'created_at'             => $existingInquire->creation_date ?? now(),
                ];
                
                $inquiryHistory = InquiryHistory::create($inquiresHistoriesData);
                $inquiryHistory->created_at = $existingInquire->creation_date ?? now();
                $inquiryHistory->save();
                
                $quotations = Quotation::with(['productDocuments', 'productPhotos', 'suppliers'])
                    ->where('inquire_id', $existingInquire->id)
                    ->get();

                $productPhotosHistories = [];
                $productDocumentsHistories = [];
                $suppliersHistories = [];

                foreach ($quotations as $quotation) {
                    $quotationHistory = QuotationHistory::create([
                        'inquiry_history_id' => $inquiryHistory->id,
                        'generic_id'         => $quotation->generic_id,
                        'brand_id'           => $quotation->brand_id,
                        'manufacturer_id'    => $quotation->manufacturer_id,
                        'product_variant_id' => $quotation->product_variant_id ,
                        'gst'                => $quotation->gst,
                        'storage_condition'  => $quotation->storage_condition,
                        'created_by'         => $quotation->created_by,
                        'created_at'         => $quotation->created_at,
                    ]);

                    $quotationHistory->created_at = $quotation->created_at ?? now();
                    $quotationHistory->save();
                
                    // For product photos
                    $productPhotosHistories = array_merge($productPhotosHistories, array_map(function ($photo) use ($quotationHistory) {
                        return [
                            'quotation_history_id' => $quotationHistory->id,
                            'photo'                => $photo->photo, // Access as object, not array
                            'created_by'           => $photo->created_by,
                        ];
                    }, $quotation->productPhotos->all())); // Use ->all() to get the collection as an array
                
                    // For product documents
                    $productDocumentsHistories = array_merge($productDocumentsHistories, array_map(function ($document) use ($quotationHistory) {
                        return [
                            'quotation_history_id' => $quotationHistory->id,
                            'document'             => $document->document,
                            'created_by'           => $document->created_by,
                        ];
                    }, $quotation->productDocuments->all())); // Use ->all() to get the collection as an array
                
                    // For suppliers
                    $suppliersHistories = array_merge($suppliersHistories, array_map(function ($supplier) use ($quotationHistory) {
                        return [
                            'quotation_history_id' => $quotationHistory->id,
                            'vender_id'            => $supplier->vender_id,
                            'price_per_pack'       => $supplier->price_per_pack,
                            'expiry_date'          => $supplier->expiry_date,
                            'lead_time'            => $supplier->lead_time,
                            'created_by'           => $supplier->created_by,
                        ];
                    }, $quotation->suppliers->all())); // Use ->all() to get the collection as an array
                }
                
                if ($productPhotosHistories) ProductPhotoHistory::insert($productPhotosHistories);
                if ($productDocumentsHistories) ProductDocumentHistory::insert($productDocumentsHistories);
                if ($suppliersHistories) SupplierHistory::insert($suppliersHistories);

                // Update inquire status to 'reopen'
                $data = $request->all();
                foreach ($data as $key => $value) {
                    if ($value === 'true') {
                        $data[$key] = true;
                    } elseif ($value === 'false') {
                        $data[$key] = false;
                    }
                }

                if ($data['type'] === 'brand') {
                    $data['brand_id'] = $data['brand_id'] ?? null;
                    $data['generic_id'] = null;
                } elseif ($data['type'] === 'generic') {
                    $data['generic_id'] = $data['generic_id'] ?? null;
                    $data['brand_id'] = null;
                } else {
                    $data['brand_id'] = null;
                    $data['generic_id'] = null;
                }
                $data['status'] =  'reopen';
                if ($data['status'] === 'reopen') {
                    $data['assigned_user_id'] = null; 
                }
                $data['creation_date'] = now();
                $data['updated_by'] = Auth::id();

                $existingInquire->update($data);
                // Log inquire status history
                InquireStatusHistory::create([
                    'inquiry_id' => $existingInquire->id,
                    'status'     => 'reopen',
                    'created_by' => Auth::id(),
                ]);
                // Delete records from the main tables after creating the history
                foreach ($quotations as $quotation) {
                    // Delete product photos, documents, and suppliers
                    $quotation->productPhotos()->delete();
                    $quotation->productDocuments()->delete();
                    $quotation->suppliers()->delete();
                }
                
                // Finally, delete the quotations themselves
                $quotations->each->delete();
            });

            return redirect(urldecode($request->input('redirect')))->with([
                'success' => "Inquire reopen successfully."
            ]);
        } else {
             // Get the last used quote number configuration
            $configuration = Configurations::where('code', 'AUTO_GENERATED_QUOTE_NO')->first();
            $lastQuoteNo = $configuration->value;
            $numericPart = (int)filter_var($lastQuoteNo, FILTER_SANITIZE_NUMBER_INT);
            $newQuoteNoValue = $numericPart + 1;
            $newQuoteNo = $configuration->name . $newQuoteNoValue;
            // Update the configuration with the new quote number value
            $configuration->value = $newQuoteNoValue;
            $configuration->save();
            $data = $request->all();
           
            foreach ($data as $key => $value) {
                if ($value === 'true') {
                    $data[$key] = true;
                } elseif ($value === 'false') {
                    $data[$key] = false;
                }
            }
            // Add the generated quote number to the data
            $data['quote_number'] = $newQuoteNo;
            $data['creation_date'] = now();
            $data['created_by'] = Auth::id();
            // Create a new Inquire record
             Inquire::create($data);
            // Redirect with success message
            $redirectUrl = urldecode($request->input('redirect'));

            $user_ids = User::whereHas('roles', function ($query) {
                $query->whereIn('type', ['PURCHASE']);
            })->where('status', '!=', 0)->pluck('id')->toArray();
    
            $player_ids = UserDeviceToken::whereIn('user_id', $user_ids)->pluck('player_id')->toArray();
    
            if (empty($player_ids)) {
                \Log::warning('No player_ids found for the users', ['user_ids' => $user_ids]);
            } else {
                $heading = $newQuoteNo." Inquiry created";
                $content = "Let's hope the answer is better than our Wi-Fi signal!!";
                
                $this->oneSignalService->sendNotification($player_ids, $heading, $content, $redirectUrl);
        
                // Store the notification in the database for each user
                foreach ($user_ids as $user_id) {
                Notification::create([
                        'user_id' => $user_id,
                        'heading' => $heading,
                        'content' => $content,
                        'url' => $redirectUrl,
                        'is_read' => false,
                    ]);
                }
            }
            
            return redirect($redirectUrl)->with('success', 'Inquire created successfully.');
        }
    }
    
    // Show the form for editing the specified resource.
    public function edit(Request $request, Inquire $inquire)
    {
        $brands = Products::all();
        $generics = Generic::all();
        $redirectUrl = urldecode($request->query('redirect', url()->previous()));

        return view('inquires.edit', compact('inquire','brands','generics','redirectUrl'));
    }

    // Update the specified resource in storage.
    public function update(Request $request, Inquire $inquire)
    {
        // 1. Validate the request
        $validatedData = $request->validate([
            'type' => 'required|string|in:brand,generic',
            'brand_id' => [
                'required_if:type,brand',
                'nullable',
                'integer',
            ],
            'generic_id' => [
                'required_if:type,generic',
                'nullable',
                'integer',
            ],
            'quantity' => 'required|integer|min:1|max:1000000',
            'no_of_supplier' => 'required|integer|min:1|max:10000',
            'no_of_brand' => [
                'nullable',
                'required_if:type,generic',
                'integer',
                'min:1',
                'max:10000',
            ],
        ], [
            'brand_id.required_if' => 'The brand name field is required when type is brand.',
            'generic_id.required_if' => 'The generic name field is required when type is generic.',
        ]);

        // 2. Convert 'true'/'false' strings to booleans in the incoming data
        $data = $request->all();
        foreach ($data as $key => $value) {
            if ($value === 'true') {
                $data[$key] = true;
            } elseif ($value === 'false') {
                $data[$key] = false;
            }
        }

        // 3. Ensure only one of brand_id / generic_id is set based on type
        if ($data['type'] === 'brand') {
            $data['generic_id'] = null;
        } elseif ($data['type'] === 'generic') {
            $data['brand_id'] = null;
        } else {
            $data['brand_id'] = null;
            $data['generic_id'] = null;
        }

        // 4. Check if there is an *existing* inquiry with same brand/generic
        //    (excluding the current one)
        $existingInquire = Inquire::query()
            ->when($data['type'] === 'brand', function ($q) use ($data) {
                return $q->where('brand_id', $data['brand_id']);
            })
            ->when($data['type'] === 'generic', function ($q) use ($data) {
                return $q->where('generic_id', $data['generic_id']);
            })
            ->where('id', '!=', $inquire->id)
            ->latest('id')
            ->first();

        // 5. If an inquiry with the same brand/generic was found, handle statuses
        if ($existingInquire) {
            // A. If the inquiry is open/reopen/pending, return error
            if (in_array($existingInquire->status, ['open', 'reopen', 'pending'])) {
                return redirect()->back()
                                ->with(['error' => "This inquiry already exists with the status {$existingInquire->status}."]);
            }

            // B. If the inquiry is close, we want to REOPEN it
            if ($existingInquire->status === 'close') {
                DB::transaction(function () use ($existingInquire, $data, $request) {

                    // 1. Create inquiry history
                    $inquiryHistoryData = [
                        'inquiry_id'           => $existingInquire->id,
                        'type'                 => $existingInquire->type,
                        'brand_id'             => $existingInquire->brand_id,
                        'generic_id'           => $existingInquire->generic_id,
                        'quantity'             => $existingInquire->quantity,
                        'quote_number'         => $existingInquire->quote_number,
                        'assigned_user_id'     => $existingInquire->assigned_user_id,
                        'status'               => $existingInquire->status,
                        'no_of_supplier'       => $existingInquire->no_of_supplier,
                        'no_of_brand'          => $existingInquire->no_of_brand,
                        'is_generic_name'      => $existingInquire->is_generic_name,
                        'is_brand_name'        => $existingInquire->is_brand_name,
                        'is_pack_size'         => $existingInquire->is_pack_size,
                        'is_manufacturer_name' => $existingInquire->is_manufacturer_name,
                        'is_gst'               => $existingInquire->is_gst,
                        'is_storage_condition' => $existingInquire->is_storage_condition,
                        'is_product_photo'     => $existingInquire->is_product_photo,
                        'is_product_doc'       => $existingInquire->is_product_doc,
                        'is_vendor_name'       => $existingInquire->is_vendor_name,
                        'is_price_per_pack'    => $existingInquire->is_price_per_pack,
                        'is_lead_time'         => $existingInquire->is_lead_time,
                        'is_expiry'            => $existingInquire->is_expiry,
                        'created_by'           => $existingInquire->created_by,
                        'created_at'           => $existingInquire->creation_date ?? now(),
                    ];
                    $inquiryHistory = InquiryHistory::create($inquiryHistoryData);
                    $inquiryHistory->created_at = $existingInquire->creation_date ?? now();
                    $inquiryHistory->save();

                    // 2. Move quotations and their related data to histories
                    $quotations = Quotation::with(['productDocuments', 'productPhotos', 'suppliers'])
                                        ->where('inquire_id', $existingInquire->id)
                                        ->get();

                    $productPhotosHistories    = [];
                    $productDocumentsHistories = [];
                    $suppliersHistories        = [];

                    foreach ($quotations as $quotation) {
                        // Quotation History
                        $quotationHistory = QuotationHistory::create([
                            'inquiry_history_id' => $inquiryHistory->id,
                            'generic_id'         => $quotation->generic_id,
                            'brand_id'           => $quotation->brand_id,
                            'manufacturer_id'    => $quotation->manufacturer_id,
                            'product_variant_id' => $quotation->product_variant_id,
                            'gst'                => $quotation->gst,
                            'storage_condition'  => $quotation->storage_condition,
                            'created_by'         => $quotation->created_by,
                            'created_at'         => $quotation->created_at,
                        ]);

                        $quotationHistory->created_at = $quotation->created_at ?? now();
                        $quotationHistory->save();

                        // Product Photos
                        if ($quotation->productPhotos->count()) {
                            foreach ($quotation->productPhotos as $photo) {
                                $productPhotosHistories[] = [
                                    'quotation_history_id' => $quotationHistory->id,
                                    'photo'                => $photo->photo,
                                    'created_by'           => $photo->created_by,
                                ];
                            }
                        }

                        // Product Documents
                        if ($quotation->productDocuments->count()) {
                            foreach ($quotation->productDocuments as $document) {
                                $productDocumentsHistories[] = [
                                    'quotation_history_id' => $quotationHistory->id,
                                    'document'             => $document->document,
                                    'created_by'           => $document->created_by,
                                ];
                            }
                        }

                        // Suppliers
                        if ($quotation->suppliers->count()) {
                            foreach ($quotation->suppliers as $supplier) {
                                $suppliersHistories[] = [
                                    'quotation_history_id' => $quotationHistory->id,
                                    'vender_id'            => $supplier->vender_id,
                                    'price_per_pack'       => $supplier->price_per_pack,
                                    'expiry_date'          => $supplier->expiry_date,
                                    'lead_time'            => $supplier->lead_time,
                                    'created_by'           => $supplier->created_by,
                                ];
                            }
                        }
                    }

                    // 3. Insert product photos/documents/suppliers in bulk
                    if (!empty($productPhotosHistories)) {
                        ProductPhotoHistory::insert($productPhotosHistories);
                    }
                    if (!empty($productDocumentsHistories)) {
                        ProductDocumentHistory::insert($productDocumentsHistories);
                    }
                    if (!empty($suppliersHistories)) {
                        SupplierHistory::insert($suppliersHistories);
                    }

                    // 4. Update the old (closed) inquiry to 'reopen'
                    $data['status']           = 'reopen';
                    $data['creation_date']    = now();
                    $data['assigned_user_id'] = null;
                    $data['updated_by']       = Auth::id();
                    if ($data['type'] === 'brand') {
                        $data['no_of_brand'] = null;
                    }
                    $existingInquire->update($data);

                    // 5. Log status history
                    InquireStatusHistory::create([
                        'inquiry_id' => $existingInquire->id,
                        'status'     => 'reopen',
                        'created_by' => Auth::id(),
                    ]);

                    // 6. Delete the old quotations from main tables
                    foreach ($quotations as $quotation) {
                        $quotation->productPhotos()->delete();
                        $quotation->productDocuments()->delete();
                        $quotation->suppliers()->delete();
                        $quotation->delete();
                    }
                });

                // After reopen, redirect out
                return redirect(urldecode($request->input('redirect')))
                    ->with(['success' => "Inquire reopened successfully."]);
            }
        }

        // 6. If NO existing inquiry or none matched the criteria for reopen,
        //    simply update THIS inquire
        $data['updated_by'] = Auth::id();
        $inquire->update($data);

        return redirect(urldecode($request->input('redirect')))
            ->with('success', 'Inquire updated successfully.');
    }

    // Remove the specified resource from storage.
    public function destroy($id)
    {
        try {
            $inquire = Inquire::findOrFail($id);
            if ($inquire->status == "reopen") {
                return response()->json(['error' => 'This inquire is reopen not deleted.']);
            } else {
                $inquire->delete();

                return response()->json(['message' => 'Inquire deleted successfully.']);
            }
        } catch (\Exception $e) {
            return response()->json(['error' => 'Unable to delete inquire.'], 500);
        }
    }

    public function assignInquire(Request $request, $id)
    {
        $inquire = Inquire::find($id);
    
        if (!$inquire) {
            return response()->json(['error' => 'Inquire not found.'], 404);
        }
    
        // Check if the inquire is already assigned
        if ($inquire->assigned_user_id) {
            return response()->json(['error' => 'Inquire has already been assigned.'], 400);
        }
    
        try {
            $inquire->update([
                'assigned_user_id' => Auth::id(),
            ]);
    
            return response()->json([
                'success' => true,
                'message' => 'Inquire assigned successfully',
                'redirect' => route('quotations.create', ['id' => $inquire->id, 'redirect' => urlencode(url()->full())]),
            ]);
        } catch (\Exception $e) {
            \Log::error('Error assigning inquire: ' . $e->getMessage());
            return response()->json(['error' => 'Failed to assign inquire.'], 500);
        }
    }

    public function close($id, Request $request)
    {
        $inquire = Inquire::findOrFail($id);
    
        // Update inquire status
        $inquire->status = $request->input('status', 'close');
        $inquire->updated_by = Auth::id();
        $inquire->save();
        
        $data = [
            'inquiry_id' => $inquire->id,
            'status' => $request->input('status', 'close'),
            'remarks' => $request->input('remarks'),
            'is_manually' => true,
            'created_by' =>  Auth::id()
        ];
        
        InquireStatusHistory::create($data);
    
        return response()->json(['message' => 'Inquire closed successfully.']);
    }

    public function showInquireHistory($id)
    {
        $inquiry = InquiryHistory::with(['brand', 'generic', 'user'])->find($id);
        if (!$inquiry) {
            return response()->json(['success' => false, 'message' => 'Inquiry not found'], 404);
        }
    
        $requiredFields = [];
        $fieldsMap = [
            'is_generic_name' => 'Generic Name',
            'is_brand_name' => 'Brand Name',
            'is_pack_size' => 'Pack Size',
            'is_manufacturer_name' => 'Manufacturer Name',
            'is_gst' => 'GST',
            'is_storage_condition' => 'Storage Condition',
            'is_product_photo' => 'Product Photo',
            'is_product_doc' => 'Product Doc',
            'is_vendor_name' => 'Vendor Name',
            'is_price_per_pack' => 'Price Per Pack',
            'is_expiry' => 'Expiry Date',
            'is_lead_time' => 'Lead Time',
        ];

        foreach ($fieldsMap as $key => $label) {
            if ($inquiry->$key) {
                $requiredFields[] = $label;
            }
        }

        return response()->json([
            'success' => true,
            'inquiry' => [
                'quote_number' => $inquiry->quote_number,
                'type' => $inquiry->type,
                'brand_name' => $inquiry->brand->name ?? null,
                'generic_name' => $inquiry->generic->name ?? null,
                'no_of_brand' => $inquiry->no_of_brand,
                'status' => $inquiry->status,
                'quantity' => $inquiry->quantity,
                'no_of_supplier' => $inquiry->no_of_supplier,
                'assigned_user' => $inquiry->user->name ?? null,
            ],
            'requiredFields' => $requiredFields
        ]);
    }
}

