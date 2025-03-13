@extends('layouts.main')
@section('title')
Edit Purchase Department
@endsection

@section('style')
<link href="{{ asset('assets/plugins/select2/select2.min.css') }}" rel="stylesheet" type="text/css" />
<link href="{{ asset('assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput.css') }}" rel="stylesheet" type="text/css" />
<link href="{{ asset('assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput-typeahead.css') }}" rel="stylesheet" type="text/css" />
@endsection

@section('breadcrumbbar')
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
                <a href="{{ $redirectUrl }}" class="btn btn-primary-rgba"><i class="ti-arrow-left mr-2"></i>Back</a>
            </div>
        </div>
    </div>
</div>
@endsection

@section('errormessege')
    <div class="contentbar p-0 m-0" style="padding-right :30px !important;">
        <!-- Start row -->
        <div class="row justify-content-end">
            <div class="col-lg-4">
            <div id="updateMessage" class="alert alert-success" style="display: none;">
                    Products purchase updated successfully!
                </div>
            </div>
        </div>
    </div>
@endsection

@section('rightbar-content')
<div class="contentbar">
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title">Edit Purchase Department</h5>
                </div>
                <div class="card-body">
                <form id="purchaseForm" method="post" action="{{ route('orderPurchase.update', $order->id) }}">
                    @method('PATCH')
                    @csrf
                    <input type="hidden" name="redirect" value="{{ $redirectUrl }}">
                    <input type="hidden" name="invoice_no" value="{{ $order->invoice_no }}">
                    <input type="hidden" name="created_by" value="{{ $order->created_by }}">
                    <table class="table table-borderless" id="dynamicTable">
                        @foreach($orderProducts->orderProducts as $index => $orderProduct)
                        <tr class="d-flex flex-wrap" id="gallery-{{$orderProduct->id}}" style="border: 1px solid #ddd; padding: 5px 5px 5px 5px; margin-bottom: 10px;">
                            <input type="hidden" name="product[{{$index}}][id]" value="{{$orderProduct->id}}"/>
                            <td class="col-md-2">
                                <div class="form-group orderProduct">
                                    <label>Product Description</label>
                                    @php
                                    $productDes = $orderProduct->product_id == $orderProduct->products->id ? $orderProduct->products->name : '';
                                    @endphp
                                    <input type="text" value="{{ $productDes }}" class="form-control" placeholder="Enter Product Description" disabled>
                                </div>
                            </td>
                            <td class="col-md-2 ml-3">
                                <div class="form-group orderProduct">
                                    <label>Pack Size</label>
                                    @php
                                        $productVariantName = $orderProduct->product_variant_id == $orderProduct->productVariants->id ? $orderProduct->productVariants->name : '';
                                    @endphp
                                    <input type="text" value="{{ $productVariantName }}" class="form-control" placeholder="Enter Pack Size" disabled>
                                </div> 
                            </td>
                            <td class="col-md-2 ml-3">
                                <div class="form-group orderProduct">
                                    <label>Pack Quantity</label>
                                    <input type="text" value="{{ $orderProduct->quantity }}" class="form-control" placeholder="Enter Pack Quantity" disabled>
                                </div>
                            </td>
                            <td class="col-md-2 ml-3">
                            <div class="form-group orderProduct">
                                <label>Order Placed</label><br>
                                <label class="radio-inline">
                                    <input type="radio" name="product[{{$index}}][is_order_placed]" value="yes" {{ isset($orderProduct) && $orderProduct->is_order_placed == 'yes' ? 'checked' : '' }}> Yes
                                </label>
                                <label class="radio-inline ml-4">
                                    <input type="radio" name="product[{{$index}}][is_order_placed]" value="no" {{ isset($orderProduct) && $orderProduct->is_order_placed == 'no' ? 'checked' : '' }}> No
                                </label>
                                <label class="radio-inline ml-4">
                                    <input type="radio" name="product[{{$index}}][is_order_placed]" value="error" {{ isset($orderProduct) && $orderProduct->is_order_placed == 'error' ? 'checked' : '' }}> Error
                                </label>
                            </div>
                        </td>
                        <td class="col-md-2" id="notesField_{{$index}}" style="{{ isset($orderProduct) && $orderProduct->is_order_placed != 'yes' ? '' : 'display:none;' }}">
                            <div class="form-group orderProduct">
                                <label>Notes<span class="text-danger">*</span></label>
                                <input type="text" 
                                    name="product[{{$index}}][note]" 
                                    value="{{ $orderProduct->note ?? '' }}" 
                                    class="form-control" 
                                    placeholder="Enter Notes">
                                    <div class="text-danger" id="notes-msg"></div>
                            </div> 
                        </td>
                        <td class="col-md-2" id="expectedDeliveryField_{{$index}}" style="{{ isset($orderProduct) && $orderProduct->is_order_placed == 'yes' ? '' : 'display:none;' }}">
                            <div class="form-group orderProduct">
                                <label>Expected Delivery Date<span class="text-danger">*</span></label>
                                <input type="date" 
                                    name="product[{{$index}}][expected_delivery_date]" 
                                    value="{{ $orderProduct->expected_delivery_date ?? '' }}" 
                                    class="form-control">
                                <div class="text-danger" id="expected-delivery-date-msg"></div>
                            </div>
                        </td>
                        </tr>
                        @endforeach
                    </table>
    
                    <div class="mt-3">
                        <button type="submit" class="btn btn-primary-rgba mr-3">Save</button>
                        <a href="{{ $redirectUrl }}" class="btn btn-danger-rgba">Cancel</a>
                    </div>
                </form>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection

