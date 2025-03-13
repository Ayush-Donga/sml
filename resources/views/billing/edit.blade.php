@section('title')
Edit Order Billing
@endsection
@extends('layouts.main')
@section('style')
<!-- Select2 css -->
<link href="{{ asset('assets/plugins/select2/select2.min.css') }}" rel="stylesheet" type="text/css" />
<!-- Tagsinput css -->
<link href="{{ asset('assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput.css') }}" rel="stylesheet" type="text/css" />
<link href="{{ asset('assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput-typeahead.css') }}" rel="stylesheet" type="text/css" />
@endsection

@section('breadcrumbbar')
<!-- Start Breadcrumbbar -->
<div class="breadcrumbbar">
    <div class="row align-items-center">
        <div class="col-md-8 col-lg-8">
            <h4 class="page-title">@yield('title')</h4>
            <div class="breadcrumb-list">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="{{url('/')}}">Home</a></li>
                    <li class="breadcrumb-item"><a href="{{url('/orders')}}">Orders</a></li>
                    <li class="breadcrumb-item active" aria-current="page">@yield('title')</li>
                </ol>
            </div>
        </div>
        <div class="col-md-4 col-lg-4">
            <div class="widgetbar">
                 <a href="{{ urldecode($redirectUrl) }}" class="btn btn-primary-rgba"><i class="ti-arrow-left mr-2"></i>Back</a>
            </div>
        </div>
    </div>
</div>
<!-- End Breadcrumbbar -->
@endsection


@section('rightbar-content')
<!-- Start Contentbar -->
<div class="contentbar">
    <!-- Start row -->
    <div class="row">
        <!-- Start col -->
        <div class="col-lg-12">
            <div class="card m-b-30">
                <!-- Invoice details -->
                <div class="card-header">
                    <h5 class="card-title">Invoice Details</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="font-weight-bold">Invoice Date</label>
                                <p class="form-control-static font-weight-normal">
                                    {{ $order->invoice_date ? \Carbon\Carbon::parse($order->invoice_date)->format('d-m-Y') : '' }}
                                </p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="font-weight-bold">Invoice No</label>
                                <p class="form-control-static font-weight-normal">{{ $order->invoice_no }}</p>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end invoice details  -->
                <!-- product details -->
                <div class="card-header">
                    <h5 class="card-title">Product Details</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                    @php
                        $productDes = $orderProduct->product_id == $orderProduct->products->id ? $orderProduct->products->name : '';
                        $productVariantName = $orderProduct->product_variant_id == $orderProduct->productVariants->id ? $orderProduct->productVariants->name : '';
                        @endphp
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="font-weight-bold">Product Description</label>
                                <p class="form-control-static font-weight-normal">{{ $productDes }}</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="font-weight-bold">Pack Size</label>
                                <p class="form-control-static font-weight-normal">{{ $productVariantName }}</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="font-weight-bold">Pack Quantity</label>
                                <p class="form-control-static font-weight-normal">{{ $orderProduct->quantity }}</p>
                            </div>
                        </div>
                    </div>
                </div>
