@section('title')
Edit Order Product Package
@endsection
@extends('layouts.main')
@section('style')
<style>
    .box-border {
        border: 1px solid #ccc;
        padding: 15px; /* Increased padding for better spacing */
        margin-bottom: 15px; /* Added margin for better separation */
        
        border-radius: 5px; /* Rounded corners for a cleaner look */
    }

    .form-group {
        margin-bottom: 10px; /* Ensuring space between input fields */
    }

    /* Fix button spacing */
    #addMore,
    #addMoreProduct,
    #remove-package,
    #addMoreProductEdit {
        margin-top: 6px;
        height: calc(1.75rem + 0px);
        padding: 0.375rem 0.65rem !important;
    }

    .remove-tr,
    .addMoreProduct {
        margin-top: 6px;
        height: calc(1.75rem + 0px);
        padding: 0.375rem 0.65rem !important;
    }

    /* Ensure all form fields have proper spacing */
    .form-row {
        margin-bottom: 5px;
    }
    .d-flex.align-items-center {
    gap: 10px; /* Ensures space between buttons */
}

.btn {
    min-width: 40px;
    padding: 6px 12px;
    text-align: center;
}

/* Ensures buttons inside col-md-2 are correctly spaced */
.col-md-2.d-flex {
    justify-content: start;
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
                    Products purchase updated successfully!
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
                <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead class="text-center">
                                    <tr>
                                        <th class="font-weight-bold logistic">Product Description</th>
                                        <th class="font-weight-bold logistic">Pack Size</th>
                                        <th class="font-weight-bold logistic">Pack Quantity</th>
                                    </tr>
                                </thead>
                                <tbody class="text-center z">
                                    @foreach($order->orderProducts as $orderProduct)
                                        @php
                                            $productDes = $orderProduct->products->name ?? '';
                                            $productVariantName = $orderProduct->productVariants->name ?? '';
                                        @endphp
                                        <tr>
                                            <td class="font-weight-normal">{{ $productDes }}</td>
                                            <td class="font-weight-normal">{{ $productVariantName }}</td>
                                            <td class="font-weight-normal">{{ $orderProduct->quantity }}</td>
                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                      </div>
                </div>
<!-- end product details  -->
                <div class="card-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="card-title mb-0">Edit Order Product Package</h5>
                        <button type="button" name="add" id="addMoreBox" class="btn btn-success-rgba">
                            <i class="fa fa-plus"></i> Product Package
                        </button>
                    </div>
                </div>

                <div class="card-body">
                <form id="packageForm" method="post" action="{{ route('orderPackage.update', $order->id) }}" >
                    @method('PATCH')
                    @csrf 
                    <input type="hidden" name="redirect" value="{{ urlencode($redirectUrl) }}">
                    <input type="hidden" name="created_by" value="{{ $order->created_by }}">
                    <input type="hidden" name="invoice_no" value="{{ $order->invoice_no }}">
                        <div id="boxSection">
                            
                        </div>
                    <br>
                    @php
                        $numOfPackage = $order->orderPackages->count();
                    @endphp
                     @if (isset($numOfPackage) && $numOfPackage > 0)
                     @foreach($order->orderPackages as $packageIndex => $orderPackage)
                        <div class="box-border packageSection" data-package-index="{{ $packageIndex }}">
                            
                            {{-- Hidden fields for the existing package --}}
                            <input type="hidden" name="package[{{ $packageIndex }}][id]" value="{{ $orderPackage->id }}">
                            <input type="hidden" name="package[{{ $packageIndex }}][order_id]" value="{{ $orderPackage->order_id }}">
                            
                            <div class="form-row">
                                <!-- Example: Box Number, Dimension, Weights, etc. -->
                                <div class="form-group col-md-2">
                                    <label>Box Number<span style="color: red;">*</span></label>
                                    <input type="text" class="form-control"
                                        name="package[{{ $packageIndex }}][box_no]"
                                        value="{{ $orderPackage->box_no }}" placeholder="Enter Box Number">
                                        <div class="text-danger" id="error-package_{{ $packageIndex }}_box_no"></div>
                                </div>
                                <div class="form-group col-md-2">
                                    <label>Box Dimension</label>
                                    <input type="text" class="form-control"
                                        name="package[{{ $packageIndex }}][dimension]"
                                        value="{{ $orderPackage->dimension }}" placeholder="Enter Box Dimension">
                                    <div class="text-danger" id="error-package_{{ $packageIndex }}_dimension"></div>
                                </div>
                                <div class="form-group col-md-2">
                                    <label>Gross Weight(Kgs)</label>
                                    <input type="text" class="form-control"
                                        name="package[{{ $packageIndex }}][gross_weight]"
                                        value="{{ remove_trailing_zeros($orderPackage->gross_weight) }}" placeholder="Enter Gross Weight">
                                    <div class="text-danger" id="error-package_{{ $packageIndex }}_gross_weight"></div>
                                </div>
                                <div class="form-group col-md-2">
                                    <label>Net Weight(Kgs)</label>
                                    <input type="text" class="form-control"
                                        name="package[{{ $packageIndex }}][net_weight]"
                                        value="{{ remove_trailing_zeros($orderPackage->net_weight) }}" placeholder="Enter Net Weight">
                                    <div class="text-danger" id="error-package_{{ $packageIndex }}_net_weight"></div>
                                </div>
                                <div class="col-md-2 ml-2 d-flex align-items-center">
                                    <!-- Delete existing entire package button -->
                                    <button type="button" class="btn btn-danger-rgba deletePackage"
                                        id="addMoreProduct"
                                        data-package-id="{{ $orderPackage->id }}">
                                        <i class="feather icon-trash"></i>
                                    </button>

                                    @if($orderPackage->orderPackageProducts->count() === 0)
                                        <button type="button" class="btn btn-success-rgba" id="addMoreProductEdit"
                                                data-package-index="{{ $packageIndex }}"
                                                data-package-id="{{ $orderPackage->id }}">
                                            <i class="fa fa-plus" aria-hidden="true"></i>
                                        </button>
                                    @endif
                                </div>
                            </div>
                            
                            <!-- A container for product rows of this package -->
                            <div class="productSectionEdit" id="productSectionEdit_{{ $packageIndex }}">
                                @foreach($orderPackage->orderPackageProducts as $productIndex => $orderPackageProduct)
                                    <div class="form-row productRow" data-product-index="{{ $productIndex }}">
                                        
                                        <!-- Hidden fields for existing package products -->
                                        <input type="hidden"
                                            name="package[{{ $packageIndex }}][{{ $productIndex }}][packageProducts][id]"
                                            value="{{ $orderPackageProduct->id }}">
                                        <input type="hidden"
                                            name="package[{{ $packageIndex }}][{{ $productIndex }}][packageProducts][order_package_id]"
                                            value="{{ $orderPackageProduct->order_package_id }}">
                                        
                                        <!-- Product Name -->
                                        <div class="form-group col-md-4">
                                            <label>Product Name<span style="color: red;">*</span></label>
                                            <select class="form-control select2" name="package[{{ $packageIndex }}][{{ $productIndex }}][packageProducts][order_product_id]" required>
                                                <option value="">Select</option>
                                                @foreach($order->orderProducts as $orderProduct)
                                                    <option value="{{ $orderProduct->id }}" 
                                                        @if($orderPackageProduct->order_product_id == $orderProduct->id) selected @endif>
                                                        {{ $orderProduct->products->name }} / {{ $orderProduct->productVariants->name }}
                                                    </option>
                                                @endforeach
                                            </select>
                                            <div class="text-danger" id="error-package_{{ $packageIndex }}_{{ $productIndex}}_packageProducts_order_product_id"></div>
                                        </div>

                                        <!-- Quantity -->
                                        <div class="form-group col-md-4">
                                            <label>Quantity Per Box</label>
                                            <input type="text" class="form-control"
                                                name="package[{{ $packageIndex }}][{{ $productIndex }}][packageProducts][quantity]"
                                                value="{{ $orderPackageProduct->quantity }}" placeholder="Quantity Per Box">
                                                <div class="text-danger" id="error-package_{{ $packageIndex }}_{{ $productIndex}}_packageProducts_quantity"></div>
                                        </div>

                                        <!-- Action Buttons -->
                                        <div class="col-md-2 ml-2 d-flex align-items-center">
                                        {{-- Delete this product button --}}
                                        <button type="button" class="btn btn-danger-rgba removePackageProduct mr-2" id="remove-package" 
                                                data-package-product-id="{{ $orderPackageProduct->id }}">
                                            <i class="feather icon-trash"></i>
                                        </button>

                                        {{-- Only show "Add More Product" on the last row inside this loop --}}
                                        @if($loop->last)
                                            <button type="button" class="btn btn-success-rgba" id="addMoreProductEdit"
                                                    data-package-index="{{ $packageIndex }}"
                                                    data-package-id="{{ $orderPackage->id }}">
                                                <i class="fa fa-plus" aria-hidden="true"></i>
                                            </button>
                                        @endif
                                    </div>

                                    </div>
                                @endforeach
                            </div><!-- end .productSectionEdit -->
                        
                        </div><!-- end .box-border -->
                    @endforeach

                    @endif
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
<!-- pakage delete model -->
<div class="modal fade" id="deletePackageModal" tabindex="-1" aria-labelledby="deletePackageModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Package delete confirmation</h5>
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
<!-- end package delete model -->
<!-- pakage product delete model -->
<div class="modal fade" id="deletePackageProductModal" tabindex="-1" aria-labelledby="deletePackageProductModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Package product delete confirmation</h5>
            </div>
            <div class="modal-body">
                Are you sure you want to delete?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-primary" data-dismiss="modal">No</button>
                <button type="button" class="btn btn-outline-danger  confirm-delete-package-product">yes</button>
            </div>
        </div>
    </div>
</div>
<!-- end package product delete model -->
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
    $('.deletePackage').click(function() {
        var packageId = $(this).data('package-id');
       
        $('#deletePackageModal').modal('show');
        
        // Moved the click event listener for confirmation button outside the main click event
        $('.confirm-delete').off('click').on('click', function() {
            // Perform AJAX request to delete the product
            $.ajax({
                url: '/orderPackage/' + packageId,
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
                    alert('Error deleting package.'); // Display error message
                }
            });
            $('#deletePackageModal').modal('hide');
        });
    });
});
</script>
<script>
$(document).ready(function() {
    $('.removePackageProduct').click(function() {
        var packageProductId = $(this).data('package-product-id');
       
        $('#deletePackageProductModal').modal('show');
        
        // Moved the click event listener for confirmation button outside the main click event
        $('.confirm-delete-package-product').off('click').on('click', function() {
            // Perform AJAX request to delete the product
            $.ajax({
                url: '/orderPackageProduct/' + packageProductId, // Corrected URL
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
                    alert('Error deleting package product.'); // Display error message
                }
            });
            $('#deletePackageProductModal').modal('hide');
        });
    });
});
</script>
<script>
    // Keep track of how many boxes are created
    let boxIndex = 0;

    /**
     * Initialize or re-initialize Select2 for dynamic elements
     */
    function initializeSelect2() {
        $('.select2').select2({
            placeholder: "Select",
            allowClear: true
        });
    }

    /**
     * 1) When clicking "Add More Box"
     */
    $('#addMoreBox').on('click', function() {
        // Increment the box index
        boxIndex++;

        // Each new box starts its product index at 0
        let productIndex = 0;

        // Build the new box's HTML. Notice how we attach data attributes:
        //  - data-box-index for reference
        //  - data-product-index for the initial product count in this box
        let newBoxHtml = `
            <div class="box-border single-box" data-box-index="${boxIndex}" data-product-index="0">
                <div class="form-row">
                    <div class="form-group col-md-2">
                        <label>Box Number <span style="color: red;">*</span></label>
                        <input type="text" name="first[${boxIndex}][box_no]" class="form-control" placeholder="Enter Box Number">
                        <div class="text-danger" id="error-first_${boxIndex}_box_no"></div>
                    </div>
                    <div class="form-group col-md-2">
                        <label>Box Dimension</label>
                        <input type="text" name="first[${boxIndex}][dimension]" class="form-control" placeholder="Enter Box Dimension">
                        <div class="text-danger" id="error-first_${boxIndex}_dimension"></div>
                    </div>
                    <div class="form-group col-md-2">
                        <label>Gross Weight(Kgs)</label>
                        <input type="text" name="first[${boxIndex}][gross_weight]" class="form-control" placeholder="Enter Gross Weight(Kgs)">
                        <div class="text-danger" id="error-first_${boxIndex}_gross_weight"></div>
                    </div>
                    <div class="form-group col-md-2">
                        <label>Net Weight(Kgs)</label>
                        <input type="text" name="first[${boxIndex}][net_weight]" class="form-control" placeholder="Enter Net Weight(Kgs)">
                        <div class="text-danger" id="error-first_${boxIndex}_net_weight"></div>
                    </div>
                    <div class="col-md-1 ml-2 d-flex align-items-center">
                        <!-- Remove entire box button -->
                        <button type="button" class="btn btn-danger-rgba remove-box remove-button" id="remove-package" data-box-index="${boxIndex}">
                            <i class="fa fa-minus" aria-hidden="true"></i>
                        </button>
                    </div>
                </div>

                <!-- Product section for this box -->
                <div class="productSection">
                    <!-- First product row inside this new box (start with productIndex = 0) -->
                    <div class="form-row productRow">
                        <!-- Name your fields carefully. For the first product: productIndex = 0 -->
                        <div class="form-group col-md-4">
                            <label>Product Name <span style="color: red;">*</span></label>
                            <select class="form-control select2" name="first[${boxIndex}][${productIndex}][firstProduct][order_product_id]">
                                <option value="">Select</option>
                                @foreach($order->orderProducts as $orderProduct)
                                    <option value="{{ $orderProduct->id }}">
                                        {{ $orderProduct->products->name }} / {{ $orderProduct->productVariants->name }}
                                    </option>
                                @endforeach
                            </select>
                            <div class="text-danger"></div>
                        </div>
                        <div class="form-group col-md-4">
                            <label>Quantity Per Box</label>
                            <input type="text" class="form-control" 
                                   name="first[${boxIndex}][${productIndex}][firstProduct][quantity]"
                                   placeholder="Enter Quantity Per Box">
                            <div class="text-danger"></div>
                        </div>
                        <div class="col-md-1 ml-2 d-flex align-items-center">
                            <!-- Add more products inside the same box -->
                            <button type="button" class="btn btn-success-rgba addMoreProduct remove-button">
                                <i class="fa fa-plus" aria-hidden="true"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        `;

        // Append this new box to the boxSection
        $('#boxSection').append(newBoxHtml);

        // Re-initialize Select2 for newly added elements
        initializeSelect2();
    });

    /**
     * 2) When clicking "Add More Product" inside a single box
     */
    $(document).on('click', '.addMoreProduct', function() {
        // Find the parent .single-box container
        let $boxContainer = $(this).closest('.single-box');

        // Read the current productIndex from its data attribute
        let currentProductIndex = parseInt($boxContainer.attr('data-product-index'));

        // Increment it by 1
        currentProductIndex++;

        // Also get the boxIndex from data attribute
        let currentBoxIndex = $boxContainer.data('box-index');

        // Build a new product row
        let newProductRow = `
            <div class="form-row productRow">
                <!-- Hidden or visible fields go here. Notice how we now use currentProductIndex -->
                <div class="form-group col-md-4">
                    <label>Product Name <span style="color: red;">*</span></label>
                    <select class="form-control select2" name="first[${currentBoxIndex}][${currentProductIndex}][firstProduct][order_product_id]">
                        <option value="">Select</option>
                        @foreach($order->orderProducts as $orderProduct)
                            <option value="{{ $orderProduct->id }}">
                                {{ $orderProduct->products->name }} / {{ $orderProduct->productVariants->name }}
                            </option>
                        @endforeach
                    </select>
                    <div class="text-danger"></div>
                </div>
                <div class="form-group col-md-4">
                    <label>Quantity Per Box</label>
                    <input type="text" class="form-control"
                           name="first[${currentBoxIndex}][${currentProductIndex}][firstProduct][quantity]"
                           placeholder="Enter Quantity Per Box">
                    <div class="text-danger"></div>
                </div>
                <div class="col-md-1 ml-2 d-flex align-items-center">
                    <!-- Remove product row -->
                    <button type="button" class="btn btn-danger-rgba remove-tr remove-button">
                        <i class="fa fa-minus" aria-hidden="true"></i>
                    </button>
                </div>
            </div>
        `;

        // Append the new product row to the .productSection inside the same box
        $boxContainer.find('.productSection').append(newProductRow);

        // Update the data-product-index on the box container
        $boxContainer.attr('data-product-index', currentProductIndex);

        // Re-initialize select2 for newly appended elements
        initializeSelect2();
    });

    /**
     * 3) Remove product row
     */
    $(document).on('click', '.remove-tr', function() {
        $(this).closest('.productRow').remove();
    });

    /**
     * 4) Remove entire box
     */
    $(document).on('click', '.remove-box', function() {
        $(this).closest('.single-box').remove();
    });

    // Initialize Select2 on page load if needed
    $(document).ready(function() {
        initializeSelect2();
    });