@section('script')
<script src="{{ asset('assets/js/custom/custom-switchery.js') }}"></script>
<script src="{{ asset('assets/plugins/select2/select2.min.js') }}"></script>
<script src="{{ asset('assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput.min.js') }}"></script>
<script src="{{ asset('assets/plugins/bootstrap-tagsinput/typeahead.bundle.js') }}"></script>
<script src="{{ asset('assets/js/custom/custom-form-select.js') }}"></script>
<script src="{{ asset('assets/plugins/validatejs/validate.min.js') }}"></script>
<script src="{{ asset('assets/js/custom/custom-validate.js') }}"></script>

<script>
$(document).ready(function() {
    function handleOrderPlaced(status, index) {
        var notesField = $('#notesField_' + index);
        var expectedDeliveryField = $('#expectedDeliveryField_' + index);

        if (status === 'yes') {
            expectedDeliveryField.show();
            notesField.hide();
        } else {
            expectedDeliveryField.hide();
            notesField.show();
        }
    }

    function validateForm() {
        var isValid = true;
        var today = new Date();
        var currentYear = today.getFullYear();
        var currentMonth = today.getMonth() + 1; // Months are zero-based in JavaScript

        // Function to pad month with leading zero if necessary
        function padMonth(month) {
            return month < 10 ? '0' + month : month;
        }

        // Format current year-month as 'YYYY-MM'
        var currentYearMonth = currentYear + '-' + padMonth(currentMonth);

        $('input[type="radio"]:checked').each(function() {
            var nameAttr = $(this).attr('name');
            var indexMatch = nameAttr.match(/\d+/);
            if (!indexMatch) {
                // Skip if no index is found in the name attribute
                return true; // Equivalent to 'continue' in jQuery each
            }
            var index = indexMatch[0];
            var isOrderPlacedYes = $(this).val();
            var expectedDeliveryDateField = $('input[name="product[' + index + '][expected_delivery_date]"]');
            var noteField = $('input[name="product[' + index + '][note]"]');
            var row = $(this).closest('tr');

            // Remove existing error messages and reset styles
            row.find('.error-message').remove();
            expectedDeliveryDateField.css('border', '');
            noteField.css('border', '');

            if (isOrderPlacedYes === 'yes') {
                // Validate expected_delivery_date
                var expectedDateStr = expectedDeliveryDateField.val();
                if (!expectedDateStr) {
                    expectedDeliveryDateField.css('border', '1px solid red');
                    isValid = false;
                    expectedDeliveryDateField.after('<span class="text-danger error-message">Expected delivery date is required.</span>');
                } else {
                    // Validate format using regex (YYYY-MM-DD)
                    var dateRegex = /^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$/;
                    if (!dateRegex.test(expectedDateStr)) {
                        expectedDeliveryDateField.css('border', '1px solid red');
                        isValid = false;
                        expectedDeliveryDateField.after('<span class="text-danger error-message">Invalid date format. Use DD-MM-YYYY.</span>');
                    } else {
                        // Compare with current year-month
                        if (expectedDateStr < currentYearMonth) {
                            expectedDeliveryDateField.css('border', '1px solid red');
                            isValid = false;
                            expectedDeliveryDateField.after('<span class="text-danger error-message">The expected delivery date cannot be in the past.</span>');
                        }
                    }
                }
            } else {
                // Validate note field
                var noteVal = noteField.val().trim();
                if (!noteVal) {
                    noteField.css('border', '1px solid red');
                    isValid = false;
                    noteField.after('<span class="text-danger error-message">Note is required.</span>');
                }
            }
        });

        return isValid;
    }

    $('#purchaseForm').on('submit', function(e) {
        e.preventDefault();
        if (validateForm()) {
            $.ajax({
                url: $(this).attr('action'),
                method: 'PATCH',
                data: $(this).serialize(),
                success: function(response) {
                    if (response.success) {
                         // Use the redirect URL from the response
                         var redirectUrl = response.redirect;
                        // Check if the URL already contains a query parameter
                        if (redirectUrl.includes('?')) {
                            redirectUrl += '&success=' + encodeURIComponent(response.success);
                        } else {
                            redirectUrl += '?success=' + encodeURIComponent(response.success);
                        }
                        // Redirect to the final URL
                        window.location.href = redirectUrl;
                    }
                },
                error: function(xhr) {
                    console.log(xhr.responseText);
                }
            });
        }
    });

    $('input[type="radio"]').on('change', function() {
        var index = $(this).attr('name').match(/\d+/)[0];
        var status = $(this).val();
        handleOrderPlaced(status, index);
    });

    $('input[type="radio"]:checked').each(function() {
        var index = $(this).attr('name').match(/\d+/)[0];
        var status = $(this).val();
        handleOrderPlaced(status, index);
    });
});
</script>
@endsection
