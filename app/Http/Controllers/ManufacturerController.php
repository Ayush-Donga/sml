<?php

namespace App\Http\Controllers;

use App\Models\Manufacturer;
use Illuminate\Http\Request;
use App\Models\Quotation;
use App\Models\QuotationHistory;

class ManufacturerController extends Controller
{

    public function __construct()
    {
        $this->middleware('permission:manufacturer-list', ['only' => ['index', 'show']]);
        $this->middleware('permission:manufacturer-create', ['only' => ['create', 'store']]);
        $this->middleware('permission:manufacturer-edit', ['only' => ['edit', 'update']]);
        $this->middleware('permission:manufacturer-delete', ['only' => ['destroy']]);
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

        $manufacturerQuery = Manufacturer::orderBy( $sortBy, $sortOrder);

        if (!empty($search)) {
            $manufacturerQuery->where(function($query) use ($search) {
                $query->where('name', 'like', "%$search%");

               // Check if the search input is a date in dd/mm/yyyy format
                if (preg_match('/^(\d{2})\/(\d{2})\/(\d{4})$/', $search, $matches)) {
                    $formattedDate = "{$matches[3]}-{$matches[2]}-{$matches[1]}"; // Convert to yyyy-mm-dd format
                    
                    // Ensure the formatted date is valid before querying
                    if (strtotime($formattedDate)) {
                        $query->orWhereDate('created_at', '=', $formattedDate);
                    }
                }
            });
        }

        $count = $manufacturerQuery->count();
        $lastPage = ($count === 0)
            ? 1
            : (int) ceil($count / $perPage);

        if ($page > $lastPage) {
            $page = $lastPage;
        }

        $manufacturers = $manufacturerQuery->paginate($perPage, ['*'], 'page', $page);

        if ($request->ajax()) {
            return view('manufacturers.partials.manufacturer_table', compact('manufacturers'))->render();
        }

        return view('manufacturers.index', compact('manufacturers','perPageOptions', 'perPage', 'search', 'sortBy', 'sortOrder'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        $redirectUrl = urldecode($request->query('redirect', url()->previous()));

        return view('manufacturers.create', compact('redirectUrl'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
        ]);

        // Create a new manufacturer record
        Manufacturer::create($request->all());

        $redirectUrl = urldecode($request->input('redirect'));

        return redirect($redirectUrl)
                         ->with('success', 'Manufacturer created successfully.');
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Request $request, Manufacturer $manufacturer)
    {
        $redirectUrl = urldecode($request->query('redirect', url()->previous()));

        return view('manufacturers.edit', compact('manufacturer','redirectUrl'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Manufacturer $manufacturer)
    {
          // Validate the request
          $request->validate([
            'name' => 'required|string|max:255',
        ]);

        // Update the manufacturer record
        $manufacturer->update($request->all());

        $redirectUrl = urldecode($request->input('redirect'));

        return redirect($redirectUrl)
                        ->with('success', 'Manufacturer updated successfully.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        try {
            $quotations = Quotation::where('manufacturer_id', $id)->exists();
            $quotationHistory = QuotationHistory::where('manufacturer_id', $id)->exists();

            if ($quotations || $quotationHistory) {
                return response()->json(['error' => 'This manufacturer is used.']);
            } 

            $manufacturer = Manufacturer::findOrFail($id);
            $manufacturer->delete();

            return response()->json(['message' => 'Manufacturer deleted successfully.']);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Unable to delete manufacturer.'], 500);
        }
    }
}
