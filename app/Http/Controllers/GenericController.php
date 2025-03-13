<?php

namespace App\Http\Controllers;

use App\Models\Generic;
use Illuminate\Http\Request;
use App\Models\Quotation;
use App\Models\QuotationHistory;
use App\Models\Inquire;
use App\Models\InquiryHistory;

class GenericController extends Controller
{
    public function __construct()
    {
        $this->middleware('permission:generic-list', ['only' => ['index', 'show']]);
        $this->middleware('permission:generic-create', ['only' => ['create', 'store']]);
        $this->middleware('permission:generic-edit', ['only' => ['edit', 'update']]);
        $this->middleware('permission:generic-delete', ['only' => ['destroy']]);
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
    
        $genericQuery = Generic::orderBy($sortBy, $sortOrder);
    
        if (!empty($search)) {
            $genericQuery->where(function($query) use ($search) {
                $query->where('name', 'like', "%$search%");

                // Convert search input date to database format
                if (preg_match('/\d{2}\/\d{2}\/\d{4}/', $search)) {
                    $dateParts = explode('/', $search);
                    if (count($dateParts) === 3) {
                        $formattedDate = "{$dateParts[2]}-{$dateParts[1]}-{$dateParts[0]}"; // Convert dd/mm/yyyy to yyyy-mm-dd
                        
                        $query->orWhereDate('created_at', $formattedDate);
                    }
                }
            });
        }
    
        $count = $genericQuery->count();
        $lastPage = $count === 0
                    ? 1 
                    : (int) ceil($count / $perPage);

        if ($page > $lastPage) {
            $page = $lastPage;
        }
    
        $generics = $genericQuery->paginate($perPage, ['*'], 'page', $page);
    
        if ($request->ajax()) {
            return view('generics.partials.generic_table', compact('generics'))->render();
        }
    
        return view('generics.index', compact('generics', 'perPageOptions', 'perPage', 'search', 'sortBy', 'sortOrder'));
    }
    
    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        $redirectUrl = urldecode($request->query('redirect', url()->previous()));

        return view('generics.create', compact('redirectUrl'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
        ]);

        // Create a new generic record
        Generic::create($request->all());

        $redirectUrl = urldecode($request->input('redirect'));

        return redirect($redirectUrl)
                         ->with('success', 'Generic created successfully.');
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Request $request, Generic $generic)
    {
        $redirectUrl = urldecode($request->query('redirect', url()->previous()));

        return view('generics.edit', compact('generic','redirectUrl'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Generic $generic)
    {
        // Validate the request
        $request->validate([
            'name' => 'required|string|max:255',
        ]);

        // Update the generic record
        $generic->update($request->all());

        $redirectUrl = urldecode($request->input('redirect'));

        return redirect($redirectUrl)
                        ->with('success', 'Generic updated successfully.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        try {
            $quotations = Quotation::where('generic_id', $id)->exists();
            $quotationHistory = QuotationHistory::where('generic_id', $id)->exists();
            $inquire = Inquire::where('generic_id', $id)->exists();
            $inquiryHistory = InquiryHistory::where('generic_id', $id)->exists();
   
            if ($quotations || $quotationHistory || $inquire || $inquiryHistory) {
                return response()->json(['error' => 'This generic is used.']);
            }

            $generic = Generic::findOrFail($id);
            $generic->delete();

            return response()->json(['message' => 'Generic deleted successfully.']);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Unable to delete generic. Please try again later.'], 500);
        }
    }
}
