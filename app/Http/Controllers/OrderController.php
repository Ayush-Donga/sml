<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use App\Models\Bank;
use App\Models\Configurations;
use App\Models\Customers;
use App\Models\Order;
use App\Models\User;
use App\Models\Proforma;
use DateTime;
use Carbon\Carbon;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\ValidationException;

class OrderController extends Controller
{
    public function __construct()
    {
        $this->middleware('permission:order-list', ['only' => ['index', 'show']]);
        $this->middleware('permission:order-create', ['only' => ['create', 'store']]);
        $this->middleware('permission:order-edit', ['only' => ['editOrder', 'updateOrder']]);
        $this->middleware('permission:order-delete', ['only' => ['destroy']]);
        $this->middleware('permission:logistic-department-edit', ['only' => ['edit', 'update']]);
    }

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

        $query = Order::with([
            'orderProducts.orderProductStocks',
            'orderPackages.orderPackageProducts',
            'orderProducts.products',
            'orderProducts.productVariants'
        ])
            ->where('serve_date', '=', $month);

        $isShipmentClosed = $request->input('is_shipment_close') === 'yes';

        if ($isShipmentClosed) {
            // order all record
        } else {
            $query->where(function ($query) {
                $query->whereNull('is_shipment_close')
                    ->orWhere('is_shipment_close', '!=', 'yes');
            });
        }

        // Get the current authenticated user
        $user = Auth::user();

        // Get the child users (those who have the current user as their parent)
        $parents = User::where('parent_id', $user->id)->pluck('id')->toArray();

        // Determine which orders to show based on the permissions
        $canListBDDepartment = $user->can('bd-department-list');
        $canEditBDDepartment = $user->can('bd-department-edit');

        if (!$canListBDDepartment && $canEditBDDepartment) {
            // Case 3: bd-department-list = false and bd-department-edit = true
            // Show orders created by the current authenticated user and their children
            $query->where(function ($q) use ($user, $parents) {
                $q->where('created_by', $user->id)
                    ->orWhereIn('created_by', $parents);
            });
        }

        $orders = $query->get();
        $colors = departmentWiseColor($orders);
        $orders = mergeColorsWithOrders($orders, $colors);
        $users = User::all();

