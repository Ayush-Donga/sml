@section('title')
    Order List
@endsection
@extends('layouts.main')

@section('style')
    <!-- Sweet Alert css -->
    <link href="{{ asset('assets/plugins/sweet-alert2/sweetalert2.min.css') }}" rel="stylesheet" type="text/css" />
    <!-- DataTables css -->
    <link href="{{ asset('assets/plugins/datatables/dataTables.bootstrap4.min.css') }}" rel="stylesheet" type="text/css" />
    <link href="{{ asset('assets/plugins/datatables/buttons.bootstrap4.min.css') }}" rel="stylesheet" type="text/css" />
    <!-- Responsive Datatable css -->
    <link href="{{ asset('assets/plugins/datatables/responsive.bootstrap4.min.css') }}" rel="stylesheet" type="text/css" />
    <style>
        .logistic {
            background: #a4c2f4;
        }
        .bd-department {
            background: #ead1dc;
        }
        .purchase {
            background: #fce5cd;
        }
        .where-house {
            background: #cfe2f3;
        }
        .billing {
            background: #e6b8af;
        }
        .where-house-packing-list {
            background: #cfe2f3;
        }
    </style>
@endsection

@section('breadcrumbbar')
    <!-- Start Breadcrumbbar -->
    <div class="breadcrumbbar">
        <div class="row align-items-center">
            <div class="col-md-8 col-lg-8">
                <h4 class="page-title">@yield('title')</h4>
                <div class="breadcrumb-list">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="{{ url('/') }}">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">@yield('title')</li>
                    </ol>
                </div>
            </div>
            <div class="col-md-4 col-lg-4">
                <div class="widgetbar">
                    @can('order-create')
                        <a href="{{ route('orders.create', ['redirect' => urlencode(url()->full())]) }}" class="btn btn-primary-rgba"><i
                                class="feather icon-plus mr-2"></i>Add New Order</a>
                    @endcan
                </div>
            </div>
        </div>
    </div>
    <!-- End Breadcrumbbar -->
@endsection

@section('errormessege')
    <div class="contentbar p-0 m-0" style="padding-right :30px !important;">
        <!-- Start row -->
        <div class="row justify-content-end">
            <div class="col-lg-4">
                <div id="message"></div>
                 @php
                if (isset($_GET['success'])) {
                    $successMessage = $_GET['success'];
                    echo "<div class='alert alert-success alert-dismissible fade show m-0 mt-3' role='alert'>{$successMessage}<button type='button' class='close' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button></div>";
                }
                @endphp
                <!-- @if ($message = Session::get('success'))
    -->
                <div class="alert alert-success alert-dismissible fade show m-0 mt-3" role="alert">
                    {{ $message }}
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <!--
    @endif -->

                @if ($message = Session::get('error'))
                    <div class="alert alert-danger alert-dismissible fade show m-0 mt-3" role="alert">
                        <strong>{{ $message }}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                    </div>
                @endif
            </div>
        </div>
    </div>
