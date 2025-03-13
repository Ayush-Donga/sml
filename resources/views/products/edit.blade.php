@section('title')
Edit Product
@endsection
@extends('layouts.main')
@section('style')
<!-- Select2 css -->
<link href="{{ asset('assets/plugins/select2/select2.min.css') }}" rel="stylesheet" type="text/css" />
<!-- Tagsinput css -->
<link href="{{ asset('assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput.css') }}" rel="stylesheet"
    type="text/css" />
<link href="{{ asset('assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput-typeahead.css') }}" rel="stylesheet"
    type="text/css" />
<style>
    .box-border {
        border: 1px solid #ccc;
        padding: 10px;
        /* Add padding for better spacing */
    }

    #addMore,
    #addMoreProduct,
    #remove-product {
        margin-top: 28px;
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
                    <li class="breadcrumb-item"><a href="{{url('/products')}}">Products</a></li>
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
                    <h5 class="card-title">Edit Product</h5>
                </div>
                <div class="card-body">
                    <form method="POST"
                        action="{{ route('products.update', $product->id) }}">
                        @method('PATCH')
                        @csrf
                        <input type="hidden" name="redirect" value="{{ urlencode($redirectUrl) }}">
                        <div class="box-border">
                            <div id="productSection">
                                <div class="form-row">
                                    <div class="form-group col-md-2">
                                        <label for="exampleInputEmail1">Product Name</label>
                                        <input type="text" name="name" value="{{ old('name', $product->name) }}" class="form-control"
                                            aria-describedby="Name" placeholder="Enter Product Name">
                                        @error('name')
                                            <div class="text-danger">{{ $message }}</div>
                                        @enderror
                                    </div>
                                    <div class="form-group col-md-2">
                                        <label for="heading">Heading</label>
                                        <select class="form-control select2" name="heading" placeholder="Please Select heading">
                                            <option value="">Select</option>
                                            <option value="HARMLESS PHARMACEUTICAL MEDICINES FOR HUMAN USE" {{ (old('heading') == 'HARMLESS PHARMACEUTICAL MEDICINES FOR HUMAN USE' || (isset($product) && $product->heading == 'HARMLESS PHARMACEUTICAL MEDICINES FOR HUMAN USE')) ? 'selected' : '' }}>HARMLESS PHARMACEUTICAL
                                                MEDICINES FOR HUMAN USE</option>
                                            <option value="HARMLESS PHARMACEUTICAL MEDICINES FOR ANIMAL USE" {{ (old('heading') == 'HARMLESS PHARMACEUTICAL MEDICINES FOR ANIMAL USE' || (isset($product) && $product->heading == 'HARMLESS PHARMACEUTICAL MEDICINES FOR ANIMAL USE')) ? 'selected' : '' }}>HARMLESS PHARMACEUTICAL
                                                MEDICINES FOR ANIMAL USE</option>
                                        </select>
                                        @error('heading')
                                            <div class="text-danger">{{ $message }}</div>
                                        @enderror
                                    </div>
                                    <div class="form-group col-md-2">
                                        <label for="genericName">Generic Name</label>
                                        <input type="text" name="generic_name" value="{{ old('generic_name', $product->generic_name) }}"
                                            class="form-control" id="genericName" aria-describedby="Name"
                                            placeholder="Enter Generic Name">
                                        @error('generic_name')
                                            <div class="text-danger">{{ $message }}</div>
                                        @enderror
                                    </div>
                                    <div class="form-group col-md-2">
                                        <label for="manufacturedBy">Manufactured by</label>
                                        <input type="text" name="manufactured_by" value="{{ old('manufactured_by', $product->manufactured_by) }}"
                                            class="form-control" id="manufacturedBy" aria-describedby="Name"
                                            placeholder="Enter Manufactured By">
                                        @error('manufactured_by')   
                                            <div class="text-danger">{{ $message }}</div>
                                        @enderror
                                    </div>
                                    <div class="form-group col-md-2">
                                        <label for="hsnCode">HSN Code</label>
                                        <input type="text" name="hsn_code" value="{{ old('hsn_code', $product->hsn_code) }}"
                                            class="form-control" id="hsnCode" aria-describedby="Name"
                                            placeholder="Enter HSN Code">
                                        @error('hsn_code')
                                            <div class="text-danger">{{ $message }}</div>
                                        @enderror
                                    </div>
                                </div>
                                @foreach($product->ProductVariants as $index => $variant)
                                    <input type="hidden" name="variant[{{$index}}][id]" value="{{$variant->id}}" />
                                    <input type="hidden" name="variant[{{$index}}][product_id]"
                                        value="{{$variant->product_id}}" />
                                    <div class="form-row">
                                        <div class="form-group col-md-2">
                                            <label for="exampleInputEmail1">Variant Name</label>
                                            <input type="text" name="variant[{{$index}}][name]" value="{{ old('variant.' . $index . '.name', $variant->name) }}"
                                                class="form-control" aria-describedby="Name"
                                                placeholder="Enter Variant Name">
                                                @if($errors->has("variant.$index.name"))
                                                    <div class="text-danger">{{ $errors->first("variant.$index.name") }}</div>
                                                @endif
                                        </div>
                                        <div class="form-group col-md-2">
                                            @if ($loop->last)
                                                <button type="button" data-variant-id="{{ $variant->id }}" id="remove-product"
                                                    class="btn btn-danger-rgba deleteVariant"><i
                                                        class="feather icon-trash"></i></button>
                                                <button type="button" name="addProduct" id="addMoreProduct"
                                                    class="btn btn-success-rgba"><i class="fa fa-plus"
                                                        aria-hidden="true"></i></button>
                                            @else                                           <button type="button" data-variant-id="{{ $variant->id }}" id="remove-product"
                                                class="btn btn-danger-rgba deleteVariant"><i
                                                    class="feather icon-trash"></i></button>
                                            @endif
                                        </div>
                                    </div>
                                @endforeach
                                @if (count($product->ProductVariants) == 0)
                                <div class="form-row">
                                    <div class="form-group col-md-2">
                                        <label for="variantName">Variant Name</label>
                                        <input type="text" name="variant[0][name]" value="{{ old('variant.0.name') }}"
                                            class="form-control" id="variantName" aria-describedby="Name"
                                            placeholder="Enter Variant Name">
                                            @error('variant.0.name')
                                                <div class="text-danger">{{ $message }}</div>
                                            @enderror 
                                    </div>
                                    <div class="form-group col-md-2">
                                        <button type="button" name="addProduct" id="addMoreProduct"
                                            class="btn btn-success"><i class="fa fa-plus"
                                                aria-hidden="true"></i></button>
                                    </div>
                                </div>
                                @endif

                                @if (old('variant'))
                                    @foreach (old('variant') as $index => $variant)
                                        @if (!isset($product->ProductVariants[$index])) 
                                            <div class="form-row">
                                                <div class="form-group col-md-2">
                                                    <label for="variantName">Variant Name</label>
                                                    <input type="text" name="variant[{{ $index }}][name]" value="{{ old('variant.' . $index . '.name', $variant['name']) ?? '' }}" class="form-control" placeholder="Enter Variant Name">
                                                    @if($errors->has("variant.$index.name"))
                                                        <div class="text-danger">{{ $errors->first("variant.$index.name") }}</div>
                                                     @endif
                                                </div>
                                                <div class="form-group col-md-2">
                                                    <button type="button" class="btn btn-danger remove-tr" id="remove-product"><i class="fa fa-minus" aria-hidden="true"></i></button>
                                                </div>
                                            </div>
                                        @endif
                                    @endforeach
                                @endif
                            </div>
                        </div>
                        <div class="mt-3">
                            <button type="submit"
                                onclick="this.disabled=true; this.innerText='Submitting...'; this.form.submit();"
                                class="btn btn-primary-rgba mr-3">Save</button>
                                <a href="{{ urldecode($redirectUrl) }}" class="btn btn-danger-rgba">
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
<!-- variant delete model -->
<div class="modal fade" id="deleteVariantModal" tabindex="-1" aria-labelledby="deleteVariantModalLabel"
    aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Variant delete confirmation</h5>
            </div>
            <div class="modal-body">
                Are you sure you want to delete?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-primary" data-dismiss="modal">No</button>
                <button type="button" class="btn btn-outline-danger  confirm-delete-variant">yes</button>
            </div>
        </div>
    </div>