        return view('orders.index', compact('orders', 'month', 'users'));
    }

    public function create(Request $request)
    {
        $customers = Customers::whereNull('parent_id')->get();
        $banks = Bank::all();
        $redirectUrl = urldecode($request->query('redirect', url()->previous()));
  
        return view('orders.create', compact('customers', 'banks', 'redirectUrl'));
    }

    public function store(Request $request)
    {
        // Validating the incoming request data
        $validator = validator::make($request->all(), [
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
            'pi_number' => 'nullable|string|max:255',
            'payment_terms' => 'nullable|string|max:255',
            'delivery_by' => 'nullable|string|max:255',
            'delivery_time' => 'nullable|string|max:255',
            'delivery_terms' => 'nullable|string|max:255',
            'port_of_discharge' => 'nullable|string|max:100',
        ], [
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

        // Get the last used invoice number configuration
        $configuration = Configurations::where('code', 'AUTO_GENERATED_INVOICE_NO')->first();
        $lastInvoiceNo = $configuration->value;
        $numericPart = (int) filter_var($lastInvoiceNo, FILTER_SANITIZE_NUMBER_INT);
        $newInvoiceNoValue = $numericPart + 1;
        $newInvoiceNo = $configuration->name . $newInvoiceNoValue;

        // Update the configuration with the new invoice number value
        $configuration->value = $newInvoiceNoValue;
        $configuration->save();

        $piNumber = $request->input('pi_number') ?? null;
        $paymentTerms = $request->input('payment_terms') ?? null;
        $deliveryBy = $request->input('delivery_by') ?? null;
        $deliveryTime = $request->input('delivery_time') ?? null;
        $deliveryTerms = $request->input('delivery_terms') ?? null;
        $portOfDischarge = $request->input('port_of_discharge') ?? null;
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

        // Attempt to create the order
        $order = Order::create([
            'country' => $request->country,
            'order_date' => $orderDate,
            'serve_date' => $request->serve_date,
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
            'port_of_discharge' => $portOfDischarge,
            'created_by' => Auth::id()
        ]);

        // Check if the order was successfully created
        if ($order) {
            // Redirect to the create view for OrderProducts with the new order ID
            return redirect()->route('orderProducts.create', ['id' => $order->id])
                ->with('success', 'Order created successfully');
        } else {
            // Handle the case where order creation failed
            return redirect()->route('orders.index')
                ->with('error', 'Failed to create order');
        }
    }

    public function edit(Request $request, $id)
    {
        // Fetch the specific order with its related order products
        $order = Order::findOrFail($id);
        $banks = Bank::all();
        $redirectUrl = urldecode($request->query('redirect', url()->previous()));

        return view('orders.edit', compact('order', 'banks', 'redirectUrl'));
    }

    public function update(Request $request, $id)
    {

        Order::where('id', $id)->update([
            'is_shipping_documents_done' => $request->is_shipping_documents_done,
            'is_tax_invoice_eway_billP_done' => $request->is_tax_invoice_eway_billP_done,
            'is_arrange_pick_up' => $request->is_arrange_pick_up,
            'is_shipment_dispatched' => $request->is_shipment_dispatched,
            'is_awb_handover' => $request->is_awb_handover,
            'is_shipment_close' => $request->is_shipment_close
        ]);

        $redirectUrl = urldecode($request->input('redirect'));

        return redirect($redirectUrl)->with('success', 'Logistic department successfully');
    }

    public function editOrder(Request $request, $id)
    {
        // Fetch the specific order with its related order products
        $order = Order::findOrFail($id);
        $customers = Customers::whereNull('parent_id')->get();
        $parents = Customers::whereNotNull('parent_id')->get();

        // Fetch the redirect URL from the query string or set it to the previous URL
        $redirectUrl = urldecode($request->query('redirect', url()->previous()));

        return view('orders.editOrder', compact('order', 'customers', 'parents', 'redirectUrl'));
    }

    public function updateOrder(Request $request, $id)
    {
        // Find the existing record by ID
        $existingRecord = Order::findOrFail($id);

        // Get the existing serve_date
        $existingServeDate = $existingRecord->serve_date;
        // validating the incoming request data
        $validator = validator::make($request->all(), [
            'bill_to_customer_id' => 'required',
            'ship_to_customer_id' => 'required',
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
            'pi_number' => 'nullable|string|max:255',
            'invoice_date' => 'date_format:Y-m-d|nullable',
            'payment_terms' => 'nullable|string|max:255',
            'delivery_by' => 'nullable|string|max:255',
            'delivery_time' => 'nullable|string|max:255',
            'delivery_terms' => 'nullable|string|max:255',
            'port_of_discharge' => 'nullable|string|max:100',
        ], [
            'bill_to_customer_id.required' => 'Please select bill to.',
            'ship_to_customer_id.required' => 'Please select ship to.',
            'invoice_date.date_format' => 'The invoice date does not match the format DD-MM-YYYY.',
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
        $portOfDischarge = $request->input('port_of_discharge') ?? null;

        if (isset($billToData) && isset($shipToData)) {
            Order::where('id', $id)->update([
                'country' => $request->country,
                'serve_date' => $request->serve_date,
                'currency' => strtoupper($billToData->currency),
                'pi_number' => strtoupper($request->pi_number),
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
                'port_of_discharge' => $portOfDischarge,
                'updated_by' => Auth::id()
            ]);
        }

        // $url = route('orders.index', ['month' => $request->serve_date]);

        // $redirectUrl = urldecode($url);
        $redirectUrl = urldecode($request->input('redirect'));

        return redirect($redirectUrl)->with('success', 'Order updated successfully');
    }

    public function destroy($id)
    {
        try {
            // Find Proforma records linked to the order
            $proforma = Proforma::where('order_id', $id)->get();
    
            // Check if there are any Proforma records and update them
            if ($proforma->isNotEmpty()) {
                Proforma::where('order_id', $id)->update(['order_id' => null, 'status' => 'pending']);
            }
    
            // Find and delete the Order
            $order = Order::findOrFail($id);
            $order->delete();
    
            // Return a success response
            return response()->json(['message' => 'Order deleted successfully.']);
        } catch (\Exception $e) {
            // Return an error response
            return response()->json(['error' => 'Unable to delete order.'], 500);
        }
    }
    
    public function getCustomerShipTo(Request $request)
    {
        $bill_id = $request->post('billToId');
        $customers = Customers::where('parent_id', $bill_id)->get();
        $html = '<option value="">Select</option>';
        foreach ($customers as $parent) {
            $html .= '<option value="' . $parent->id . '">' . $parent->client_code . ' / ' . $parent->company_name;
            '</option>';
        }
        echo $html;
    }

    public function getCustomerBillTo(Request $request)
    {
        $bill_id = $request->post('billToId');
        $customer = Customers::where('id', $bill_id)->first();
        if ($customer) {
            return response()->json(['client_code' => $customer->client_code, 'company_name' => $customer->company_name, 'email' => $customer->email, 'phone_no' => $customer->phone_no, 'registration_no' => $customer->registration_no, 'address' => $customer->address, 'zip_code' => $customer->zip_code, 'currency' => $customer->currency]);
        } else {
            return response()->json(['error' => 'Customer not found.']);
        }
    }

    public function getCustomerShipToDetails(Request $request)
    {
        $ship_id = $request->post('shipToId');
        $customer = Customers::where('id', $ship_id)->first();
        if ($customer) {
            return response()->json(['client_code' => $customer->client_code, 'company_name' => $customer->company_name, 'email' => $customer->email, 'phone_no' => $customer->phone_no, 'registration_no' => $customer->registration_no, 'address' => $customer->address, 'zip_code' => $customer->zip_code]);
        } else {
            return response()->json(['error' => 'Customer not found.']);
        }
    }

    public function createCustomer(Request $request)
    {
        // Get the last used client code
        $lastCustomer = Customers::orderBy('id', 'desc')->first();
        $lastClientCode = $lastCustomer ? $lastCustomer->client_code : 'SMP0000';

        // Increment the client code
        $newClientCode = 'SMP' . str_pad((int) substr($lastClientCode, 3) + 1, 4, '0', STR_PAD_LEFT);

        $parentId = $request->input('parent_id') ?? null;
        $email = $request->input('email') ?? null;
        $registrationNo = $request->input('registration_no') ?? null;
        $zipCode = $request->input('zip_code') ?? null;

        Customers::create([
            'client_code' => $newClientCode,
            'parent_id' => $parentId,
            'company_name' => $request->input('company_name'),
            'email' => $email,
            'phone_no' => $request->input('phone_no'),
            'registration_no' => $registrationNo,
            'address' => $request->input('address'),
            'zip_code' => $zipCode,
            'bank_id' => $request->input('bank_id'),
            'currency' => $request->input('currency')
        ]);

        if ($request->input('customer_type') === 'bill_to') {
            return response()->json(['success' => true, 'message' => 'Bill to customer created successfully']);
        } elseif ($request->input('customer_type') === 'ship_to') {
            return response()->json(['success' => true, 'message' => 'Ship to customer created successfully']);
        } else {
            return response()->json(['message' => 'Invalid customer type']);
        }
    }
}
