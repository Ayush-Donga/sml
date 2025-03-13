<?php

namespace App\Http\Controllers;

use App\Models\Bank;
use App\Models\Customers;
use App\Models\Order;
use Illuminate\Http\Request;

class CustomerController extends Controller
{
    public function __construct()
    {
        $this->middleware('permission:customer-list', ['only' => ['index', 'show']]);
        $this->middleware('permission:customer-create', ['only' => ['create', 'store']]);
        $this->middleware('permission:customer-edit', ['only' => ['edit', 'update']]);
        $this->middleware('permission:customer-delete', ['only' => ['destroy']]);
    }

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

        $customersQuery = Customers::leftJoin('customers as parent_customers', 'customers.id', '=', 'parent_customers.parent_id')
            ->select(
                'customers.*',
                'parent_customers.company_name as ship_to_name'
            )
            ->whereNull('customers.parent_id');

        // Handle sorting correctly
        if ($sortBy === 'company_name' || $sortBy === 'client_code') {
            $customersQuery->orderBy($sortBy, $sortOrder);
        } elseif ($sortBy === 'ship_to_name') {
            $customersQuery->orderBy('parent_customers.company_name', $sortOrder);
        } elseif ($sortBy === 'created_at') {
            $customersQuery->orderBy('customers.created_at', $sortOrder);
        } else {
            $customersQuery->orderBy('customers.id', 'desc');
        }

        if (!empty($search)) {
            $customersQuery->where(function ($query) use ($search) {
                $query->where('customers.company_name', 'like', "%$search%")
                    ->orWhere('customers.client_code', 'like', "%$search%")
                    ->orWhereHas('shipTo', function ($q) use ($search) {
                        $q->where('parent_customers.company_name', 'like', "%$search%");
                    });
        
                // Convert search input date to database format
                if (preg_match('/\d{2}\/\d{2}\/\d{4}/', $search)) {
                    $dateParts = explode('/', $search);
                    if (count($dateParts) === 3) {
                        $formattedDate = "{$dateParts[2]}-{$dateParts[1]}-{$dateParts[0]}"; // Convert dd/mm/yyyy to yyyy-mm-dd
                        
                        $query->orWhereDate('customers.created_at', $formattedDate);
                    }
                }
            });
        }

        $count = $customersQuery->count();
        $lastPage = $count === 0 
                    ? 1 
                    : (int) ceil($count / $perPage);

        if ($page > $lastPage) {
            $page = $lastPage;
        }

        $customers = $customersQuery->paginate($perPage, ['*'], 'page', $page);
        $parents   = Customers::get();

        if ($request->ajax()) {
            return view('customers.partials.customer_table', compact('customers', 'parents'))->render();
        }

