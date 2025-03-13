@section('title')
Edit Order Product Stock
@endsection
@extends('layouts.main')
@section('style')
<!-- Select2 css -->
<link href="{{ asset('assets/plugins/select2/select2.min.css') }}" rel="stylesheet" type="text/css" />
<!-- Tagsinput css -->
<link href="{{ asset('assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput.css') }}" rel="stylesheet" type="text/css" />
<link href="{{ asset('assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput-typeahead.css') }}" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<style>
    #remove-stock,
    .remove-tr  {
        margin-top: 6px;
        height: calc(1.75rem + 0px);
        padding: 0.375rem 0.65rem !important;
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
                    <li class="breadcrumb-item"><a href="{{url('/')}}">Home</a></li>
                    <li class="breadcrumb-item"><a href="{{url('/orders')}}">Orders</a></li>
                    <li class="breadcrumb-item active" aria-current="page">@yield('title')</li>
                </ol>
            </div>
        </div>
        <div class="col-md-4 col-lg-4">
            <div class="widgetbar">
                <a href="{{ urldecode($redirectUrl) }}" class="btn btn-primary-rgba btn-back">
                    <i class="ti-arrow-left mr-2"></i>Back</a>
                </a>
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
            <div id="updateMessage" class="alert alert-success" style="display: none;">
                     product stocks updated successfully!
                </div>
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
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="card-title mb-0">Edit Order Product Stock</h5>
                        <button type="button" name="add" id="addMore" class="btn btn-success-rgba">
                            <i class="fa fa-plus"></i> Add Product Stock
                        </button>
                    </div>
                </div>
                
                <div class="card-body">
                <form id="productStockForm" method="post" action="{{ route('orderProductStock.update', $orderProduct->id) }}">
                @method('PATCH')
                @csrf
                <input type="hidden" name="redirect" value="{{ old('redirect', urlencode($redirectUrl)) }}">
                <input type="hidden" name="created_by" value="{{ $order->created_by }}">
                <input type="hidden" name="invoice_no" value="{{ $order->invoice_no }}">
                    <table class="table table-borderless" id="dynamicTable">
                        @foreach($orderProductStocks->orderProductStocks as $index => $orderProductStock)
                        <tr class="d-flex flex-wrap" id="gallery-{{$orderProductStock->id}}" style="border: 1px solid #ddd; padding: 5px 5px 5px 5px; margin-bottom: 10px;">
                            <input type="hidden" name="productStock[{{$index}}][id]" value="{{$orderProductStock->id}}"/>
                            <td class="col-md-2">
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Stock Received & Verified</label><br>
                                    <label class="radio-inline">
                                        <input type="radio" name="productStock[{{$index}}][is_stock_received]" value="yes" {{ isset($orderProductStock) && $orderProductStock->is_stock_received == 'yes' ? 'checked' : '' }} class="is_stock_received" data-index="{{$index}}"> Yes
                                    </label>
                                    <label class="radio-inline ml-4">
                                        <input type="radio" name="productStock[{{$index}}][is_stock_received]" value="no" {{ isset($orderProductStock) && $orderProductStock->is_stock_received == 'no' ? 'checked' : '' }} class="is_stock_received" data-index="{{$index}}"> No
                                    </label>
                                </div>
                            </td>
                            <td class="col-md-2 ml-2">
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Batch No<span class="text-danger">*</span></label>
                                    <input type="text" name="productStock[{{$index}}][batch_no]" value="{{ $orderProductStock->batch_no ?? '' }}" class="form-control batch_no" aria-describedby="Name" placeholder="Enter Batch No">
                                    <div class="text-danger"></div>
                                </div>
                            </td>
                            <!-- MFG Date -->
                            <td class="col-md-2 ml-2">
                                <div class="form-group">
                                    <label for="exampleInputEmail1">MFG Date<span class="text-danger">*</span></label>
                                    <input type="month" name="productStock[{{$index}}][mfg_date]" value="{{ $orderProductStock->mfg_date ?? '' }}" class="form-control mfg_date" aria-describedby="Name" placeholder="Enter MFG Date">
                                    <div class="text-danger"></div>
                                </div>
                            </td>
                            <!-- Expiry Date -->
                            <td class="col-md-2 ml-2">
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Expiry<span class="text-danger">*</span></label>
                                    <input type="month" name="productStock[{{$index}}][exp_date]" value="{{ $orderProductStock->exp_date ?? '' }}" class="form-control exp_date" aria-describedby="Name" placeholder="Enter Expiry">
                                    <div class="text-danger"></div>
                                </div>
                            </td>
                            <!-- Quantity -->
                            <td class="col-md-2 ml-2">
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Quantity<span class="text-danger">*</span></label>
                                    <input type="text" name="productStock[{{$index}}][quantity]" value="{{ $orderProductStock->quantity ?? '' }}" class="form-control quantity" aria-describedby="Name" placeholder="Enter Quantity">
                                    <div class="text-danger"></div>
                                </div>
                            </td>
                            <td class="col-md-1 ml-2 d-flex align-items-center">
                                <button type="button" data-product-stock-id="{{ $orderProductStock->id }}" class="btn btn-danger-rgba deleteProduct" id="remove-stock"><i class="feather icon-trash"></i></button>
                            </td>
                        </tr>
                        @endforeach
                    </table>
                <div class="mt-3">
                    <button type="submit" class="btn btn-primary-rgba mr-3">Save</button>
                    <a href="{{ urldecode($redirectUrl) }}" class="btn btn-danger-rgba btn-cancel">
                        Cancel
                    </a>
                </div>
                </form>
            </div>
        </div>
        <!-- End col -->
    </div> <!-- End row -->
</div>

<div class="modal fade" id="deleteProductModal" tabindex="-1" aria-labelledby="deleteProductModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Product stock delete confirmation</h5>
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
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script>
$(document).ready(function() {
    $('.deleteProduct').click(function() {
        var productStockId = $(this).data('product-stock-id');
       
        $('#deleteProductModal').modal('show');
        
        // Moved the click event listener for confirmation button outside the main click event
        $('.confirm-delete').off('click').on('click', function() {
            // Perform AJAX request to delete the product
            $.ajax({
                url: '/orderProductStock/' + productStockId,
                type: 'DELETE',
                data: {
                    _token: '{{ csrf_token() }}' // Include CSRF token
                },
                success: function(result) {
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
                    setTimeout(function() {
                        window.location.reload();
                    }, 2500);
                },
                error: function(xhr, status, error) {
                    // Handle errors
                    console.error(xhr.responseText);
                    alert('Error deleting product stock.'); // Display error message
                }
            });
            $('#deleteProductModal').modal('hide');
        });
    });
});
</script>
<script>
$(document).ready(function() {
    // Function to toggle input fields based on stock received status
    function stockReceivedVerified(status, index) {
        var batchNoField = $('input[name="productStock[' + index + '][batch_no]"]');
        var mfgDateField = $('input[name="productStock[' + index + '][mfg_date]"]');
        var expDateField = $('input[name="productStock[' + index + '][exp_date]"]');
        var quantityField = $('input[name="productStock[' + index + '][quantity]"]');

        if (status === 'yes') {
            batchNoField.prop('disabled', false);
            mfgDateField.prop('disabled', false);
            expDateField.prop('disabled', false);
            quantityField.prop('disabled', false);
        } else {
            batchNoField.prop('disabled', true).removeAttr('required').val('');
            mfgDateField.prop('disabled', true).removeAttr('required').val('');
            expDateField.prop('disabled', true).removeAttr('required').val('');
            quantityField.prop('disabled', true).removeAttr('required').val('');

            batchNoField.next('.text-danger').text('');
            mfgDateField.next('.text-danger').text('');
            expDateField.next('.text-danger').text('');
            quantityField.next('.text-danger').text('');

            batchNoField.css('border', '');
            mfgDateField.css('border', '');
            expDateField.css('border', '');
            quantityField.css('border', '');
        }
    }

    // Function to validate the form
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
            var index = $(this).attr('name').match(/\d+/)[0];
            var status = $(this).val();
            var batchNoField = $('input[name="productStock[' + index + '][batch_no]"]');
            var mfgDateField = $('input[name="productStock[' + index + '][mfg_date]"]');
            var expDateField = $('input[name="productStock[' + index + '][exp_date]"]');
            var quantityField = $('input[name="productStock[' + index + '][quantity]"]');
            var alphanumericDashSpaceRegex = /^[a-zA-Z0-9\s-]*$/;

            if (status === 'yes') {
                // Validate Batch No
                if (!batchNoField.val()) {
                    batchNoField.css('border', '1px solid red');
                    batchNoField.next('.text-danger').text("The Batch No field is required.");
                    isValid = false; 
                } else if (!alphanumericDashSpaceRegex.test(batchNoField.val())) {
                    batchNoField.css('border', '1px solid red');
                    batchNoField.next('.text-danger').text("Only alphanumeric characters are allowed.");
                    isValid = false; 
                } else if (batchNoField.val().length > 255) {
                    batchNoField.css('border', '1px solid red');
                    batchNoField.next('.text-danger').text("Batch number cannot exceed 255 characters.");
                    isValid = false; 
                } else {
                    batchNoField.css('border', '');
                    batchNoField.next('.text-danger').text('');
                }
                
                // Validate MFG Date
                if (!mfgDateField.val()) {
                    mfgDateField.next('.text-danger').text("The MFG Date field is required.");
                    isValid = false;
                } else {
                    var dateRegex = /^\d{4}-(0[1-9]|1[0-2])$/;
                    if (!dateRegex.test(mfgDateField.val())) {
                        mfgDateField.css('border', '1px solid red');
                        mfgDateField.next('.text-danger').text('Invalid date format. Use MM-YYYY.');
                        isValid = false;
                    } else {
                        mfgDateField.css('border', '');
                        mfgDateField.next('.text-danger').text('');
                    }
                }

                // Validate Expiry Date
                if (!expDateField.val()) {
                    expDateField.next('.text-danger').text("The Expiry field is required.");
                    isValid = false;
                } else {
                    var dateRegex = /^\d{4}-(0[1-9]|1[0-2])$/;
                    if (!dateRegex.test(expDateField.val())) {
                        expDateField.css('border', '1px solid red');
                        expDateField.next('.text-danger').text('Invalid date format. Use MM-YYYY.');
                        isValid = false;
                    } else {
                        expDateField.css('border', '');
                        expDateField.next('.text-danger').text('');
                    }
                }

                // Validate Quantity
                if (!quantityField.val()) {
                    quantityField.css('border', '1px solid red');
                    quantityField.next('.text-danger').text("The Quantity field is required.");
                    isValid = false;
                } else if (!/^\d+$/.test(quantityField.val())) {
                    quantityField.css('border', '1px solid red');
                    quantityField.next('.text-danger').text("Only numeric characters are allowed.");
                    isValid = false;
                } else if (parseInt(quantityField.val()) > 99999999.99) {
                    quantityField.css('border', '1px solid red');
                    quantityField.next('.text-danger').text("Quantity cannot exceed 8 digits.");
                    isValid = false;
                } else {
                    quantityField.css('border', '');
                    quantityField.next('.text-danger').text('');
                }
            }
        });

        return isValid;
    }

    // Form submission handler
    $('#productStockForm').on('submit', function(e) {
        e.preventDefault(); // Prevent the default form submission
        $('.remove-row').css('margin-top', '-6px');
        if (validateForm()) { // Remove editValidateForm if consolidated
            $.ajax({
                url: $(this).attr('action'),
                method: 'PATCH',
                data: $(this).serialize(),
                success: function(response) {
                    if (response.success) {
                        // Redirect using the URL from the response
                        var redirectUrl = response.redirect;
                        // Append success message as a query parameter
                        if (redirectUrl.includes('?')) {
                            redirectUrl += '&success=' + encodeURIComponent(response.success);
                        } else {
                            redirectUrl += '?success=' + encodeURIComponent(response.success);
                        }
                        window.location.href = redirectUrl;
                    }
                },
                error: function(xhr) {
                    console.log(xhr.responseText);
                    // Optionally, display a generic error message to the user
                    alert('An error occurred while updating the product stocks. Please try again.');
                }
            });

            // Disable the submit button to prevent multiple submissions
            $(':submit').prop('disabled', true);
        }
    });

    // Radio button change handler
    $(document).on('change', 'input[type="radio"]', function() {
        var index = $(this).attr('name').match(/\d+/)[0];
        var status = $(this).val();
        stockReceivedVerified(status, index);
    });

    // Add more rows handler
    var i = $('input[type="radio"]').length; // Adjust index based on existing rows
    $('#addMore').click(function() {
        ++i;
        var newRow = `
            <tr class="d-flex flex-wrap" style="border: 1px solid #ddd; padding: 5px 5px 5px 5px; margin-bottom: 10px;">
                <input type="hidden" name="create" id="create" value="">
                <td class="col-md-2">
                    <div class="form-group">
                        <label for="exampleInputEmail1">Stock Received & Verified</label><br>
                        <label class="radio-inline">
                            <input type="radio" name="productStock[${i}][is_stock_received]" value="yes"> Yes
                        </label>
                        <label class="radio-inline ml-4">
                            <input type="radio" name="productStock[${i}][is_stock_received]" value="no"> No
                        </label>
                    </div>
                </td>
                <td class="col-md-2 ml-2">
                    <div class="form-group">
                        <label for="exampleInputEmail1">Batch No<span class="text-danger">*</span></label>
                        <input type="text" name="productStock[${i}][batch_no]" value="" class="form-control batch_no" aria-describedby="Name" placeholder="Enter Batch No">
                        <div class="text-danger"></div>
                    </div>
                </td>
                <td class="col-md-2 ml-2">
                    <div class="form-group">
                        <label for="exampleInputEmail1">MFG Date<span class="text-danger">*</span></label>
                        <input type="month" name="productStock[${i}][mfg_date]" value="" class="form-control mfg_date" aria-describedby="Name" placeholder="Enter MFG Date">
                        <div class="text-danger"></div>
                    </div>
                </td>
                <td class="col-md-2 ml-2">
                    <div class="form-group">
                        <label for="exampleInputEmail1">Expiry<span class="text-danger">*</span></label>
                        <input type="month" name="productStock[${i}][exp_date]" value="" class="form-control exp_date" aria-describedby="Name" placeholder="Enter Expiry">
                        <div class="text-danger"></div>
                    </div>
                </td>
                <td class="col-md-2 ml-2">
                    <div class="form-group">
                        <label for="exampleInputEmail1">Quantity<span class="text-danger">*</span></label>
                        <input type="text" name="productStock[${i}][quantity]" value="" class="form-control quantity" aria-describedby="Name" placeholder="Enter Quantity">
                        <div class="text-danger"></div>
                    </div>
                </td>
                <td class="col-md-1 ml-2 d-flex align-items-center">
                    <button type="button" class="btn btn-danger remove-tr remove-row"><i class="fa fa-minus" aria-hidden="true"></i></button>
                </td>
            </tr>`;
        $('#dynamicTable').append(newRow);
    });

    // Remove row handler
    $(document).on('click', '.remove-tr', function() {
        $(this).parents('tr').remove();
    });

    // Initial stock received verified check
    $('input[type="radio"]:checked').each(function() {
        var index = $(this).attr('name').match(/\d+/)[0];
        var status = $(this).val();
        stockReceivedVerified(status, index);
    });
});
</script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const rows = document.querySelectorAll('tr[id^="gallery-"]');

        rows.forEach(function (row) {
            const yesRadio = row.querySelector('input[value="yes"].is_stock_received');
            const noRadio = row.querySelector('input[value="no"].is_stock_received');
            const inputsToToggle = row.querySelectorAll('.batch_no, .mfg_date, .exp_date, .quantity');

            function toggleInputs() {
                const isStockReceived = yesRadio.checked;
                inputsToToggle.forEach(function (input) {
                    if (!isStockReceived) {
                        input.value = '';  // Clear the value if stock is not received
                    }
                    input.disabled = !isStockReceived;
                });
            }

            // Attach event listeners to radio buttons
            yesRadio.addEventListener('change', toggleInputs);
            noRadio.addEventListener('change', toggleInputs);

            // Set initial state based on default checked radio button
            toggleInputs();
        });

        // Ensure all inputs are enabled before form submission
        const form = document.getElementById('productStockForm');
        form.addEventListener('submit', function () {
            const allInputs = form.querySelectorAll('.batch_no, .mfg_date, .exp_date, .quantity');
            allInputs.forEach(function (input) {
                input.disabled = false;
            });
        });
    });
</script>
@endsection
