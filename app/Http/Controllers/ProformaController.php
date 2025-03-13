<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Http\Request;
use App\Models\Bank;
use App\Models\Configurations;
use App\Models\Customers;
use App\Models\Proforma;
use App\Models\ProformaProduct;
use App\Models\Order;
use App\Models\OrderProduct;
use App\Models\User;
use DateTime;
use Carbon\Carbon;
use Illuminate\Support\Facades\Validator;

class ProformaController extends Controller
{
    public function __construct()
    {
        $this->middleware('permission:proforma-list', ['only' => ['index', 'show']]);
        $this->middleware('permission:proforma-create', ['only' => ['create', 'store']]);
        $this->middleware('permission:proforma-edit', ['only' => ['edit', 'update']]);
        $this->middleware('permission:proforma-delete', ['only' => ['destroy']]);
    }

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $month = $request->input('month', now()->format('Y-m'));

        switch ($request->input('action')) {
            case 'prev':
                $month = Carbon::createFromFormat('Y-m', $month)->subMonth()->format('Y-m');
                break;
            case 'next':
                $month = Carbon::createFromFormat('Y-m', $month)->addMonth()->format('Y-m');
                break;
        }

        $query = Proforma::with([
            'proformaProducts.products',
            'proformaProducts.productVariants'
        ]) 
        ->where('serve_date', '=', $month);

        // Get the current authenticated user
        $user = Auth::user();

        // Get the child users (those who have the current user as their parent)
        $parents = User::where('parent_id', $user->id)->pluck('id')->toArray();

        // Determine which Proforma to show based on the permissions
        $canListBDDepartment = $user->can('bd-department-list');
        $canEditBDDepartment = $user->can('bd-department-edit');

        if (!$canListBDDepartment && $canEditBDDepartment) {
            // Case 3: bd-department-list = false and bd-department-edit = true
            // Show Proforma created by the current authenticated user and their children
            $query->where(function($q) use ($user, $parents) {
                $q->where('created_by', $user->id)
                ->orWhereIn('created_by', $parents);
            });
        }

        $proformas = $query->get();
        $users = User::all();