</script>
<script>
$(document).ready(function() {
    // Initialize select2
    function initializeSelect2() {
        $('.select2').select2({
            placeholder: "Select",
            allowClear: true
        });
    }

    initializeSelect2(); // Initialize on page load

    // Handle Add More Product click for existing order
    $(document).on('click', '#addMoreProductEdit', function() {
        let packageIndex = $(this).data('package-index');
        let orderPackageId = $(this).data('package-id'); // Get the package ID

        let newProductIndex = $('#productSectionEdit_' + packageIndex).find('.productRow').length; // Calculate new product index

        let newProductRow = `
            <div class="form-row productRow" data-product-index="${newProductIndex}">
                <input type="hidden" name="package[${packageIndex}][${newProductIndex}][packageProducts][order_package_id]" value="${orderPackageId}">
                <div class="form-group col-md-4">
                    <label>Product Name<span style="color: red;">*</span></label>
                    <select class="form-control select2" name="package[${packageIndex}][${newProductIndex}][packageProducts][order_product_id]">
                        <option value="">Select</option>
                        @foreach($order->orderProducts as $orderProduct)
                            <option value="{{ $orderProduct->id }}">
                                {{ $orderProduct->products->name }} / {{ $orderProduct->productVariants->name }}
                            </option>
                        @endforeach
                    </select>
                    <div class="text-danger"></div>
                </div>
                <div class="form-group col-md-4">
                    <label>Quantity Per Box</label>
                    <input type="text" class="form-control" name="package[${packageIndex}][${newProductIndex}][packageProducts][quantity]" placeholder="Enter Quantity">
                    <div class="text-danger" id="error-package_${packageIndex}_${newProductIndex}_packageProducts_quantity"></div>
                </div>
                <div class="col-md-1 ml-2 d-flex align-items-center">
                    <button type="button" class="btn btn-danger-rgba remove-tr remove-button"><i class="fa fa-minus" aria-hidden="true"></i></button>
                </div>
            </div>`;

        // Append the new product row
        $('#productSectionEdit_' + packageIndex).append(newProductRow);

        // Reinitialize select2 for the new product row
        initializeSelect2();
    });

    // Handle Remove Product Row
    $(document).on('click', '.remove-tr', function() {
        $(this).closest('.productRow').remove();
    });
});
</script>
<script>