@endsection
@section('rightbar-content')
    <!-- Start Contentbar -->
    <div class="contentbar">
        <!-- Start row -->
        <div class="row">
            <!-- Start col -->
            <div class="col-lg-12">
                <div class="card m-b-30">
                <div class="card-header">
                        <div class="row align-items-center">
                            <div class="col-6">
                                <h5 class="card-title mb-0">All Orders</h5>
                            </div>
                            <div class="col-6 d-flex justify-content-end">
                                <form id="switchForm" action="{{ route('orders.index') }}" method="GET">
                                    <div class="form-check form-switch float-right">
                                        <input type="checkbox" class="form-check-input" id="customSwitch" name="is_shipment_close" value="yes" {{ request('is_shipment_close') === 'yes' ? 'checked' : '' }}>
                                        <label class="form-check-label" for="customSwitch">All</label>
                                    </div>
                                    <input type="hidden" name="month" value="{{ request('month', $month) }}">
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                     {{-- Filter Form --}}
                     <form id="monthForm" action="{{ route('orders.index') }}" method="GET" class="mt-3">
                        <div class="d-flex justify-content-center align-items-center">
                            <!-- Previous month button -->
                            <button type="button" id="prevMonth" class="btn btn-primary mr-2">
                                <i class="feather icon-arrow-left"></i>
                            </button>

                            <!-- Month input -->
                            <div>
                                <input type="month" id="monthInput" name="month" class="form-control text-capitalize" value="{{ old('month', $month) }}">
                            </div>

                            <!-- Next month button -->
                            <button type="button" id="nextMonth" class="btn btn-primary ml-2">
                                <i class="feather icon-arrow-right"></i>
                            </button>
                        </div>
                        <input type="hidden" name="is_shipment_close" value="{{ request('is_shipment_close') }}">
                    </form>
                    <br>
                   
                    <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead class="text-center">
                                    <tr>
                                        @php
                                            $canEdit = Gate::check('bd-department-edit') || Gate::check('logistic-department-edit');
                                            $span = $canEdit ? 7 : 5;
                                            $dbSpan = $canEdit ? 8 : 6;
                                        @endphp
                                        <th colspan="{{$span}}" class="font-weight-bold logistic text-nowrap">Invoice</th>
                                        <th colspan="{{$dbSpan}}" class="font-weight-bold bd-department text-nowrap">BD Department</th>
                                        <th colspan="3" class="font-weight-bold purchase text-nowrap">Purchase Department</th>
                                        <th colspan="6" class="font-weight-bold where-house text-nowrap">WareHouse Department (Inward)</th>
                                        <th class="font-weight-bold billing text-nowrap" colspan="2">Billing</th>
                                        <th colspan="2" class="font-weight-bold where-house-packing-list text-nowrap">Ware House (Packing List)</th>
                                        <th colspan="11" class="font-weight-bold logistic text-nowrap">Logistic Department</th>
                                    </tr>
                                </thead>
                                <thead class="text-center">
                                    <tr>
                                        <th class="font-weight-bold text-nowrap">Invoice Date</th>
                                        <th class="font-weight-bold text-nowrap">Invoice No</th>
                                        <th class="font-weight-bold text-nowrap">PI No</th>
                                        @if($canEdit)
                                            <th class="font-weight-bold text-nowrap">Bill To</th>
                                            <th class="font-weight-bold text-nowrap">Ship To</th>
                                        @endif
                                        <th class="font-weight-bold text-nowrap">Created By</th>
                                        <th class="font-weight-bold text-nowrap">Edit</th>
                                        <th class="font-weight-bold text-nowrap">Country</th>
                                        <th class="font-weight-bold text-nowrap">Currency </th>
                                        <th class="font-weight-bold text-nowrap">Product Description</th>
                                        <th class="font-weight-bold text-nowrap">Pack Size</th>
                                        <th class="font-weight-bold text-nowrap">Pack Quantity</th>
                                        @if($canEdit)
                                        <th class="font-weight-bold text-nowrap">Price Per Set</th>
                                        <th class="font-weight-bold text-nowrap">Total</th>
                                        @endif
                                        <th class="font-weight-bold text-nowrap">Edit BD</th>
                                        <th class="font-weight-bold text-nowrap">Order Placed</th>
                                        <th class="font-weight-bold text-nowrap">Expected Delivery</th>
                                        <th class="font-weight-bold text-nowrap">Edit PD</th>
                                        <th class="font-weight-bold text-nowrap">Stock Recived & Varified</th>
                                        <th class="font-weight-bold text-nowrap">Batch No</th>
                                        <th class="font-weight-bold text-nowrap">MFG Date</th>
                                        <th class="font-weight-bold text-nowrap">Expiry</th>
                                        <th class="font-weight-bold text-nowrap">Quantity</th>
                                        <th class="font-weight-bold text-nowrap">Edit WD</th>
                                        <th class="font-weight-bold text-nowrap">Purchase Entry (Done/Pending)</th>
                                        <th class="font-weight-bold text-nowrap">Edit Billing</th>
                                        <th class="font-weight-bold text-nowrap">Packing List</th>
                                        <th class="font-weight-bold text-nowrap">Edit WHP</th>
                                        <th class="font-weight-bold text-nowrap">Shiping Documents (Done/Pending)</th>
                                        <th class="font-weight-bold text-nowrap">Tax Invoice & Eway Bill (Done/Pending)</th>
                                        <th class="font-weight-bold text-nowrap">Arrange Pick Up (Done/Pending)</th>
                                        <th class="font-weight-bold text-nowrap">Shipment Dispached</th>
                                        <th class="font-weight-bold text-nowrap">AWB Handover</th>
                                        <th class="font-weight-bold text-nowrap">Shipment Close</th>
                                        <th class="font-weight-bold text-nowrap">Edit LD</th>
                                        <th class="font-weight-bold text-nowrap">Custom Invoice</th>
                                        <th class="font-weight-bold text-nowrap">Customer Invoice</th>
                                        <th class="font-weight-bold text-nowrap">Custom Packing Invoice</th>
                                        <th class="font-weight-bold text-nowrap">Customer Packing Invoice</th>
                                    </tr>
                                </thead>
                                <tbody class="text-center">
                                    @foreach($orders as $order)
                                        @php
                                           $isShowBilling = warehouseIssueCheck($order);
                                           $isShowPackingList = bdIssueCheck($order);

                                            // Function to calculate totalValue including additional fields
                                            $totalValue = calculateTotalValue($order);
                                        @endphp
                                        @php
                                            $numProducts = $order->orderProducts->count();
                                            foreach ($order->orderProducts as $product) {
                                                $numProductStock = $product->orderProductStocks->count();
                                                
                                                if($numProductStock > 0){
                                                    $numProducts = $numProducts + ($numProductStock - 1);
                                                }
                                            }

                                            $invoice_department_color = "background-color: " . ($order->invoice_department_color ?? "#fff") . ";";
                                            $bd_department_color = "background-color: " . ($order->bd_department_color ?? "#fff") . ";";
                                            $purchase_department_color = "background-color: " . ($order->purchase_department_color ?? "#fff") . ";";
                                            $warehouse_department_color = "background-color: " . ($order->warehouse_department_color ?? "#fff") . ";";
                                            $billing_department_color = "background-color: " . ($order->billing_department_color ?? "#fff") . ";";
                                            $wareHousePackingList_department_color = "background-color: " . ($order->wareHousePackingList_department_color ?? "#fff") . ";";
                                            $logistic_department_color = "background-color: " . ($order->logistic_department_color ?? "#fff") . ";";
                                        @endphp
                                    <tr>
                                        <td rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" class="font-weight-normal text-nowrap" style="{{ $invoice_department_color }}">
                                            {{ $order->invoice_date ? \Carbon\Carbon::parse($order->invoice_date)->format('d-m-Y') : '' }}
                                        </td>
                                        <td rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" class="font-weight-normal text-nowrap" style="{{ $invoice_department_color }}">{{ $order->invoice_no }}</td>
                                        <td rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" class="font-weight-normal text-nowrap" style="{{ $invoice_department_color }}">{{ $order->pi_number }}</td>
                                        @if($canEdit)
                                        <td rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" class="font-weight-normal text-nowrap" style="{{ $invoice_department_color }}">
                                            <span class="default-info">
                                                @if($order->bill_to_customer_id != null)
                                                    {{ $order->bill_to_client_code }} / {{ $order->bill_to_company_name }}, 
                                                @endif
                                            </span>
                                            <span class="toggle-arrow">▼</span><br>
                                            <span class="additional-info" style="display: none;">
                                                @if($order->bill_to_customer_id != null)
                                                    <span>{{ $order->bill_to_address }}, {{ $order->bill_to_zip_code }}</span><br>
                                                    <span><strong>Registration No:</strong> {{ $order->bill_to_registration_no }}</span><br>
                                                    <span>{{ $order->bill_to_email }}, {{ $order->bill_to_phone_no }}</span>
                                                @endif
                                            </span>
                                        </td>
                                        <td rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" class="font-weight-normal text-nowrap" style="{{ $invoice_department_color }}">
                                            <span class="default-info">
                                                @if($order->ship_to_customer_id != null)                                
                                               {{ $order->ship_to_client_code }} / {{ $order->ship_to_company_name }}
                                                @endif
                                            </span>
                                            <span class="toggle-arrow">▼</span><br>
                                            <span class="additional-info" style="display: none;">
                                                @if($order->ship_to_customer_id != null)                                
                                                    <span>{{ $order->ship_to_address }}, {{ $order->ship_to_zip_code }}</span><br>
                                                    <span><strong>Registration No:</strong> {{ $order->ship_to_registration_no }}</span><br>
                                                    <span>{{ $order->ship_to_email }}, {{ $order->ship_to_phone_no }}</span><br>
                                                @endif
                                            </span>
                                        </td>
                                        @endif
                                        <td rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" class="font-weight-normal text-nowrap" style="{{ $invoice_department_color }}">
                                             {{ $users->firstWhere('id', $order->created_by)->name ?? '' }}
                                        </td>
                                        <td rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" class="font-weight-normal text-nowrap" style="{{ $invoice_department_color }}">
                                            @can('order-edit')
                                                @if($order->is_shipment_close != 'yes')
                                                    <a href="{{ route('orders.editOrder', ['order' => $order->id, 'redirect' => urlencode(url()->full())]) }}" class="btn btn-success-rgba">
                                                        <i class="feather icon-edit-2"></i>
                                                    </a>
                                                @endif
                                            @endcan
                                        </td>
                                        <td rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" class="font-weight-normal text-nowrap" style="{{ $bd_department_color }}">{{ $order->country }}</td>
                                        <td rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" class="font-weight-normal text-nowrap" style="{{ $bd_department_color }}">{{ $order->currency }}</td>
                                        @if($numProducts > 0)
                                            @foreach($order->orderProducts as $productIndex => $orderProduct)
                                                    @php
                                                        $numProductStock = $orderProduct->orderProductStocks->count();
                                                    @endphp
                                                    @php
                                                        $productDes = '';
                                                        $productVariantName = '';
                                                        if ($orderProduct->product_id == $orderProduct->products->id) {
                                                            $productDes = $orderProduct->products->name;
                                                        }
                                                        if ($orderProduct->product_variant_id == $orderProduct->productVariants->id) {
                                                            $productVariantName = $orderProduct->productVariants->name;
                                                        }
                                                    @endphp
                                                <td data-highlight-product-id="{{ $orderProduct->id }}" data-field="product_id" class="font-weight-normal text-nowrap" rowspan="{{ $numProductStock > 0 ? $numProductStock : 1 }}" style="{{ $bd_department_color }}">{{ $productDes }}</td>
                                                <td data-highlight-product-id="{{ $orderProduct->id }}" data-field="product_variant_id" class="font-weight-normal text-nowrap" rowspan="{{ $numProductStock > 0 ? $numProductStock : 1 }}" style="{{ $bd_department_color }}">{{ $productVariantName }}</td>
                                                <td data-highlight-product-id="{{ $orderProduct->id }}"  data-field="quantity" class="font-weight-normal text-nowrap" rowspan="{{ $numProductStock > 0 ? $numProductStock : 1 }}" style="{{ $bd_department_color }}">{{ $orderProduct->quantity }}</td>
                                                @if($canEdit)
                                                    <td data-highlight-product-id="{{ $orderProduct->id }}" data-field="price_per_set" class="font-weight-normal text-nowrap" rowspan="{{ $numProductStock > 0 ? $numProductStock : 1 }}" style="{{ $bd_department_color }}">{{ format_currency($orderProduct->price_per_set) }}</td>
                                                    <td data-highlight-product-id="{{ $orderProduct->id }}" data-field="total" class="font-weight-normal text-nowrap" rowspan="{{ $numProductStock > 0 ? $numProductStock : 1 }}" style="{{ $bd_department_color }}">{{ format_currency($orderProduct->total) }}</td>
                                                @endif
                                                @if($productIndex === 0)
                                                    <td rowspan="{{ $numProducts }}" class="font-weight-normal text-nowrap" style="{{ $bd_department_color }}">
                                                       @can('bd-department-edit')
                                                        @if($order->is_shipment_close != 'yes')
                                                            <a href="{{ route('orderProducts.edit', ['orderProduct' => $order->id, 'redirect' => urlencode(url()->full())]) }}" class="btn btn-success-rgba">
                                                                    <i class="feather icon-edit-2"></i>
                                                            </a>
                                                        @endif
                                                       @endcan
                                                       @can('order-delete')
                                                        @if($order->is_shipment_close != 'yes')
                                                            <button 
                                                                type="button" 
                                                                data-order-id="{{ $order->id }}" 
                                                                data-redirect-url="{{ request('redirect') ?? url()->full() }}" 
                                                                class="btn btn-danger-rgba deleteOrder">
                                                                <i class="feather icon-trash"></i>
                                                            </button>
                                                        @endif
                                                        @endcan
                                                    </td>
                                                @endif
                                                <td data-highlight-purchase-id="{{ $orderProduct->id }}" class="font-weight-normal text-nowrap" rowspan="{{ $numProductStock > 0 ? $numProductStock : 1 }}" style="
                                                        @if ($orderProduct->is_order_placed == 'no' || $orderProduct->is_order_placed == 'error')
                                                            background-color: #f4c7c3;
                                                        @else
                                                           {{ $purchase_department_color }};
                                                        @endif
                                                    ">
                                                    @if ($orderProduct->is_order_placed == 'no' || $orderProduct->is_order_placed == 'error')
                                                        <span data-toggle="tooltip" data-placement="top" title="{{ $orderProduct->note }}">{{ $orderProduct->is_order_placed }}</span>
                                                    @else
                                                        {{ $orderProduct->is_order_placed }}
                                                    @endif
                                                </td>
                                                <td data-highlight-purchase-id="{{ $orderProduct->id }}" data-field="expected_delivery_date" class="font-weight-normal text-nowrap" rowspan="{{ $numProductStock > 0 ? $numProductStock : 1 }}" style="{{ $purchase_department_color }}">
                                                    {{ $orderProduct->expected_delivery_date ? \Carbon\Carbon::parse($orderProduct->expected_delivery_date)->format('d-m-Y') : '' }}
                                                </td>
                                                @if($productIndex === 0)
                                                    <td rowspan="{{ $numProducts }}" class="font-weight-normal text-nowrap" style="{{ $purchase_department_color }}">
                                                       @can('purchase-department-edit')
                                                         @if($numProducts > 0)
                                                            @if($order->is_shipment_close != 'yes')
                                                                <a href="{{ route('orderPurchase.edit', ['orderPurchase' => $order->id, 'redirect' => urlencode(url()->full())]) }}" class="btn btn-success-rgba"><i class="feather icon-edit-2"></i></a>
                                                            @endif
                                                        @endif
                                                       @endcan
                                                    </td>
                                                @endif
                                                @php
                                                    $numProductStock = $orderProduct->orderProductStocks->count();
                                                @endphp
                                         @if($numProductStock > 0)
                                            @foreach($orderProduct->orderProductStocks as $stockIndex => $orderProductStock)
                                                <td data-highlight-product-stock-id="{{ $orderProductStock->id }}" data-field="is_stock_received" class="font-weight-normal text-nowrap" style="
                                                        @if ($orderProductStock->is_stock_received == 'no')
                                                            background-color: #f4c7c3;
                                                        @else
                                                            {{ $warehouse_department_color }};
                                                        @endif
                                                    ">
                                                {{ $orderProductStock->is_stock_received }}</td>
                                                <td data-highlight-product-stock-id="{{ $orderProductStock->id }}" data-field="batch_no" class="font-weight-normal text-nowrap" style="{{ $warehouse_department_color }}">{{ $orderProductStock->batch_no }}</td>
                                                @php 
                                                    $mfg_date = $orderProductStock->mfg_date ? DateTime::createFromFormat('Y-n', $orderProductStock->mfg_date) : null;
                                                    $exp_date = $orderProductStock->exp_date ? DateTime::createFromFormat('Y-n', $orderProductStock->exp_date) : null;
                                                @endphp
                                                <td data-highlight-product-stock-id="{{ $orderProductStock->id }}" data-field="mfg_date" class="font-weight-normal text-nowrap" style="{{ $warehouse_department_color }}">{{ $mfg_date ? $mfg_date->format('n/Y') : '' }}</td>
                                                <td data-highlight-product-stock-id="{{ $orderProductStock->id }}" data-field="exp_date" class="font-weight-normal text-nowrap" style="{{ $warehouse_department_color }}">{{ $exp_date ? $exp_date->format('n/Y') : '' }}</td>
                                                <td data-highlight-product-stock-id="{{ $orderProductStock->id }}" data-field="quantity" class="font-weight-normal text-nowrap" style="{{ $warehouse_department_color }}">{{ $orderProductStock->quantity }}</td>
                                                @if($stockIndex === 0)
                                                    <td rowspan="{{ $numProductStock }}" class="font-weight-normal text-nowrap" style="{{ $warehouse_department_color }}">
                                                        @can('wareHouse-department-edit')
                                                            @if ($numProducts > 0)
                                                                @if($order->is_shipment_close != 'yes')                                                                 
                                                                    <a href="{{ route('orderProductStock.edit',['orderProductStock' => $orderProduct->id, 'redirect' => urlencode(url()->full())]) }}" class="btn btn-success-rgba"><i class="feather icon-edit-2"></i></a>
                                                                @endif
                                                            @endif
                                                        @endcan
                                                    </td>
                                                @endif
                                                <td data-highlight-billing-id="{{ $orderProductStock->id }}" class="font-weight-normal text-nowrap" style="{{ $billing_department_color }}">{{ $orderProductStock->is_purchase_entry_done }}</td>
                                                @if($stockIndex === 0)
                                                    <td rowspan="{{ $numProductStock }}" class="font-weight-normal" style="{{ $billing_department_color }}">
                                                       @can('billing-edit')
                                                            @if ($isShowBilling === true)
                                                                @if($order->is_shipment_close != 'yes')
                                                                    <a href="{{ route('billing.edit',['billing' => $orderProduct->id, 'redirect' => urlencode(url()->full())]) }}" class="btn btn-success-rgba"><i class="feather icon-edit-2"></i></a>
                                                                @endif
                                                            @endif
                                                       @endcan
                                                    </td>
                                                @endif
                                                @if($productIndex == 0 && $stockIndex==0)
                                                    <td class="font-weight-normal text-nowrap" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" style="{{ $wareHousePackingList_department_color }}">
                                                    @php
                                                     $orderPackageValue = $order->orderPackages->count();
                                                    @endphp
                                                    @if (isset($orderPackageValue) && $orderPackageValue > 0)
                                                    <table>
                                                            <thead>
                                                                <tr>
                                                                <th class="font-weight-bold text-nowrap">Box Number</th>
                                                                <th class="font-weight-bold text-nowrap">Product Name</th>
                                                                <th class="font-weight-bold text-nowrap">Quantity Per Box</th>
                                                                <th class="font-weight-bold text-nowrap">Box Diametion (CMs)</th>
                                                                <th class="font-weight-bold text-nowrap">Gross Weight (Kgs)</th>
                                                                <th class="font-weight-bold text-nowrap">Net Weight (Kgs)</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                @foreach ($order->orderPackages as $packageIndex => $orderPackage)
                                                                    @php
                                                                        $numPackageProducts = count($orderPackage->orderPackageProducts);
                                                                    @endphp
                                                                    @if ($numPackageProducts > 0)
                                                                        @foreach ($orderPackage->orderPackageProducts as $packageProductIndex => $packageProduct)
                                                                            <tr>
                                                                                @if ($packageProductIndex == 0) <!-- Check if it's the first product to add rowspans -->
                                                                                    <td data-highlight-package-id="{{ $orderPackage->id }}" data-highlight-package-product-id="{{ $packageProduct->id }}" data-field="box_no" rowspan="{{ $numPackageProducts > 0 ? $numPackageProducts : 0 }}" class="font-weight-normal text-nowrap">{{ $orderPackage->box_no }}</td>
                                                                                @endif
                                                                                @php
                                                                                $productName = '';
                                                                                foreach ($order->orderProducts as $orderProduct) {
                                                                                    if ($orderProduct->id == $packageProduct->order_product_id) {
                                                                                        $product = $orderProduct->products->firstWhere('id', $orderProduct->product_id);
                                                                                        if ($product) {
                                                                                            $productName = $product->name;
                                                                                            break;
                                                                                        }
                                                                                    }
                                                                                }
                                                                               @endphp
                                                                                <td data-highlight-package-product-id="{{ $packageProduct->id }}" data-field="order_product_id" class="font-weight-normal text-nowrap" >{{ $productName }}</td>
                                                                                <td data-highlight-package-product-id="{{ $packageProduct->id }}" data-field="quantity" class="font-weight-normal text-nowrap">{{ $packageProduct->quantity }}</td>
                                                                                @if ($packageProductIndex == 0) 
                                                                                    <td data-highlight-package-id="{{ $orderPackage->id }}" data-highlight-package-product-id="{{ $packageProduct->id }}" data-field="dimension" rowspan="{{ $numPackageProducts > 0 ? $numPackageProducts : 0 }}" class="font-weight-normal text-nowrap">{{ $orderPackage->dimension }}</td>
                                                                                    <td data-highlight-package-id="{{ $orderPackage->id }}" data-highlight-package-product-id="{{ $packageProduct->id }}" data-field="gross_weight" rowspan="{{ $numPackageProducts > 0 ? $numPackageProducts : 0 }}" class="font-weight-normal text-nowrap">{{ remove_trailing_zeros($orderPackage->gross_weight) }}</td>
                                                                                    <td data-highlight-package-id="{{ $orderPackage->id }}" data-highlight-package-product-id="{{ $packageProduct->id }}" data-field="net_weight" rowspan="{{ $numPackageProducts > 0 ? $numPackageProducts : 0 }}" class="font-weight-normal text-nowrap">{{ remove_trailing_zeros($orderPackage->net_weight) }}</td>
                                                                                @endif
                                                                            </tr>
                                                                        @endforeach
                                                                    @else
                                                                        <tr>
                                                                            <td class="font-weight-normal text-nowrap">{{ $orderPackage->box_no }}</td>
                                                                            <td colspan="2" class="font-weight-normal">No products</td>
                                                                            <td class="font-weight-normal text-nowrap">{{ $orderPackage->dimension }}</td>
                                                                            <td class="font-weight-normal text-nowrap">{{ remove_trailing_zeros($orderPackage->gross_weight) }}</td>
                                                                            <td class="font-weight-normal text-nowrap">{{ remove_trailing_zeros($orderPackage->net_weight) }}</td>
                                                                        </tr>
                                                                    @endif
                                                                @endforeach
                                                            </tbody>
                                                        </table>
                                                        @endif
                                                    </td>
                                                    <td class="font-weight-normal text-nowrap" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" style="{{ $wareHousePackingList_department_color }}">
                                                       @can('wareHouse-packing-list-edit')
                                                         @if ($isShowPackingList === true)
                                                            @if($order->is_shipment_close != 'yes')
                                                                <a href="{{ route('orderPackage.edit', ['orderPackage' => $order->id, 'redirect' => urlencode(url()->full())]) }}" class="btn btn-success-rgba"><i class="feather icon-edit-2"></i></a>
                                                            @endif
                                                         @endif
                                                       @endcan
                                                    </td>
                                                    <td class="font-weight-normal text-nowrap" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" style="
                                                        @if ($order->is_shipping_documents_done == 'no')
                                                            background-color: #f4c7c3;
                                                        @else
                                                          {{ $logistic_department_color }};
                                                        @endif
                                                    ">{{ $order->is_shipping_documents_done }}</td>
                                                    <td class="font-weight-normal text-nowrap" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" style="
                                                        @if ($order->is_tax_invoice_eway_billP_done == 'no')
                                                            background-color: #f4c7c3;
                                                        @else
                                                          {{ $logistic_department_color }};
                                                        @endif
                                                    ">{{ $order->is_tax_invoice_eway_billP_done }}</td>
                                                    <td class="font-weight-normal text-nowrap" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" style="
                                                        @if ($order->is_arrange_pick_up == 'no')
                                                            background-color: #f4c7c3;
                                                        @else
                                                          {{ $logistic_department_color }};
                                                        @endif
                                                    ">{{ $order->is_arrange_pick_up }}</td>
                                                    <td class="font-weight-normal text-nowrap" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" style="
                                                        @if ($order->is_shipment_dispatched == 'no')
                                                            background-color: #f4c7c3;
                                                        @else
                                                          {{ $logistic_department_color }};
                                                        @endif
                                                    ">{{ $order->is_shipment_dispatched }}</td>
                                                    <td class="font-weight-normal text-nowrap" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" style="
                                                        @if ($order->is_awb_handover == 'no')
                                                            background-color: #f4c7c3;
                                                        @else
                                                          {{ $logistic_department_color }};
                                                        @endif
                                                    ">{{ $order->is_awb_handover }}</td>
                                                    <td class="font-weight-normal text-nowrap" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" style="
                                                        @if ($order->is_shipment_close == 'no')
                                                            background-color: #f4c7c3;
                                                        @else
                                                          {{ $logistic_department_color }};
                                                        @endif
                                                    ">{{ $order->is_shipment_close }}</td>
                                                    <td class="font-weight-normal text-nowrap" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" style="{{ $logistic_department_color }}">
                                                       @can('logistic-department-edit')
                                                        @if($order->is_shipment_close != 'yes') 
                                                            <a href="{{ route('orders.edit', ['order' => $order->id, 'redirect' => urlencode(url()->full())]) }}" class="btn btn-success-rgba"><i class="feather icon-edit-2"></i></a>
                                                        @endif
                                                       @endcan
                                                    </td> 
                                                    @canany(['bd-department-list', 'bd-department-edit', 'logistic-department-edit'])
                                                        <td class="font-weight-normal text-nowrap" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}"><a href="{{ route('pdf.customInvoice', $order->id) }}" class="btn btn-primary-rgba"><i class="feather icon-download"></i></a></td>
                                                        <td class="font-weight-normal text-nowrap" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}"><a href="{{ route('pdf.customerInvoice', $order->id) }}" class="btn btn-primary-rgba"><i class="feather icon-download"></i></a></td>
                                                        <td class="font-weight-normal text-nowrap" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}"> <a href="{{ route('pdf.customPacking', $order->id) }}" class="btn btn-primary-rgba"><i class="feather icon-download"></i></a></td>
                                                        <td class="font-weight-normal text-nowrap" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}"><a href="{{ route('pdf.customerPacking', $order->id) }}" class="btn btn-primary-rgba"><i class="feather icon-download"></i></a></td>
                                                    @endcanany
                                                @endif
                                    </tr>
                                        <tr>
                                            @endforeach
                                        @else
                                            <td class="font-weight-normal" style="{{ $warehouse_department_color }}"></td>
                                            <td class="font-weight-normal" style="{{ $warehouse_department_color }}"></td>
                                            <td class="font-weight-normal" style="{{ $warehouse_department_color }}"></td>
                                            <td class="font-weight-normal" style="{{ $warehouse_department_color }}"></td>
                                            <td class="font-weight-normal" style="{{ $warehouse_department_color }}"></td>
                                            <td rowspan="1" class="font-weight-normal" style="{{ $warehouse_department_color }}">
                                               @can('wareHouse-department-edit')
                                                    @if ($numProducts > 0)
                                                        @if($order->is_shipment_close != 'yes')
                                                            <a href="{{ route('orderProductStock.edit',['orderProductStock' => $orderProduct->id, 'redirect' => urlencode(url()->full())]) }}" class="btn btn-success-rgba"><i class="feather icon-edit-2"></i></a>
                                                        @endif
                                                    @endif
                                               @endcan
                                            </td>
                                            <td class="font-weight-normal" style="{{ $billing_department_color }}"></td>
                                            <td rowspan="1" class="font-weight-normal" style="{{ $billing_department_color }}">
                                              @can('billing-edit')
                                                @if ($isShowBilling === true)
                                                    @if($order->is_shipment_close != 'yes')
                                                      <a href="{{ route('billing.edit', ['billing' => $orderProduct->id, 'redirect' => urlencode(url()->full())]) }}" class="btn btn-success-rgba"><i class="feather icon-edit-2"></i></a>
                                                    @endif
                                                @endif
                                              @endcan
                                            </td>
                                            @if($productIndex == 0)
                                            <td rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}">
                                            @if (isset($orderPackageValue) && $orderPackageValue > 0)
                                                <table class="table table-bordered">
                                                    <thead class="text-center">
                                                        <tr>
                                                            <th class="font-weight-bold text-nowrap">Box Number</th>
                                                            <th class="font-weight-bold text-nowrap">Product Name</th>
                                                            <th class="font-weight-bold text-nowrap">Quantity Per Box</th>
                                                            <th class="font-weight-bold text-nowrap">Box Diametion (CMs)</th>
                                                            <th class="font-weight-bold text-nowrap">Gross Weight (Kgs)</th>
                                                            <th class="font-weight-bold text-nowrap">Net Weight (Kgs)</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    @foreach ($order->orderPackages as $packageIndex => $orderPackage)
                                                        @php
                                                            $numPackageProducts = count($orderPackage->orderPackageProducts);
                                                        @endphp
                                                        @if ($numPackageProducts > 0)
                                                            @foreach ($orderPackage->orderPackageProducts as $packageProductIndex => $packageProduct)
                                                                <tr>
                                                                    @if ($packageProductIndex == 0) 
                                                                    <td data-highlight-package-id="{{ $orderPackage->id }}" data-highlight-package-product-id="{{ $packageProduct->id }}" data-field="box_no" rowspan="{{ $numPackageProducts > 0 ? $numPackageProducts : 0 }}" class="font-weight-normal text-nowrap">{{ $orderPackage->box_no }}</td>
                                                                    @endif
                                                                    @php
                                                                    $productName = '';
                                                                    foreach ($order->orderProducts as $orderProduct) {
                                                                        if ($orderProduct->id == $packageProduct->order_product_id) {
                                                                            $product = $orderProduct->products->firstWhere('id', $orderProduct->product_id);
                                                                            if ($product) {
                                                                                $productName = $product->name;
                                                                                break;
                                                                            }
                                                                        }
                                                                    }
                                                                    @endphp
                                                                    <td data-highlight-package-product-id="{{ $packageProduct->id }}" data-field="order_product_id" class="font-weight-normal text-nowrap" >{{ $productName }}</td>
                                                                    <td data-highlight-package-product-id="{{ $packageProduct->id }}" data-field="quantity" class="font-weight-normal text-nowrap">{{ $packageProduct->quantity }}</td>
                                                                    @if ($packageProductIndex == 0) 
                                                                    <td data-highlight-package-id="{{ $orderPackage->id }}" data-highlight-package-product-id="{{ $packageProduct->id }}" data-field="dimension" rowspan="{{ $numPackageProducts > 0 ? $numPackageProducts : 0 }}" class="font-weight-normal text-nowrap">{{ $orderPackage->dimension }}</td>
                                                                    <td data-highlight-package-id="{{ $orderPackage->id }}" data-highlight-package-product-id="{{ $packageProduct->id }}" data-field="gross_weight" rowspan="{{ $numPackageProducts > 0 ? $numPackageProducts : 0 }}" class="font-weight-normal text-nowrap">{{ remove_trailing_zeros($orderPackage->gross_weight) }}</td>
                                                                    <td data-highlight-package-id="{{ $orderPackage->id }}" data-highlight-package-product-id="{{ $packageProduct->id }}" data-field="net_weight" rowspan="{{ $numPackageProducts > 0 ? $numPackageProducts : 0 }}" class="font-weight-normal text-nowrap">{{ remove_trailing_zeros($orderPackage->net_weight) }}</td>
                                                                    @endif
                                                                </tr>
                                                            @endforeach
                                                        @else
                                                            <tr>
                                                                <td class="font-weight-normal text-nowrap">{{ $orderPackage->box_no }}</td>
                                                                <td colspan="2" class="font-weight-normal">No products</td>
                                                                <td class="font-weight-normal text-nowrap">{{ $orderPackage->dimension }}</td>
                                                                <td class="font-weight-normal text-nowrap">{{ $orderPackage->gross_weight }}</td>
                                                                <td class="font-weight-normal text-nowrap">{{ $orderPackage->net_weight }}</td>
                                                            </tr>
                                                        @endif
                                                    @endforeach
                                                </tbody>
                                                </table>
                                                @endif
                                             </td>
                                            <td class="font-weight-normal" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" style="{{ $wareHousePackingList_department_color }}">
                                              @can('wareHouse-packing-list-edit')
                                                @if ($isShowPackingList === true)
                                                    @if($order->is_shipment_close != 'yes')
                                                        <a href="{{ route('orderPackage.edit', ['orderPackage' => $order->id, 'redirect' => urlencode(url()->full())]) }}" class="btn btn-success-rgba"><i class="feather icon-edit-2"></i></a>
                                                    @endif
                                                @endif
                                              @endcan
                                            </td>
                                            <td class="font-weight-normal text-nowrap" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" style="
                                            @if ($order->is_shipping_documents_done == 'no')
                                                background-color: #f4c7c3;
                                            @else
                                                {{ $logistic_department_color }};
                                            @endif
                                        ">{{ $order->is_shipping_documents_done }}</td>
                                        <td class="font-weight-normal text-nowrap" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" style="
                                            @if ($order->is_tax_invoice_eway_billP_done == 'no')
                                                background-color: #f4c7c3;
                                            @else
                                                {{ $logistic_department_color }};
                                            @endif
                                        ">{{ $order->is_tax_invoice_eway_billP_done }}</td>
                                        <td class="font-weight-normal text-nowrap" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" style="
                                            @if ($order->is_arrange_pick_up == 'no')
                                                background-color: #f4c7c3;
                                            @else
                                                {{ $logistic_department_color }};
                                            @endif
                                        ">{{ $order->is_arrange_pick_up }}</td>
                                        <td class="font-weight-normal text-nowrap" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" style="
                                            @if ($order->is_shipment_dispatched == 'no')
                                                background-color: #f4c7c3;
                                            @else
                                                {{ $logistic_department_color }};
                                            @endif
                                        ">{{ $order->is_shipment_dispatched }}</td>
                                        <td class="font-weight-normal text-nowrap" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" style="
                                            @if ($order->is_awb_handover == 'no')
                                                background-color: #f4c7c3;
                                            @else
                                                {{ $logistic_department_color }};
                                            @endif
                                        ">{{ $order->is_awb_handover }}</td>
                                        <td class="font-weight-normal text-nowrap" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" style="
                                            @if ($order->is_shipment_close == 'no')
                                                background-color: #f4c7c3;
                                            @else
                                                {{ $logistic_department_color }};
                                            @endif
                                        ">{{ $order->is_shipment_close }}</td>
                                            <td class="font-weight-normal text-nowrap" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" style="{{ $logistic_department_color }}">
                                               @can('logistic-department-edit')
                                                @if($order->is_shipment_close != 'yes')
                                                    <a href="{{ route('orders.edit', ['order' => $order->id, 'redirect' => urlencode(url()->full())]) }}" class="btn btn-success-rgba"><i class="feather icon-edit-2"></i></a>
                                                @endif
                                               @endcan
                                            </td>
                                                 @canany(['bd-department-list', 'bd-department-edit', 'logistic-department-edit'])
                                                    <td class="font-weight-normal text-nowrap" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}"> <a href="{{ route('pdf.customInvoice', $order->id) }}" class="btn btn-primary-rgba"><i class="feather icon-download"></i></a></td>
                                                    <td class="font-weight-normal text-nowrap" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}"> <a href="{{ route('pdf.customerInvoice', $order->id) }}" class="btn btn-primary-rgba"><i class="feather icon-download"></i></a></td>
                                                    <td class="font-weight-normal text-nowrap" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}"> <a href="{{ route('pdf.customPacking', $order->id) }}" class="btn btn-primary-rgba"><i class="feather icon-download"></i></a></td>
                                                    <td class="font-weight-normal text-nowrap" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}"> <a href="{{ route('pdf.customerPacking', $order->id) }}" class="btn btn-primary-rgba"><i class="feather icon-download"></i></a></td>
                                                @endcanany
                                            @endif
                                        </tr><tr>
                                        @endif
                                               <!-- Additional rows for shipping, soft boxes, data logger, clearance, and total -->
                                                @if($loop->last)
                                                    @include('partials.additional_rows', ['order' => $order, 'totalValue' => $totalValue, 'canEdit' => $canEdit])
                                                @endif                     
                                            @endforeach
                                        @else
                                            <td class="font-weight-normal" style="{{ $bd_department_color }}"></td>
                                            <td class="font-weight-normal" style="{{ $bd_department_color }}"></td>
                                            <td class="font-weight-normal" style="{{ $bd_department_color }}"></td>
                                            @if($canEdit)
                                                <td class="font-weight-normal" style="{{ $bd_department_color }}"></td>
                                                <td class="font-weight-normal" style="{{ $bd_department_color }}"></td>
                                            @endif
                                            <td rowspan="1" class="font-weight-normal" style="{{ $bd_department_color }}">
                                               @can('bd-department-edit')
                                                @if($order->is_shipment_close != 'yes')
                                                    <a href="{{ route('orderProducts.edit', ['orderProduct' => $order->id, 'redirect' => urlencode(url()->full())]) }}" class="btn btn-success-rgba">
                                                                        <i class="feather icon-edit-2"></i>
                                                    </a>
                                                @endif
                                               @endcan
                                               @can('order-delete')
                                                @if($order->is_shipment_close != 'yes')
                                                    <button 
                                                        type="button" 
                                                        data-order-id="{{ $order->id }}" 
                                                        data-redirect-url="{{ request('redirect') ?? url()->full() }}" 
                                                        class="btn btn-danger-rgba deleteOrder">
                                                        <i class="feather icon-trash"></i>
                                                    </button>
                                                @endif
                                               @endcan
                                            <td>
                                            <td class="font-weight-normal" style="{{ $purchase_department_color }}"></td>
                                            <td class="font-weight-normal" style="{{ $purchase_department_color }}"></td>
                                            <td rowspan="1" class="font-weight-normal" style="{{ $purchase_department_color }}">
                                              @can('purchase-department-edit')
                                                @if ($numProducts > 0)
                                                    @if($order->is_shipment_close != 'yes')
                                                        <a href="{{ route('orderPurchase.edit', ['orderPurchase' => $order->id, 'redirect' => urlencode(url()->full())]) }}" class="btn btn-success-rgba"><i class="feather icon-edit-2"></i></a>
                                                    @endif
                                                @endif
                                              @endcan
                                            </td>
                                            <td class="font-weight-normal" style="{{ $warehouse_department_color }}"></td>
                                            <td class="font-weight-normal" style="{{ $warehouse_department_color }}"></td>
                                            <td class="font-weight-normal" style="{{ $warehouse_department_color }}"></td>
                                            <td class="font-weight-normal" style="{{ $warehouse_department_color }}"></td>
                                            <td rowspan="1" class="font-weight-normal" style="{{ $warehouse_department_color }}">
                                               @can('wareHouse-department-edit')
                                                @if ($numProducts > 0)
                                                    @if($order->is_shipment_close != 'yes')
                                                        <a href="{{ route('orderProductStock.edit',['orderProductStock' => $orderProduct->id, 'redirect' => urlencode(url()->full())]) }}" class="btn btn-success-rgba"><i class="feather icon-edit-2"></i></a>
                                                    @endif
                                                @endif
                                               @endcan
                                            </td>
                                            <td class="font-weight-normal" style="{{ $billing_department_color }}"></td>
                                            <td rowspan="1" class="font-weight-normal" style="{{ $billing_department_color }}">
                                              @can('billing-edit')
                                                @if ($isShowBilling === true)
                                                    @if($order->is_shipment_close != 'yes')              
                                                        <a href="{{ route('billing.edit', ['billing' => $orderProduct->id, 'redirect' => urlencode(url()->full())]) }}" class="btn btn-success-rgba"><i class="feather icon-edit-2"></i></a>
                                                    @endif
                                                @endif
                                              @endcan
                                            </td>
                                            <td class="font-weight-normal" style="{{ $wareHousePackingList_department_color }}"></td>
                                            <td class="font-weight-normal" style="{{ $wareHousePackingList_department_color }}">
                                               @can('wareHouse-packing-list-edit')
                                                @if ($isShowPackingList === true)
                                                    @if($order->is_shipment_close != 'yes')
                                                        <a href="{{ route('orderPackage.edit', ['orderPackage' => $order->id, 'redirect' => urlencode(url()->full())]) }}" class="btn btn-success-rgba"><i class="feather icon-edit-2"></i></a>\
                                                    @endif
                                                @endif
                                               @endcan
                                            </td>
                                            <td class="font-weight-normal text-nowrap"  style="
                                            @if ($order->is_shipping_documents_done == 'no')
                                                background-color: #f4c7c3;
                                            @else
                                                {{ $logistic_department_color }};
                                            @endif
                                        ">{{ $order->is_shipping_documents_done }}</td>
                                        <td class="font-weight-normal text-nowrap"  style="
                                            @if ($order->is_tax_invoice_eway_billP_done == 'no')
                                                background-color: #f4c7c3;
                                            @else
                                                {{ $logistic_department_color }};
                                            @endif
                                        ">{{ $order->is_tax_invoice_eway_billP_done }}</td>
                                        <td class="font-weight-normal text-nowrap"  style="
                                            @if ($order->is_arrange_pick_up == 'no')
                                                background-color: #f4c7c3;
                                            @else
                                                {{ $logistic_department_color }};
                                            @endif
                                        ">{{ $order->is_arrange_pick_up }}</td>
                                        <td class="font-weight-normal text-nowrap"  style="
                                            @if ($order->is_shipment_dispatched == 'no')
                                                background-color: #f4c7c3;
                                            @else
                                                {{ $logistic_department_color }};
                                            @endif
                                        ">{{ $order->is_shipment_dispatched }}</td>
                                        <td class="font-weight-normal text-nowrap"  style="
                                            @if ($order->is_awb_handover == 'no')
                                                background-color: #f4c7c3;
                                            @else
                                                {{ $logistic_department_color }};
                                            @endif
                                        ">{{ $order->is_awb_handover }}</td>
                                        <td class="font-weight-normal text-nowrap"  style="
                                            @if ($order->is_shipment_close == 'no')
                                                background-color: #f4c7c3;
                                            @else
                                                {{ $logistic_department_color }};
                                            @endif
                                        ">{{ $order->is_shipment_close }}</td>
                                             <td class="font-weight-normal" style="{{ $logistic_department_color }}">
                                               @can('logistic-department-edit')
                                                @if($order->is_shipment_close != 'yes')
                                                    <a href="{{ route('orders.edit', ['order' => $order->id, 'redirect' => urlencode(url()->full())]) }}" class="btn btn-success-rgba"><i class="feather icon-edit-2"></i></a>
                                                @endif
                                               @endcan
                                           </td>
                                           @canany(['bd-department-list', 'bd-department-edit', 'logistic-department-edit'])
                                                <td class="font-weight-normal text-nowrap" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}"> <a href="{{ route('pdf.customInvoice', $order->id) }}" class="btn btn-primary-rgba"><i class="feather icon-download"></i></a></td>
                                                <td class="font-weight-normal text-nowrap" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}"> <a href="{{ route('pdf.customerInvoice', $order->id) }}" class="btn btn-primary-rgba"><i class="feather icon-download"></i></a></td>
                                                <td class="font-weight-normal text-nowrap" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}"> <a href="{{ route('pdf.customPacking', $order->id) }}" class="btn btn-primary-rgba"><i class="feather icon-download"></i></a></td>
                                                <td class="font-weight-normal text-nowrap" rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}"> <a href="{{ route('pdf.customerPacking', $order->id) }}" class="btn btn-primary-rgba"><i class="feather icon-download"></i></a></td>
                                            @endcanany 
                                        @endif
                                      </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End col -->
        </div>
        <!-- End row -->

