@section('title')
Edit Proforma Product
@endsection
@extends('layouts.main')
@section('style')
<!-- Select2 css -->
<link href="{{ asset('assets/plugins/select2/select2.min.css') }}" rel="stylesheet" type="text/css" />
<!-- Tagsinput css -->
<link href="{{ asset('assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput.css') }}" rel="stylesheet" type="text/css" />
<link href="{{ asset('assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput-typeahead.css') }}" rel="stylesheet" type="text/css" />
<style>
    #addMore,
    #remove-product,
    .remove-tr {
        margin-top: 6px;
        height: calc(1.75rem + 0px);
        padding: 0.375rem 0.65rem !important;
    }
    .box-border {
            border: 1px solid #ccc;
            padding: 10px; /* Add padding for better spacing */
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
                    <li class="breadcrumb-item"><a href="{{url('/proformas')}}">Proforma</a></li>
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
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="card-title">Edit Proforma Product</h5>
                        <button type="button" name="add" id="addMore" class="btn btn-success-rgba">
                            <i class="fa fa-plus"></i> Proforma Product
                        </button>
                    </div>
                </div>
                <div class="card-body">
                <form id="productForm"  method="post" action="{{ route('proformaProducts.update', $proforma->id) }}" >
                @method('PATCH')
                @csrf
                <input type="hidden" name="redirect" value="{{ urlencode($redirectUrl) }}">
                <table class="table table-borderless" id="dynamicTable">
                        @foreach($proformaProducts->proformaProducts as $index => $proformaProduct)
                            <tr class="d-flex flex-wrap" id="gallery-{{ $proformaProduct->id }}" style="border: 1px solid #ddd; padding: 5px 5px 5px 5px; margin-bottom: 10px;">
                                <input type="hidden" name="product[{{ $index }}][id]" value="{{ $proformaProduct->id }}"/>
                                <td class="col-md-2">
                                    <div class="form-group proformaProduct">
                                        <label for="exampleInputEmail1">Product Description</label>
                                        <select class="form-control select2 productDropdown" name="product[{{ $index }}][product_id]" id="productDropdown-{{ $index }}" onchange="updateVariantDropdownInsideLoop({{ $index }}, this.value)" placeholder="Please Select Product Description">
                                            <option value="">Select</option>
                                            @foreach($products as $product)
                                                @if($product->status != 0 || $product->id  == $proformaProduct->product_id)
                                                    <option value="{{ $product->id }}" @if($proformaProduct->product_id == $product->id) selected @endif>{{ $product->name }}</option>
                                                @endif
                                            @endforeach
                                        </select>
                                    </div>
                                </td>
                                <td class="col-md-2">
                                    <div class="form-group proformaProduct">
                                        <label for="exampleInputEmail1">Pack Size<span class="text-danger">*</span></label>
                                        <select class="form-control select2" name="product[{{ $index }}][product_variant_id]" id="variantDropdown-{{ $index }}" placeholder="Please Select Pack Size">
                                            <option value="">Select Variant</option>
                                            @foreach($productVariants as $variant)
                                            @if($proformaProduct->product_id == $variant->product_id)
                                                <option value="{{ $variant->id }}" @if($proformaProduct->product_variant_id == $variant->id) selected @endif>{{ $variant->name }}</option>
                                            @endif
                                            @endforeach
                                        </select>
                                        <div class="text-danger" id="error-product_{{ $index }}_product_variant_id"></div>
                                    </div>
                                </td>
                                <td class="col-md-2">
                                    <div class="form-group orderProduct">
                                        <label for="quantity">Pack Quantity<span class="text-danger">*</span></label>
                                        <input type="text" id="quantity_{{ $index }}" 
                                            name="product[{{ $index }}][quantity]" 
                                            value="{{ old('product.' . $index . '.quantity', $proformaProduct->quantity) }}" 
                                            class="form-control" 
                                            placeholder="Enter Pack Quantity" 
                                            oninput="calculateTotal({{ $index }});">
                                        <div class="text-danger" id="error-product_{{ $index }}_quantity"></div>
                                    </div>
                                </td>
                                <td class="col-md-2">
                                    <div class="form-group orderProduct">
                                        <label for="price_per_set">Price Per Set<span class="text-danger">*</span></label>
                                        <input type="text" id="price_per_set_{{ $index }}" 
                                            name="product[{{ $index }}][price_per_set]" 
                                            value="{{ old('product.' . $index . '.price_per_set', $proformaProduct->price_per_set) }}" 
                                            class="form-control" 
                                            placeholder="Enter Price Per Set" 
                                            oninput="calculateTotal({{ $index }});">
                                        <div class="text-danger" id="error-product_{{ $index }}_price_per_set"></div>
                                    </div>
                                </td>
                                <td class="col-md-2">
                                    <div class="form-group proformaProduct">
                                        <label for="exampleInputEmail1">Total<span class="text-danger">*</span></label>
                                        <input type="text" id="total_{{ $index }}" name="product[{{ $index }}][total]" value="{{ format_currency($proformaProduct->total) }}" class="form-control numeric-field" aria-describedby="Name" placeholder="Enter Total" readonly>
                                        <div class="text-danger" id="error-product_{{ $index }}_total"></div>
                                    </div>
                                </td>
                                <td class="col-md-1 ml-2 d-flex align-items-center">
                                    <button type="button" data-product-id="{{ $proformaProduct->id }}" class="btn btn-danger-rgba deleteProduct" id="remove-product"><i class="feather icon-trash"></i></button>
                                </td>
                            </tr>
                        @endforeach
                    </table>
                    <div class="box-border">
                        <div class="row">
                            <div class="col">
                                <label for="exampleInputEmail1">Shipping</label>
                                <input type="text" name="shipping" id="shipping" value="{{ old('shipping', $proforma->shipping) }}" class="form-control" placeholder="Please Enter Shipping">
                                <div class="text-danger" id="error-shipping"></div>
                            </div>
                            <div class="col">
                                <label for="exampleInputEmail1">Soft Boxes</label>
                                <input type="text" name="soft_boxes" id="soft_boxes" value="{{ old('soft_boxes', $proforma->soft_boxes) }}" class="form-control" placeholder="Please Enter Soft Boxes">
                                <div class="text-danger" id="error-soft_boxes"></div>
                            </div>
                            <div class="col">
                                <label for="exampleInputEmail1">Data Logger</label>
                                <input type="text" name="data_logger" id="data_logger" value="{{ old('data_logger', $proforma->data_logger) }}" class="form-control" placeholder="Please Enter Data Logger">
                                <div class="text-danger" id="error-data_logger"></div>
                            </div>
                            <div class="col">
                                <label for="exampleInputEmail1">Clearance</label>
                                <input type="text" name="clearance" id="clearance" value="{{ old('clearance', $proforma->clearance) }}" class="form-control" placeholder="Please Enter Clearance">
                                <div class="text-danger" id="error-clearance"></div>
                            </div>
                        </div>
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

<div class="modal fade" id="deleteProductModal" tabindex="-1" aria-labelledby="deleteProductModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Product delete confirmation</h5>
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
<script>
$(document).ready(function() {
    $('.deleteProduct').click(function() {
        var productId = $(this).data('product-id');
       
        $('#deleteProductModal').modal('show');
        
        // Moved the click event listener for confirmation button outside the main click event
        $('.confirm-delete').off('click').on('click', function() {
            // Perform AJAX request to delete the product
            $.ajax({
                url: '/proformaProducts/' + productId,
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
                    alert('Error deleting product.'); // Display error message
                }
            });
            $('#deleteProductModal').modal('hide');
        });
    });
});
</script>
<script>
   $(document).ready(function(){
    var i = 0;

    function initializeSelect2() {
        $('.select2').select2({
            placeholder: function () {
                return $(this).data('placeholder');
            },
            allowClear: true, // Enables clear button
        });
    }

    // Call Select2 initializer on page load
    initializeSelect2();

    $('#addMore').click(function(){
            ++i;
            var newRow =
            '<tr class="d-flex flex-wrap" style="border: 1px solid #ddd; padding: 5px 5px 5px 5px; margin-bottom: 10px;" id="row-addmore-' + i + '">' +
                '<td class="col-md-2">' +
                '<div class="form-group">' +
                    '<label>Product Description</label>' +
                    '<select class="form-control select2 product-dropdown" ' +
                            'name="first[' + i + '][product_id]" ' +
                            'id="productDropdown_' + i + '">' +
                        '<option value="">Select</option>' +
                    '</select>' +
                '</div>' +
                '</td>' +

                '<td class="col-md-2">' +
                '<div class="form-group">' +
                    '<label>Pack Size <span class="text-danger">*</span></label>' +
                    '<select class="form-control select2 variant-dropdown" ' +
                            'name="first[' + i + '][product_variant_id]" ' +
                            'id="variantDropdown_' + i + '">' +
                        '<option value="">Select</option>' +
                    '</select>' +
                    '<div class="text-danger" id="error-first_' + i + '_product_variant_id"></div>' +
                '</div>' +
                '</td>' +

                '<td class="col-md-2">' +
                '<div class="form-group">' +
                    '<label>Pack Quantity <span class="text-danger">*</span></label>' +
                    '<input type="text" name="first[' + i + '][quantity]" ' +
                            'id="quantityAddmore_' + i + '" ' +
                            'class="form-control" placeholder="Enter Pack Quantity">' +
                    '<div class="text-danger" id="error-first_' + i + '_quantity"></div>' +
                '</div>' +
                '</td>' +

                '<td class="col-md-2">' +
                '<div class="form-group">' +
                    '<label>Price Per Set <span class="text-danger">*</span></label>' +
                    '<input type="text" name="first[' + i + '][price_per_set]" ' +
                            'id="pricePerSetAddmore_' + i + '" ' +
                            'class="form-control" placeholder="Enter Price Per Set">' +
                    '<div class="text-danger" id="error-first_' + i + '_price_per_set"></div>' +
                '</div>' +
                '</td>' +

                '<td class="col-md-2">' +
                '<div class="form-group">' +
                    '<label>Total <span class="text-danger">*</span></label>' +
                    '<input type="text" name="first[' + i + '][total]" ' +
                            'id="totalAddmore_' + i + '" ' +
                            'class="form-control" placeholder="Enter Price Per Set" readonly>' +
                    '<div class="text-danger" id="error-first_' + i + '_total"></div>' +
                '</div>' +
                '</td>' +

                '<td class="col-md-1 ml-2 d-flex align-items-center">' +
                '<button type="button" class="btn btn-danger-rgba remove-tr remove-row">' +
                    '<i class="fa fa-minus" aria-hidden="true"></i>' +
                '</button>' +
                '</td>' +
            '</tr>';

            $('#dynamicTable').append(newRow);

            // Now re-populate dropdowns, attach listeners, etc.
            populateProductDropdown(i);
            addEventListeners(i);
            initializeSelect2();
        });


        function addEventListeners(index) {
        $('#quantityAddmore_' + index + ', #pricePerSetAddmore_' + index).on('input', function() {
            // Use the correct ID "quantityAddmore_"
            var quantity = parseFloat($('#quantityAddmore_' + index).val()) || 0;
            var pricePerSet = parseFloat($('#pricePerSetAddmore_' + index).val()) || 0;
            var total = quantity * pricePerSet;
            $('#totalAddmore_' + index).val(total.toFixed(2));
        });
    }

    // Event handler for product dropdown (delegated)
    $(document).on('change', '.product-dropdown', function(){
        // Extract the index from the ID of the product dropdown
        var index = $(this).attr('id').split('_')[1];
        // Call updateVariantDropdown function
        updateVariantDropdown(index);
    });

    var productsData = @Json($productResponse);

    // Function to populate product dropdown
    function populateProductDropdown(index) {
        var dropdown = document.getElementById("productDropdown_" + index);
        productsData.products.forEach(function(product) {
            if (product.status === 1) {
                var option = document.createElement("option");
                option.text = product.name;
                option.value = product.id;
                dropdown.add(option);
            }
        });
    }

    // Function to update variant dropdown based on selected product
    function updateVariantDropdown(index) {
        var productDropdown = document.getElementById("productDropdown_" + index);
        var variantDropdown = document.getElementById("variantDropdown_" + index);
        var productId = productDropdown.value;

        // Clear previous options
        variantDropdown.innerHTML = '<option value="">Select Variant</option>';

        // Find selected product
        var selectedProduct = productsData.products.find(function(product) {
            return product.id == productId;
        });

        // Populate variants for selected product
        if (selectedProduct) {
            selectedProduct.variants.forEach(function(variant) {
                if (variant.status === 1 && variant.product_id == productId) {
                    var option = document.createElement("option");
                    option.text = variant.name;
                    option.value = variant.id;
                    variantDropdown.add(option);
                }
            });
        }
    }

    // Submit form event (delegated)
    $(document).on('submit', '#productForm', function(e) {
        e.preventDefault();
        $('.remove-row').css('margin-top', '-6px');
         // Preprocess numeric fields before submitting
            $('#productForm .numeric-field').each(function() {
                let value = $(this).val();
                // Remove commas and sanitize input
                value = value.replace(/,/g, ''); // Remove commas
                value = value.replace(/[^\d.]/g, ''); // Remove non-numeric characters except dot
                $(this).val(value); // Update the field value
            });

            var formData = $(this).serialize();
            $.ajax({
                url: $(this).attr('action'),
                method: 'PATCH',
                data: formData,
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
                    // Handle error response
                    if (xhr.status === 422) {
                        $(':submit').prop('disabled', false);
                        let errors = xhr.responseJSON.errors; 

                        // Clear ALL existing errors (both product.* AND first.*)
                        $('.text-danger[id^="error-product_"]').text(''); 
                        $('.text-danger[id^="error-first_"]').text('');

                        // Now handle new errors
                        for (let key in errors) {
                            if (errors.hasOwnProperty(key)) {
                                let message = errors[key][0]; 
                                // e.g. key = "product.0.quantity" or "first.1.quantity"
                                let fieldId = key.replace(/\./g, '_'); 
                                let errorDivId = 'error-' + fieldId;
                                $('#' + errorDivId).text(message);
                            }
                        }
                    }
                }
            });

            $(':submit').prop('disabled', true); 
    })

    // Remove row event (delegated)
    $(document).on('click', '.remove-tr', function() {
        $(this).closest('tr').remove();
    });
});
</script>
<script>
    var productsData = @json($productResponse); // Make sure to use proper Laravel blade syntax

    // Function to update variant dropdown based on selected product inside a loop
    function updateVariantDropdownInsideLoop(index, selectedProductId) {
        var variantDropdown = document.getElementById("variantDropdown-" + index);

        // Clear previous options
        variantDropdown.innerHTML = '<option value="">Select Variant</option>';

        // Find the selected product
        var selectedProduct = productsData.products.find(function(product) {
            return product.id == selectedProductId;
        });

        // Populate variants for the selected product
        if (selectedProduct && selectedProduct.variants) {
            selectedProduct.variants.forEach(function(variant) {
                if (variant.status === 1 && variant.product_id == selectedProductId) {
                    var option = document.createElement("option");
                    option.text = variant.name;
                    option.value = variant.id;
                    variantDropdown.add(option);
                }
            });
        }
    }
</script>
<script>
    function calculateTotal(index) {
        var quantity = parseFloat(document.getElementById('quantity_' + index).value) || 0;
        var pricePerSet = parseFloat(document.getElementById('price_per_set_' + index).value) || 0;
        var total = quantity * pricePerSet;
        document.getElementById('total_' + index).value = total.toFixed(2); // Ensures total is formatted to 2 decimal places
    }
</script>
@endsection
