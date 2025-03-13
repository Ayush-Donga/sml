<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Vender;
use App\Models\Supplier;
use App\Models\SupplierHistory;

class VenderController extends Controller
{
    public function __construct()
    {
        $this->middleware('permission:vender-list', ['only' => ['index', 'show']]);
        $this->middleware('permission:vender-create', ['only' => ['create', 'store']]);
        $this->middleware('permission:vender-edit', ['only' => ['edit', 'update']]);
        $this->middleware('permission:vender-delete', ['only' => ['destroy']]);
    } 

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $perPageOptions = [10, 25, 50, 100];
        $defaultPerPage = $perPageOptions[0];
        $perPage = $request->input('perPage', $defaultPerPage);
        $page = (int) $request->input('page', 1);
        $search = $request->input('search', '');
        $sortBy  = $request->input('sortBy', 'id');  // Default sorting by ID
        $sortOrder = $request->input('sortOrder', 'desc'); // Default sorting order

        if (! in_array($perPage, $perPageOptions)) {
            $perPage = $defaultPerPage;
        }

        $venderQuery = Vender::orderBy($sortBy, $sortOrder);
        
        if (!empty($search)) {
            $venderQuery->where(function($query) use ($search) {
                $query->where('name', 'like', "%$search%")
                ->orWhere('email', 'like', "%$search%")
                ->orWhere('phone', 'like', "%$search%")
                ->orWhere('location', 'like', "%$search%");

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

        $count = $venderQuery->count();
        $lastPage = $count === 0 ? 1 : (int) ceil($count / $perPage);
        if ($page > $lastPage) {
            $page = $lastPage;
        }

        $venders = $venderQuery->paginate($perPage, ['*'], 'page', $page);

        if ($request->ajax()) {
            return view('venders.partials.vender_table', compact('venders'))
                ->render();
        }

        return view('venders.index', compact('venders', 'perPageOptions', 'perPage', 'search', 'sortBy', 'sortOrder'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        $redirectUrl = urldecode($request->query('redirect', url()->previous()));
        return view('venders.create', compact('redirectUrl'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
         // Validate the request
         $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'nullable|email|max:70|unique:venders,email',
            'phone' => 'nullable|numeric|digits_between:10,15',
            'location' => 'nullable|string|max:255',
        ],[
            'phone.numeric' => 'Please enter a valid phone number.',
            'phone.digits_between' => 'The phone number must be 10 to 15 digits.',
        ]);

        // Create a new vender record
        Vender::create($request->all());
        $redirectUrl = urldecode($request->input('redirect'));

        return redirect($redirectUrl)->with('success', 'Vender created successfully.');                 
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Request $request, Vender $vender)
    {
        $redirectUrl = urldecode($request->query('redirect', url()->previous()));
        return view('venders.edit', compact('vender','redirectUrl'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Vender $vender)
    {
        // Validate the request
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'nullable|email|max:70|unique:venders,email,'. $vender->id,
            'phone' => 'nullable|numeric|digits_between:10,15',
            'location' => 'nullable|string|max:255',
        ],[
            'phone.numeric' => 'Please enter a valid phone number.',
            'phone.digits_between' => 'The phone number must be 10 to 15 digits.',
        ]);

         // Update the vender record
         $vender->update($request->all());
         $redirectUrl = urldecode($request->input('redirect'));
         
         return redirect($redirectUrl)
                         ->with('success', 'Vender updated successfully.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        try {
            $suppliers = Supplier::where('vender_id', $id)->exists();
            $supplierHistory = SupplierHistory::where('vender_id', $id)->exists();

            if ($suppliers || $supplierHistory) {
                return response()->json(['error' => 'This Vender is used.']);
            } 

            $vender = Vender::findOrFail($id);
            $vender->delete();

            return response()->json(['message' => 'Vender deleted successfully.']);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Unable to delete vender.'], 500);
        }
    }
}