$(document).ready(function() {
    function validateForm() {
        var isValid = true;

        $('.box-border').each(function() {
            var boxNoField = $(this).find('input[name^="first["][name$="][box_no]"]');
            var productNameFields = $(this).find('select[name^="first["][name$="][firstProduct][order_product_id]"]');
            var existingPackageAddMoreProduct = $(this).find('select[name^="package["][name*="][packageProducts][order_product_id]"]');

            boxNoField.each(function() {
                var boxNoField = $(this);
                var errorMessage = boxNoField.closest('.form-group').find('.text-danger');

                if (boxNoField.val().trim() === "") {
                    isValid = false;
                    errorMessage.text("The box number field is required.");
                } else {
                    errorMessage.text('');
                }
            });

            // Validate products added to newly created boxes
            productNameFields.each(function() {
                var productNameField = $(this);
                var errorMessage = productNameField.closest('.form-group').find('.text-danger');

                if (productNameField.val().trim() === "") {
                    isValid = false;
                    errorMessage.text("Please select a product name.");
                } else {
                    errorMessage.text('');
                }
            });

            // Validate products added inside existing packages
            existingPackageAddMoreProduct.each(function() {
                var productField = $(this);
                var errorMessage = productField.closest('.form-group').find('.text-danger');

                if (productField.val().trim() === "") {
                    isValid = false;
                    errorMessage.text("Please select a product name.");
                } else {
                    errorMessage.text('');
                }
            });
        });

        return isValid;
    }

    // Form submission
    $('#packageForm').on('submit', function(e) {
        e.preventDefault();
        $('.remove-button').css('margin-top', '-6px');
        if (validateForm()) {
            var formData = $(this).serialize();
            $.ajax({
                url: $(this).attr('action'),
                method: 'PATCH',
                data: formData,
                success: function(response) {
                    if (response.success) {
                        var redirectUrl = response.redirect;
                        if (redirectUrl.includes('?')) {
                            redirectUrl += '&success=' + encodeURIComponent(response.success);
                        } else {
                            redirectUrl += '?success=' + encodeURIComponent(response.success);
                        }
                        window.location.href = redirectUrl;
                    }
                },
                error: function(xhr) {
                    if (xhr.status === 422) {
                        $(':submit').prop('disabled', false);
                        let errors = xhr.responseJSON.errors;
                        $('.text-danger').text(''); // Clear all previous errors

                        for (let key in errors) {
                            if (errors.hasOwnProperty(key)) {
                                let message = errors[key][0];
                                let fieldId = key.replace(/\./g, '_');
                                let errorDivId = 'error-' + fieldId;
                                $('#' + errorDivId).text(message);
                            }
                        }
                    }
                }
            });

            $(':submit').prop('disabled', true);
        }
    });

    // Ensure validation runs for dynamically added fields
    $(document).on('change', 'select[name^="package["][name*="][packageProducts][order_product_id]"]', function() {
        var productField = $(this);
        var errorMessage = productField.closest('.form-group').find('.text-danger');

        if (productField.val().trim() === "") {
            errorMessage.text("Please select a product name.");
        } else {
            errorMessage.text('');
        }
    });
});

</script>
@endsection('/script')