<!-- Order delete model -->
<div class="modal fade" id="deleteOrderModal" tabindex="-1" aria-labelledby="deleteOrderModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Order delete confirmation</h5>
            </div>
            <div class="modal-body">
                Are you sure you want to delete?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-primary" data-dismiss="modal">No</button>
                <button type="button" class="btn btn-outline-danger confirm-delete">yes</button>
            </div>
        </div>
    </div>
</div>
<!-- End Order delete model -->
        
    <!-- End Contentbar -->
@endsection
@section('script')
    <!-- Sweet-Alert js -->
    <script src="{{ asset('assets/plugins/sweet-alert2/sweetalert2.min.js') }}"></script>
    <script src="{{ asset('assets/js/custom/custom-sweet-alert.js') }}"></script>

<!-- DataTables js -->
<script src="{{ asset('assets/plugins/datatables/jquery.dataTables.min.js') }}"></script>
<script src="{{ asset('assets/plugins/datatables/dataTables.bootstrap4.min.js') }}"></script>
<script src="{{ asset('assets/js/highlightRowsAndColumns.js') }}"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Get references to elements
        const monthForm = document.getElementById('monthForm');
        const monthInput = document.getElementById('monthInput');
        const prevButton = document.getElementById('prevMonth');
        const nextButton = document.getElementById('nextMonth');

        // Function to handle previous button click
        prevButton.addEventListener('click', function() {
            const currentDate = new Date(monthInput.value + '-01');
            currentDate.setMonth(currentDate.getMonth() - 1);
            monthInput.value = currentDate.toISOString().slice(0, 7);
            monthForm.submit();
        });

        // Function to handle next button click
        nextButton.addEventListener('click', function() {
            const currentDate = new Date(monthInput.value + '-01');
            currentDate.setMonth(currentDate.getMonth() + 1);
            monthInput.value = currentDate.toISOString().slice(0, 7);
            monthForm.submit();
        });

        // Function to handle month input change
        monthInput.addEventListener('change', function() {
            monthForm.submit();
        });
    });