<!-- end product details  -->
                <div class="card-header">
                    <h5 class="card-title">Edit Order Billing</h5>
                </div>
                <div class="card-body">
                <form method="post" action="{{ route('billing.update', $orderProduct->id) }}" >
                    @method('PATCH')
                    @csrf
                    <input type="hidden" name="redirect" value="{{ urlencode($redirectUrl) }}">
                    <input type="hidden" name="invoice_no" value="{{ $order->invoice_no }}">
                    <table class="table table-borderless" id="dynamicTable">
                        @foreach($orderProductStocks->orderProductStocks as $index => $orderProductStock)
                        <tr class="d-flex flex-wrap" id="gallery-{{$orderProductStock->id}}" style="border: 1px solid #ddd; padding: 5px 5px 5px 5px; margin-bottom: 10px;">
                            <input type="hidden" name="productStock[{{$index}}][id]" value="{{$orderProductStock->id}}"/>
                            <td>
                                <div class="form-group orderProductStock">
                                    <label for="exampleInputEmail1">Stock Received & Verified</label><br>
                                    <input type="radio"  disabled value="yes" {{ isset($orderProductStock) && $orderProductStock->is_stock_received == 'yes' ? 'checked' : '' }} >
                                    <label class="radio-inline">Yes</label>
                                    <input type="radio"  disabled value="no" {{ isset($orderProductStock) && $orderProductStock->is_stock_received == 'no' ? 'checked' : '' }}>
                                    <label class="radio-inline">No</label>
                                </div>
                            </td>
                            <td>
                            <div class="form-group orderProductStock">
                                <label for="exampleInputEmail1">Batch No</label>
                                <input type="text"  disabled value="{{ $orderProductStock->batch_no ?? '' }}" class="form-control" aria-describedby="Name" placeholder="Enter Batch No">
                            </div>
                        </td>
                        <td>
                            <div class="form-group orderProductStock">
                                <label for="exampleInputEmail1">MFG Date</label>
                                <input type="month"  disabled value="{{ $orderProductStock->mfg_date ?? '' }}" class="form-control" aria-describedby="Name" placeholder="Enter MFG Date">
                            </div>
                        </td>
                        <td>
                            <div class="form-group orderProductStock">
                                <label for="exampleInputEmail1">Expiry</label>
                                <input type="month"  disabled value="{{ $orderProductStock->exp_date ?? '' }}" class="form-control" aria-describedby="Name" placeholder="Enter Expiry">
                            </div>
                        </td>
                        <td>
                            <div class="form-group orderProductStock">
                                <label for="exampleInputEmail1">Quantity</label>
                                <input type="text" disabled value="{{ $orderProductStock->quantity ?? '' }}" class="form-control" aria-describedby="Name" placeholder="Enter Quantity">
                            </div>
                        </td>
                        <td>
                            <div class="form-group orderProductStock">
                                <label for="exampleInputEmail1">Purchase Entry (Done/Pending)</label><br>
                                <input type="radio" name="productStock[{{$index}}][is_purchase_entry_done]"  value="yes" {{ isset($orderProductStock) && $orderProductStock->is_purchase_entry_done == 'yes' ? 'checked' : '' }} >
                                <label class="radio-inline">Yes</label>
                                <input type="radio" name="productStock[{{$index}}][is_purchase_entry_done]" value="pending" {{ isset($orderProductStock) && $orderProductStock->is_purchase_entry_done == 'pending' ? 'checked' : '' }}>
                                <label class="radio-inline">Pending</label>
                            </div>
                          </td>
                        </tr>
                        @endforeach
                    </table>
                    <div class="mt-3">
                        <button type="submit" class="btn btn-primary-rgba mr-3">Save</button>
                        <a href="{{ urldecode($redirectUrl) }}" class="btn btn-danger-rgba">Cancel</a>                    </div>
                  </form>
                </div>
            </div>
        </div>
        <!-- End col -->
    </div> <!-- End row -->
</div>
<!-- End Contentbar -->
@endsection
@section('script')
<!-- Custom Switchery js -->
<script src="{{ asset('assets/js/custom/custom-switchery.js') }}"></script>
<!-- Select2 js -->
<script src="{{ asset('assets/plugins/select2/select2.min.js') }}"></script>
<!-- Tagsinput js -->
<script src="{{ asset('assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput.min.js') }}"></script>
<script src="{{ asset('assets/plugins/bootstrap-tagsinput/typeahead.bundle.js') }}"></script>
<script src="{{ asset('assets/js/custom/custom-form-select.js') }}"></script>
<!-- Parsley js -->
<script src="{{ asset('assets/plugins/validatejs/validate.min.js') }}"></script>
<!-- Validate js -->
<script src="{{ asset('assets/js/custom/custom-validate.js') }}"></script>
<script src="{{ asset('assets/js/custom/custom-form-validation.js') }}"></script>
@endsection
