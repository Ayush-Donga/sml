<?php

namespace App\Http\Controllers;

use App\Models\Bank;
use App\Models\Customers;
use Illuminate\Http\Request;

class BankController extends Controller
{

    public function __construct()
    {
        $this->middleware('permission:bank-list', ['only' => ['index', 'show']]);
        $this->middleware('permission:bank-create', ['only' => ['create', 'store']]);
        $this->middleware('permission:bank-edit', ['only' => ['edit', 'update']]);
        $this->middleware('permission:bank-delete', ['only' => ['destroy']]);
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
        $sortBy  = $request->input('sortBy', 'id');
        $sortOrder = $request->input('sortOrder', 'desc');

        if (! in_array($perPage, $perPageOptions)) {
            $perPage = $defaultPerPage;
        }

        $bankQuery = Bank::orderBy($sortBy, $sortOrder);

        if (!empty($search)) {
            $bankQuery->where(function($query) use ($search) {
                $query->where('name', 'like', "%$search%")
                ->orWhere('account_name', 'like', "%$search%")
                ->orWhere('account_no', 'like', "%$search%")
                ->orWhere('swift_code_no', 'like', "%$search%")
                ->orWhere('ifsc_code', 'like', "%$search%")
                ->orWhere('branch', 'like', "%$search%");
                
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

        $count = $bankQuery->count();
        $lastPage = $count === 0
                    ? 1
                    : (int) ceil($count / $perPage);

        if ($page > $lastPage) {
            $page = $lastPage;
        }

        $banks = $bankQuery->paginate($perPage, ['*'], 'page', $page);

        if ($request->ajax()) {
            return view('banks.partials.bank_table', compact('banks'))
                ->render();
        }

        return view('banks.index', compact('banks', 'perPageOptions', 'perPage', 'search', 'sortBy', 'sortOrder'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        $redirectUrl = urldecode($request->query('redirect', url()->previous()));
        
        return view('banks.create', compact('redirectUrl'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
       // dd($request);
         // Validate the request
         $request->validate([
            'name' => 'required|string|max:255',
            'account_no' => 'required|string|min:6|max:16|unique:banks,account_no',
            'account_name' => 'required|string|max:255',
            'swift_code_no' => 'required|string|min:8|max:11|unique:banks,swift_code_no',
            'ifsc_code' => 'required|string|size:11|unique:banks,ifsc_code',
            'branch' => 'required|string|max:255',
        ],[
            'ifsc_code.size' => 'The IFSC code must be at least 11 characters.',
        ]);

        // Create a new bank record
        Bank::create($request->all());

        $redirectUrl = urldecode($request->input('redirect'));

        return redirect($redirectUrl)->with('success', 'Bank created successfully.');
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Request $request, Bank $bank)
    {
        $redirectUrl = urldecode($request->query('redirect', url()->previous()));

        return view('banks.edit', compact('bank', 'redirectUrl'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Bank $bank)
    {
        // Validate the request
        $request->validate([
            'name' => 'required|string|max:255',
            'account_no' => 'required|string|min:6|max:16|unique:banks,account_no,' . $bank->id,
            'account_name' => 'required|string|max:255',
            'swift_code_no' => 'required|string|min:8|max:11|unique:banks,swift_code_no,' . $bank->id,
            'ifsc_code' => 'required|string|size:11|unique:banks,ifsc_code,'. $bank->id,
            'branch' => 'required|string|max:255',
        ],[
            'ifsc_code.size' => 'The IFSC code must be at least 11 characters.',
        ]);

        // Update the bank record
        $bank->update($request->all());

        $redirectUrl = urldecode($request->input('redirect'));

        return redirect($redirectUrl)->with('success', 'Bank updated successfully.');
    }


    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        try {
            $customer = Customers::where('bank_id', $id)->get();
            if($customer->isNotEmpty()){
                return response()->json(['error' => 'This bank is used.']);
            } else {
                $bank = Bank::findOrFail($id);
                $bank->delete();
            
                // Optionally, return a JSON response if you're using AJAX
                return response()->json(['message' => 'Bank deleted successfully.']);
            }
        } catch (\Exception $e) {
            return response()->json(['error' => 'Unable to delete bank.'], 500);
        }
    }
}