</script>
<script>
$(document).ready(function() {
    $('.deleteOrder').click(function() {
        var orderId = $(this).data('order-id');
        var redirectUrl = $(this).data('redirect-url'); // Get our redirect URL here

        $('#deleteOrderModal').modal('show');

        $('.confirm-delete').off('click').on('click', function() {
            $.ajax({
                url: '/orders/' + orderId,
                type: 'DELETE',
                data: {
                    _token: '{{ csrf_token() }}'
                },
                success: function(result) {
                    $('#deleteOrderModal').modal('hide');

                    if (result.error) {
                        $('#message').html(
                            '<div class="alert alert-danger alert-dismissible fade show m-0 mt-3" role="alert">' +
                                result.error +
                                '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                                    '<span aria-hidden="true">&times;</span>' +
                                '</button>' +
                            '</div>'
                        );
                    } else if (result.message) {
                        $('#message').html(
                            '<div class="alert alert-success alert-dismissible fade show m-0 mt-3" role="alert">' +
                                result.message +
                                '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                                    '<span aria-hidden="true">&times;</span>' +
                                '</button>' +
                            '</div>'
                        );
                    }

                    // Redirect after 2.5 seconds to our dynamic redirectUrl
                    setTimeout(function() {
                        window.location.href = redirectUrl;
                    }, 2500);
                },
                error: function(xhr, status, error) {
                    console.error(xhr.responseText);
                    alert('Error deleting order.'); 
                }
            });
        });
    });
});

$(document).ready(function(){
    $(".toggle-arrow").click(function(){
        $(this).siblings(".additional-info").toggle();
    });
});
</script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('customSwitch').addEventListener('change', function() {
            document.getElementById('switchForm').submit();
        });
    });
</script>
@endsection
