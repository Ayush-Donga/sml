@section('title')
Edit Logistic Department
@endsection
@extends('layouts.main')
@section('style')
<style>
    .radio-inline {
    display: inline-block;
    margin-right: 5px; /* Adjust margin as needed */
}
</style>
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
            <div class="card">
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
                <div class="card-header">
                    <h5 class="card-title">Edit Logistic Department</h5>
                </div>
                <div class="card-body">
                <form method="post" action="{{ route('orders.update', $order->id) }}" >
                    @method('PATCH')
                    @csrf
                    <input type="hidden" name="redirect" value="{{ urlencode($redirectUrl) }}">
                    <div class="row">
                    <table class="table table-borderless" id="dynamicTable">
                        <tr class="d-flex flex-wrap" id="gallery-{{$order->id}}" style="border: 1px solid #ddd; padding: 5px 5px 5px 5px; margin-bottom: 10px;">
                            <td>
                            <div class="form-group col-md-12">
                                <label for="exampleInputEmail1">Shiping Documents (Done/Pending)</label><br>
                                <input type="radio"  name="is_shipping_documents_done" value="yes" {{ isset($order) && $order->is_shipping_documents_done == 'yes' ? 'checked' : '' }}> 
                                <label class="radio-inline">Yes</label>
                                <input type="radio" name="is_shipping_documents_done" value="no" {{ isset($order) && $order->is_shipping_documents_done == 'no' ? 'checked' : '' }}>
                                <label class="radio-inline">No</label>
                            </div>
                            </td>
                            <td>
                            <div class="form-group col-md-12">
                                <label for="exampleInputEmail1">Tax Invoice & Eway Bill (Done/Pending)</label><br>
                                <input type="radio" name="is_tax_invoice_eway_billP_done" value="yes" {{ isset($order) && $order->is_tax_invoice_eway_billP_done == 'yes' ? 'checked' : '' }}> 
                                <label class="radio-inline">Yes</label>
                                <input type="radio" name="is_tax_invoice_eway_billP_done" value="no" {{ isset($order) && $order->is_tax_invoice_eway_billP_done == 'no' ? 'checked' : '' }}>
                                <label class="radio-inline">No</label>
                            </div>
                            </td>
                            <td>
                            <div class="form-group col-md-12">
                                <label for="exampleInputEmail1">Arrange Pick Up (Done/Pending)</label><br>
                                <input type="radio" name="is_arrange_pick_up" value="yes" {{ isset($order) && $order->is_arrange_pick_up == 'yes' ? 'checked' : '' }}>
                                <label class="radio-inline">Yes</label>
                                <input type="radio" name="is_arrange_pick_up" value="no" {{ isset($order) && $order->is_arrange_pick_up == 'no' ? 'checked' : '' }}>
                                <label class="radio-inline">No</label>
                            </div>
                            </td>
                            <td>
                            <div class="form-group col-md-12">
                                <label for="exampleInputEmail1">Shipment Dispached</label><br>
                                <input type="radio" name="is_shipment_dispatched" value="yes" {{ isset($order) && $order->is_shipment_dispatched == 'yes' ? 'checked' : '' }}>
                                <label class="radio-inline">Yes</label>
                                <input type="radio" name="is_shipment_dispatched" value="no" {{ isset($order) && $order->is_shipment_dispatched == 'no' ? 'checked' : '' }}>
                                <label class="radio-inline">No</label>
                            </div>
                            </td>
                            <td>
                            <div class="form-group col-md-12">
                                <label for="exampleInputEmail1">AWB Handover</label><br>
                                <input type="radio" name="is_awb_handover" value="yes" {{ isset($order) && $order->is_awb_handover == 'yes' ? 'checked' : '' }}> 
                                <label class="radio-inline">Yes</label>
                                <input type="radio" name="is_awb_handover" value="no" {{ isset($order) && $order->is_awb_handover == 'no' ? 'checked' : '' }}>
                                <label class="radio-inline">No</label>
                            </div>
                            </td>
                            <td>
                            <div class="form-group col-md-12">
                                <label for="exampleInputEmail1">Shipment Close</label><br>
                                <input type="radio" name="is_shipment_close" value="yes" {{ isset($order) && $order->is_shipment_close == 'yes' ? 'checked' : '' }}>
                                <label class="radio-inline">Yes</label>
                                <input type="radio" name="is_shipment_close" value="no" {{ isset($order) && $order->is_shipment_close == 'no' ? 'checked' : '' }}> 
                                <label class="radio-inline">No</label>
                            </div>
                            </td>
                        </tr>
                    </table>
                    </div>
                    <div class="mt-3">
                        <button type="submit" class="btn btn-primary-rgba mr-3">Save</button>
                        <a href="{{ urldecode($redirectUrl) }}" class="btn btn-danger-rgba btn-cancel">
                            Cancel
                        </a>
                    </div>
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