        return view('proformas.index', compact('proformas', 'month', 'users'));
    } 

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        $customers = Customers::whereNull('parent_id')->get();
        $banks = Bank::all();
        $redirectUrl = urldecode($request->query('redirect', url()->previous()));
        
        return view('proformas.create',  compact('customers', 'banks','redirectUrl'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
         // Validating the incoming request data
         $validator = Validator::make($request->all(), [
            'bill_to_customer_id' => 'required',
            'ship_to_customer_id' => 'required',
            'country' => 'required|string|max:255',
            'serve_date' => [
                'required',
                'date_format:Y-m',
                function ($attribute, $value, $fail) {
                    // Check if serve_date is not in a past month
                    $currentMonth = now()->format('Y-m');
                    if ($value < $currentMonth) {
                        $fail('The serve date cannot be in a past month.');
                    }
                },
            ],
           'invoice_date' => [
            'required',
            'date_format:Y-m-d',
            ],
            'payment_terms' => 'nullable|string|max:255',
            'delivery_by' => 'nullable|string|max:255',
            'delivery_time' => 'nullable|string|max:255',
            'delivery_terms' => 'nullable|string|max:255',
        ], [
            'invoice_date.date_format' => 'The invoice date does not match the format DD-MM-YYYY',
            'bill_to_customer_id.required' => 'Please select bill to.',
            'ship_to_customer_id.required' => 'Please select ship to.',
            'serve_date.date_format' => 'The serve date does not match the format MM-YYYY.',
        ]);

        // If validation fails, redirect back with errors
        if ($validator->fails()) {
            return redirect()->back()
                ->withErrors($validator)
                ->withInput();
        }

        $date = new DateTime();
        $orderDate = $date->format('Y-m-d');

        // Get the last used proforma invoice number configuration
        $configuration = Configurations::where('code', 'AUTO_GENERATED_PROFORMA_INVOICE_NO')->first();
        $lastInvoiceNo = $configuration->value;
        $numericPart = (int)filter_var($lastInvoiceNo, FILTER_SANITIZE_NUMBER_INT);
        $newInvoiceNoValue = $numericPart + 1;
        $newInvoiceNo = $configuration->name . $newInvoiceNoValue;
        
        // Update the configuration with the new proforma invoice number value
        $configuration->value = $newInvoiceNoValue;
        $configuration->save();

        $paymentTerms = $request->input('payment_terms') ?? null;
        $deliveryBy = $request->input('delivery_by') ?? null;
        $deliveryTime = $request->input('delivery_time') ?? null;
        $deliveryTerms = $request->input('delivery_terms') ?? null;
        $billToCustomerId = $request->input('bill_to_customer_id') ?? null;
        $billToClientCode = $request->input('bill_to_client_code') ?? null;
        $billToCompanyName = $request->input('bill_to_company_name') ?? null;
        $billToEmail = $request->input('bill_to_email') ?? null;
        $billToPhoneNo = $request->input('bill_to_phone_no') ?? null;
        $billToRegistrationNo = $request->input('bill_to_registration_no') ?? null;
        $billToAddress = $request->input('bill_to_address') ?? null;
        $billToZipCode = $request->input('bill_to_zip_code') ?? null;
        $currency = $request->input('currency') ?? null;

        $shipToCustomerId = $request->input('ship_to_customer_id') ?? null;
        $shipToClientCode = $request->input('ship_to_client_code') ?? null;
        $shipToCompanyName = $request->input('ship_to_company_name') ?? null;
        $shipToEmail = $request->input('ship_to_email') ?? null;
        $shipToPhoneNo = $request->input('ship_to_phone_no') ?? null;
        $shipToRegistrationNo = $request->input('ship_to_registration_no') ?? null;
        $shipToAddress = $request->input('ship_to_address') ?? null;
        $shipToZipCode = $request->input('ship_to_zip_code') ?? null;

        // Attempt to create the proforma
        $proforma = Proforma::create([
            'country' => $request->country,
            'order_date' => $orderDate,
            'invoice_date' => $request->invoice_date,
            'serve_date' => $request->serve_date,
            'invoice_no' => $newInvoiceNo,
            'bill_to_customer_id' => $billToCustomerId,
            'bill_to_client_code' => $billToClientCode,
            'bill_to_company_name' => $billToCompanyName,
            'bill_to_email' => $billToEmail,
            'bill_to_phone_no' => $billToPhoneNo,
            'bill_to_registration_no' => $billToRegistrationNo,
            'bill_to_address' => $billToAddress,
            'bill_to_zip_code' => $billToZipCode,
            'currency' => $currency,
            'ship_to_customer_id' => $shipToCustomerId,
            'ship_to_client_code' => $shipToClientCode,
            'ship_to_company_name' => $shipToCompanyName,
            'ship_to_phone_no' => $shipToPhoneNo,
            'ship_to_email' => $shipToEmail,
            'ship_to_registration_no' => $shipToRegistrationNo,
            'ship_to_address' => $shipToAddress,
            'ship_to_zip_code' => $shipToZipCode,
            'payment_terms' => $paymentTerms,
            'delivery_by' => $deliveryBy,
            'delivery_time' => $deliveryTime,
            'delivery_terms' => $deliveryTerms,
            'created_by' => Auth::id()
        ]);

        if ($proforma) {
            return redirect()->route('proformaProducts.create', ['id' => $proforma->id])
                ->with('success', 'Profoma create successfully');
        } else {
            return redirect()->route('proformas.index')
                ->with('error', 'Failed to create order');
        }
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Request $request, string $id)
    {
        $proforma = Proforma::findOrFail($id);
        $customers = Customers::whereNull('parent_id')->get();
        $parents = Customers::whereNotNull('parent_id')->get();
        $banks = Bank::all();
        $redirectUrl = urldecode($request->query('redirect', url()->previous()));

        return view('proformas.edit', compact('proforma','customers','parents','redirectUrl','banks'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        // Find the existing record by ID
        $existingRecord = Proforma::findOrFail($id);

        // Get the existing serve_date
        $existingServeDate = $existingRecord->serve_date;
        // validating the incoming request data
        $validator = validator::make($request->all(), [
            'bill_to_customer_id' => 'required',
            'ship_to_customer_id' => 'required',
            'country' => 'required|string|max:255',
            'country' => 'required|string|max:255',
            'serve_date' => [
                'required',
                'date_format:Y-m',
                function ($attribute, $value, $fail) use ($existingServeDate) {
                    $currentMonth = now()->format('Y-m');
    
                    if ($value < $currentMonth && $value != $existingServeDate) {
                        $fail('The serve date cannot be in a past month.');
                    }
                },
            ],
            'invoice_date' => 'date_format:Y-m-d|nullable',
            'payment_terms' => 'nullable|string|max:255',
            'delivery_by' => 'nullable|string|max:255',
            'delivery_time' => 'nullable|string|max:255',
            'delivery_terms' => 'nullable|string|max:255',
        ],[
            'invoice_date.date_format' => 'The invoice date does not match the format DD-MM-YYYY',
            'bill_to_customer_id.required' => 'Please select bill to.',
            'ship_to_customer_id.required' => 'Please select ship to.',
            'serve_date.date_format' => 'The serve date does not match the format MM-YYYY.',
        ]);

        // If validation fails, redirect back with errors
        if ($validator->fails()) {
            return redirect()->back()
                ->withErrors($validator)
                ->withInput();
        }

        $billToData = Customers::findOrFail($request->bill_to_customer_id);
        $shipToData = Customers::findOrFail($request->ship_to_customer_id);
        $paymentTerms = $request->input('payment_terms') ?? null;
        $deliveryBy = $request->input('delivery_by') ?? null;
        $deliveryTime = $request->input('delivery_time') ?? null;
        $deliveryTerms = $request->input('delivery_terms') ?? null;
    
        if(isset($billToData) && isset($shipToData)){
            Proforma::where('id', $id)->update([
                'country' => $request->country,
                'serve_date' => $request->serve_date,
                'currency' => $billToData->currency,
                'invoice_date' => $request->invoice_date,
                'bill_to_customer_id' => $billToData->id,
                'bill_to_client_code' => $billToData->client_code,
                'bill_to_company_name' => $billToData->company_name,
                'bill_to_email' => $billToData->email,
                'bill_to_phone_no' => $billToData->phone_no,
                'bill_to_registration_no' => $billToData->registration_no,
                'bill_to_address' => $billToData->address,
                'bill_to_zip_code' => $billToData->zip_code,
                'ship_to_customer_id' => $shipToData->id,
                'ship_to_client_code' => $shipToData->client_code,
                'ship_to_company_name' => $shipToData->company_name,
                'ship_to_phone_no' => $shipToData->phone_no,
                'ship_to_email' => $shipToData->email,
                'ship_to_registration_no' => $shipToData->registration_no,
                'ship_to_address' => $shipToData->address,
                'ship_to_zip_code' => $shipToData->zip_code,
                'payment_terms' => $paymentTerms,
                'delivery_by' => $deliveryBy,
                'delivery_time' => $deliveryTime,
                'delivery_terms' => $deliveryTerms,
                'updated_by' => Auth::id()
            ]);
        }

        // $url = route('proformas.index', ['month' => $request->serve_date]);

        // $redirectUrl = urldecode($url);

        $redirectUrl = urldecode($request->input('redirect'));

        return redirect($redirectUrl)->with('success', 'Profoma updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        try {
            $proforma = Proforma::findOrFail($id);
            $proforma->delete();
            
            // Optionally, return a JSON response if you're using AJAX
            return response()->json(['message' => 'Proforma deleted successfully.']);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Unable to delete order.'], 500);
        }
    }

    public function proformaToConvertOrder(Request $request){
        $proformaId = $request->post('proformaId');
        $serveDate = $request->post('month');
        $proforma = Proforma::findOrFail($proformaId);
       
        $date = new DateTime();
        $orderDate = $date->format('Y-m-d');

        // Get the last used invoice number configuration
        $configuration = Configurations::where('code', 'AUTO_GENERATED_INVOICE_NO')->first();
        $lastInvoiceNo = $configuration->value;
        $numericPart = (int)filter_var($lastInvoiceNo, FILTER_SANITIZE_NUMBER_INT);
        $newInvoiceNoValue = $numericPart + 1;
        $newInvoiceNo = $configuration->name . $newInvoiceNoValue;
        
        // Update the configuration with the new invoice number value
        $configuration->value = $newInvoiceNoValue;
        $configuration->save();

        $piNumber = $proforma->invoice_no ?? null;
        $paymentTerms = $proforma->payment_terms ?? null;
        $deliveryBy = $proforma->delivery_by ?? null;
        $deliveryTime = $proforma->delivery_time ?? null;
        $deliveryTerms = $proforma->delivery_terms ?? null;
        $shipping = $proforma->shipping ?? null;
        $softBoxes = $proforma->soft_boxes ?? null;
        $dataLogger = $proforma->data_logger ?? null;
        $clearance = $proforma->clearance ?? null;
        $billToCustomerId = $proforma->bill_to_customer_id ?? null;
        $billToClientCode = $proforma->bill_to_client_code ?? null;
        $billToCompanyName = $proforma->bill_to_company_name ?? null;
        $billToEmail = $proforma->bill_to_email ?? null;
        $billToPhoneNo = $proforma->bill_to_phone_no ?? null;
        $billToRegistrationNo = $proforma->bill_to_registration_no ?? null;
        $billToAddress = $proforma->bill_to_address ?? null;
        $billToZipCode = $proforma->bill_to_zip_code ?? null;
        $currency = $proforma->currency ?? null;

        $shipToCustomerId = $proforma->ship_to_customer_id ?? null;
        $shipToClientCode = $proforma->ship_to_client_code ?? null;
        $shipToCompanyName = $proforma->ship_to_company_name ?? null;
        $shipToEmail = $proforma->ship_to_email ?? null;
        $shipToPhoneNo = $proforma->ship_to_phone_no ?? null;
        $shipToRegistrationNo = $proforma->ship_to_registration_no ?? null;
        $shipToAddress = $proforma->ship_to_address ?? null;
        $shipToZipCode = $proforma->ship_to_zip_code ?? null;     
        
        // Attempt to create the order
        $order = Order::create([
            'country' => $proforma->country,
            'order_date' => $orderDate,
            'serve_date' => $serveDate,
            'invoice_no' => $newInvoiceNo,
            'pi_number' => $piNumber,
            'bill_to_customer_id' => $billToCustomerId,
            'bill_to_client_code' => $billToClientCode,
            'bill_to_company_name' => $billToCompanyName,
            'bill_to_email' => $billToEmail,
            'bill_to_phone_no' => $billToPhoneNo,
            'bill_to_registration_no' => $billToRegistrationNo,
            'bill_to_address' => $billToAddress,
            'bill_to_zip_code' => $billToZipCode,
            'currency' => $currency,
            'ship_to_customer_id' => $shipToCustomerId,
            'ship_to_client_code' => $shipToClientCode,
            'ship_to_company_name' => $shipToCompanyName,
            'ship_to_phone_no' => $shipToPhoneNo,
            'ship_to_email' => $shipToEmail,
            'ship_to_registration_no' => $shipToRegistrationNo,
            'ship_to_address' => $shipToAddress,
            'ship_to_zip_code' => $shipToZipCode,
            'payment_terms' => $paymentTerms,
            'delivery_by' => $deliveryBy,
            'delivery_time' => $deliveryTime,
            'delivery_terms' => $deliveryTerms,
            'shipping' => $shipping,
            'soft_boxes' => $softBoxes,
            'data_logger' => $dataLogger,
            'clearance' => $clearance,
            'created_by' => $proforma->created_by
        ]);

        Proforma::where('id', $proformaId)->update([
            'order_id' => $order->id,
            'status' => 'completed'
        ]);

        // Get all products associated with the proforma
        $proformaProducts = ProformaProduct::where('proforma_id', $proformaId)->get();
        foreach ($proformaProducts as $value) {
            if ($value['product_id'] && $value['product_variant_id'] && $value['quantity'] && $value['price_per_set'] && $value['total']) {
                $orderProduct = new OrderProduct([
                    'order_id' => $order->id,
                    'product_id' => $value['product_id'],
                    'product_variant_id' => $value['product_variant_id'],
                    'quantity' => $value['quantity'],
                    'price_per_set' => $value['price_per_set'],
                    'total' => $value['total']
                ]);
                $orderProduct->save();
            }
        }

         // Log the permissions and redirect accordingly
         $url = ['month' => $serveDate];
         if (Auth::user()->can('order-list')) {
            return response()->json([
                'success' => true,
                'redirect' => route('orders.index',$url),
                'message' => 'Proforma order created successfully'
            ]);
        } else {
            return response()->json([
                'success' => true,
                'redirect' => route('proformas.index',$url),
                'message' => 'Proforma order created successfully'
            ]);
        }
    }
}