        return view('customers.index', compact('customers', 'parents', 'perPageOptions', 'perPage', 'search', 'sortBy', 'sortOrder'));
    }

    public function create(Request $request)
    {
        $customers = Customers::whereNull('parent_id')->get();
        $banks = Bank::all();
        $redirectUrl = urldecode($request->query('redirect', url()->previous()));

        return view('customers.create', compact('customers', 'banks', 'redirectUrl'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'company_name' => 'required|string|max:160',
            'email' => 'nullable|string|max:100|email',
            'phone_no' => 'required|numeric|digits_between:1,25',
            'registration_no' => 'nullable|string|max:255',
            'address' => 'required|string|max:255',
            'zip_code' => ['nullable', 'string', 'max:25', 'regex:/^[a-zA-Z0-9]*$/'],
            'bank_id' => 'required',
            'currency' => 'required',
        ], [
            'company_name.required' => 'The company name field is required.',
            // 'email.required' => 'The email field is required.',
            // 'email.email' => 'Please enter a valid email address.',
            'phone_no.required' => 'The phone number field is required.',
            'phone_no.numeric' => 'Please enter a valid phone number.',
            'phone_no.digits_between' => 'The phone number must be between 1 and 25 digits.',
            'address.required' => 'The address field is required.',
            //'zip_code.required' => 'The zip code field is required.',
            'zip_code.regex' => 'The ZIP code may only contain letters and numbers.',
            'zip_code.max' => 'The ZIP code may not be greater than 25 characters.',
            'bank_id.required' => 'Please select bank name.',
            'currency.required' => 'Please select currency.',
        ]);

        // Get the last used client code
        $lastCustomer = Customers::orderBy('id', 'desc')->first();
        $lastClientCode = $lastCustomer ? $lastCustomer->client_code : 'SMP0000';

        // Increment the client code
        $newClientCode = 'SMP' . str_pad((int) substr($lastClientCode, 3) + 1, 4, '0', STR_PAD_LEFT);

        // Set parent_id and registration_no to null if not provided in the request
        $parentId = $request->input('parent_id') ?? null;
        $registrationNo = $request->input('registration_no') ?? null;

        // Create the new customer
        Customers::create([
            'client_code' => $newClientCode,
            'parent_id' => $parentId,
            'company_name' => $request->input('company_name'),
            'email' => $request->input('email') ?? null,
            'phone_no' => $request->input('phone_no'),
            'registration_no' => $registrationNo,
            'address' => $request->input('address'),
            'zip_code' => $request->input('zip_code') ?? null,
            'bank_id' => $request->input('bank_id'),
            'currency' => $request->input('currency')
        ]);

        $redirectUrl = urldecode($request->input('redirect'));

        return redirect($redirectUrl)->with('success', 'Customer created successfully');
    }

    public function edit(Request $request, string $id)
    {
        $customer = Customers::findOrFail($id);
        $customers = Customers::whereNull('parent_id')->get();

        // Fetching parents without pagination
        $parentsQuery = Customers::where('parent_id', $id);

        // Paginate the query builder instance instead of the result collection
        $parents = $parentsQuery->paginate(10);
        $banks = Bank::all();
        $redirectUrl = urldecode($request->query('redirect', url()->previous()));

        return view('customers.edit', compact('customer', 'customers', 'parents', 'banks', 'redirectUrl'));
    }


    public function update(Request $request, string $id)
    {

        $request->validate([
            'company_name' => 'required|string|max:160',
            'email' => 'nullable|string|max:100|email',
            'phone_no' => 'required|numeric|digits_between:1,25',
            'registration_no' => 'nullable|string|max:255',
            'address' => 'required|string|max:255',
            'zip_code' => ['nullable', 'string', 'max:25', 'regex:/^[a-zA-Z0-9]*$/'],
            'bank_id' => 'required',
            'currency' => 'required',
        ], [
            'company_name.required' => 'The company name field is required.',
            // 'email.required' => 'The email field is required.',
            // 'email.email' => 'Please enter a valid email address.',
            'phone_no.required' => 'The phone number field is required.',
            'phone_no.numeric' => 'Please enter a valid phone number.',
            'phone_no.digits_between' => 'The phone number must be between 1 and 25 digits.',
            'address.required' => 'The address field is required.',
            //'zip_code.required' => 'The zip code field is required.',
            'zip_code.regex' => 'The ZIP code may only contain letters and numbers.',
            'zip_code.max' => 'The ZIP code may not be greater than 25 characters.',
            'bank_id.required' => 'Please select bank name.',
            'currency.required' => 'Please select currency.',
        ]);

        // Set parent_id and registration_no to null if not provided in the request
        $parentId = $request->input('parent_id') ?? null;
        $registrationNo = $request->input('registration_no') ?? null;

        Customers::where('id', $id)->update([
            'parent_id' => $parentId,
            'company_name' => strtoupper($request->input('company_name')),
            'email' => strtoupper($request->input('email')),
            'phone_no' => $request->input('phone_no'),
            'registration_no' => strtoupper($registrationNo),
            'address' => strtoupper($request->input('address')),
            'zip_code' => strtoupper($request->input('zip_code')),
            'bank_id' => $request->input('bank_id'),
            'currency' => strtoupper($request->input('currency'))
        ]);

        $redirectUrl = urldecode($request->input('redirect'));

        return redirect($redirectUrl)->with('success', 'Customer updated successfully');
    }

    public function editParent(Request $request, string $id)
    {
        $customer = Customers::findOrFail($id);
        $parents = Customers::whereNull('parent_id')->get();
        $banks = Bank::all();
        $redirectUrl = urldecode($request->query('redirect', url()->previous()));

        return view('customers.editParent', compact('parents', 'customer', 'banks', 'redirectUrl'));
    }

    public function updateParent(Request $request, $id, $parent_id)
    {
        $request->validate([
            'company_name' => 'required|string|max:160',
            'email' => 'nullable|string|max:100|email',
            'phone_no' => 'required|numeric|digits_between:1,25',
            'registration_no' => 'nullable|string|max:255',
            'address' => 'required|string|max:255',
            'zip_code' => ['nullable', 'string', 'max:25', 'regex:/^[a-zA-Z0-9]*$/'],
            'bank_id' => 'required',
            'currency' => 'required',
        ], [
            'company_name.required' => 'The company name field is required.',
            // 'email.required' => 'The email field is required.',
            // 'email.email' => 'Please enter a valid email address.',
            'phone_no.required' => 'The phone number field is required.',
            'phone_no.numeric' => 'Please enter a valid phone number.',
            'phone_no.digits_between' => 'The phone number must be between 1 and 25 digits.',
            'address.required' => 'The address field is required.',
            //'zip_code.required' => 'The zip code field is required.',
            'zip_code.regex' => 'The ZIP code may only contain letters and numbers.',
            'zip_code.max' => 'The ZIP code may not be greater than 25 characters.',
            'bank_id.required' => 'Please select bank name.',
            'currency.required' => 'Please select currency.',
        ]);

        // Set parent_id and registration_no to null if not provided in the request
        $parentId = $request->input('parent_id') ?? null;
        $registrationNo = $request->input('registration_no') ?? null;

        Customers::where('id', $id)->update([
            'parent_id' => $parentId,
            'company_name' => strtoupper($request->input('company_name')),
            'email' => strtoupper($request->input('email')),
            'phone_no' => $request->input('phone_no'),
            'registration_no' => strtoupper($registrationNo),
            'address' => strtoupper($request->input('address')),
            'zip_code' => strtoupper($request->input('zip_code')),
            'bank_id' => $request->input('bank_id'),
            'currency' => strtoupper($request->input('currency'))
        ]);

        $redirectUrl = urldecode($request->input('redirect'));

        return redirect($redirectUrl)->with('success', 'Customer child updated successfully');
        //return redirect()->route('customers.edit',$parent_id)->with('success', 'Customer Parent updated successfully');
    }

    public function destroy(string $id)
    {
        try {
            $order = Order::where('bill_to_customer_id', $id)->get();
            if ($order->isNotEmpty()) {
                return response()->json(['error' => 'This customer is used.']);
            } else {
                $customer = Customers::findOrFail($id);
                $customer->delete();

                // Optionally, return a JSON response if you're using AJAX
                return response()->json(['message' => 'Customer deleted successfully.']);
            }
        } catch (\Exception $e) {
            return response()->json(['error' => 'Unable to delete product.'], 500);
        }
    }

    public function parentDestroy(string $id)
    {
        try {
            $order = Order::where('ship_to_customer_id', $id)->get();
            if ($order->isNotEmpty()) {
                return response()->json(['error' => 'This customer is used.']);
            } else {
                $customer = Customers::findOrFail($id);
                $customer->delete();

                // Optionally, return a JSON response if you're using AJAX
                return response()->json(['message' => 'Customer child deleted successfully.']);
            }
        } catch (\Exception $e) {
            return response()->json(['error' => 'Unable to delete product.'], 500);
        }
    }
}