</div>
<!-- end variant delete model -->
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
        // Initialize Select2
        $('.select2').select2({
            placeholder: function() {
                return $(this).data('placeholder');
            },
            allowClear: true, // Enables clear button
        });
    });
</script>
<script>
  $(document).ready(function () {
    var productIndex = {{ count(old('variant', $product->ProductVariants)) }}; // Adjust the index based on old values or existing variants

    $('#addMoreProduct').click(function () {
        productIndex++;
        var productRow = `
            <div class="form-row">
                <div class="form-group col-md-2">
                    <label for="variantName">Variant Name</label>
                    <input type="text" name="variant[${productIndex}][name]" class="form-control" placeholder="Enter Variant Name">
                </div>
                <div class="form-group col-md-2">
                    <button type="button" class="btn btn-danger remove-tr" id="remove-product"><i class="fa fa-minus" aria-hidden="true"></i></button>
                </div>
            </div>
        `;
        $('#productSection').append(productRow);
    });

    $(document).on('click', '.remove-tr', function () {
        $(this).closest('.form-row').remove();
    });
});

</script>
<script>
    $(document).ready(function () {
        $('.deleteVariant').click(function () {
            var variantId = $(this).data('variant-id');

            $('#deleteVariantModal').modal('show');

            // Moved the click event listener for confirmation button outside the main click event
            $('.confirm-delete-variant').off('click').on('click', function () {
                // Include CSRF token in the data payload
                var token = $('meta[name="csrf-token"]').attr('content');
                // Perform AJAX request to delete the variant
                $.ajax({
                    url: '/productsVariant/' + variantId,
                    type: 'DELETE',
                    data: {
                        _token: token // Include CSRF token
                    },
                    success: function (result) {
                        // Update UI or provide feedback
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
                        setTimeout(function () {
                            window.location.reload();
                        }, 500);
                    },
                    error: function (xhr, status, error) {
                        // Handle errors
                        $('#message').html(
                            '<div class="alert alert-danger alert-dismissible fade show m-0 mt-3" role="alert">' +
                            result.error +
                            '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                            '<span aria-hidden="true">&times;</span>' +
                            '</button>' +
                            '</div>'
                        );
                    }
                });
                $('#deleteVariantModal').modal('hide');
            });
        });
    });
</script>
@endsection