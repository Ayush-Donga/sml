@section('title')
Add New Product
@endsection
@extends('layouts.main')
@section('style')

<!-- Select2 css -->
<link href="{{ asset('assets/plugins/select2/select2.min.css') }}" rel="stylesheet" type="text/css" />
<!-- Tagsinput css -->
<link href="{{ asset('assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput.css') }}" rel="stylesheet" type="text/css" />
<link href="{{ asset('assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput-typeahead.css') }}" rel="stylesheet" type="text/css" />
<style>
    .box-border {
        border: 1px solid #ccc;
        padding: 10px;
        /* Add padding for better spacing */
    }

    #addMore,
    #addMoreProduct,
    #remove-product {
        margin-top: 27px;
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
                    <h5 class="card-title">Add New Product</h5>
                </div>
                <div class="card-body">
                <form method="POST" action="{{ route('products.store') }}">
                        @csrf
                        <input type="hidden" name="redirect" value="{{ urlencode($redirectUrl) }}">
                        <div class="box-border">
                            <div id="productSection">
                                <div class="form-row">
                                    <div class="form-group col-md-2">
                                        <label for="productName">Product Name</label>
                                        <input type="text" name="name" value="{{ old('name') }}" class="form-control" id="productName" aria-describedby="Name" placeholder="Enter Product Name">
                                        @error('name')
                                            <div class="text-danger">{{ $message }}</div>
                                        @enderror
                                    </div>
                                    <div class="form-group col-md-2">
                                        <label for="heading">Heading</label>
                                        <select class="form-control select2" id="heading" name="heading">
                                            <option value="">Select</option>
                                            <option value="HARMLESS PHARMACEUTICAL MEDICINES FOR HUMAN USE" {{ old('heading') == 'HARMLESS PHARMACEUTICAL MEDICINES FOR HUMAN USE' ? 'selected' : '' }}>HARMLESS PHARMACEUTICAL MEDICINES FOR HUMAN USE</option>
                                            <option value="HARMLESS PHARMACEUTICAL MEDICINES FOR ANIMAL USE" {{ old('heading') == 'HARMLESS PHARMACEUTICAL MEDICINES FOR ANIMAL USE' ? 'selected' : '' }}>HARMLESS PHARMACEUTICAL MEDICINES FOR ANIMAL USE</option>
                                        </select>
                                        @error('heading')
                                            <div class="text-danger">{{ $message }}</div>
                                        @enderror
                                    </div>
                                    <div class="form-group col-md-2">
                                        <label for="genericName">Generic Name</label>
                                        <input type="text" name="generic_name" value="{{ old('generic_name') }}" class="form-control" id="genericName" aria-describedby="Name" placeholder="Enter Generic Name">
                                        @error('generic_name')
                                            <div class="text-danger">{{ $message }}</div>
                                        @enderror
                                    </div>
                                    <div class="form-group col-md-2">
                                        <label for="manufacturedBy">Manufactured by</label>
                                        <input type="text" name="manufactured_by" value="{{ old('manufactured_by') }}" class="form-control" id="manufacturedBy" aria-describedby="Name" placeholder="Enter Manufactured By">
                                        @error('manufactured_by')
                                            <div class="text-danger">{{ $message }}</div>
                                        @enderror
                                    </div>
                                    <div class="form-group col-md-2">
                                        <label for="hsnCode">HSN Code</label>
                                        <input type="text" name="hsn_code" value="{{ old('hsn_code') }}" class="form-control" id="hsnCode" aria-describedby="Name" placeholder="Enter HSN Code">
                                        @error('hsn_code')
                                            <div class="text-danger">{{ $message }}</div>
                                        @enderror
                                    </div>
                                </div>
                                @if(old('variant'))
                                    @foreach(old('variant') as $index => $variant)
                                        <div class="form-row">
                                            <div class="form-group col-md-2">
                                                <label for="variantName">Variant Name</label>
                                                <input type="text" name="variant[{{ $index }}][name]" value="{{ old('variant.' . $index . '.name', $variant['name']) }}" class="form-control" placeholder="Enter Variant Name">
                                                
                                                @if($errors->has("variant.$index.name"))
                                                    <div class="text-danger">{{ $errors->first("variant.$index.name") }}</div>
                                                @endif
                                            </div>
                                            <div class="form-group col-md-2">
                                                @if(count(old('variant')) > 1 && $index == 0)
                                                    <button type="button" class="btn btn-danger remove-tr" id="remove-product">
                                                        <i class="fa fa-minus" aria-hidden="true"></i>
                                                    </button>
                                                @endif
                                                @if($index > 0)
                                                <button type="button" class="btn btn-danger remove-tr" id="remove-product">
                                                        <i class="fa fa-minus" aria-hidden="true"></i>
                                                    </button>
                                                @endif                                           
                                                @if($loop->last)
                                                    <button type="button" name="addProduct" id="addMoreProduct" class="btn btn-success"><i class="fa fa-plus" aria-hidden="true"></i></button>
                                                @endif
                                            </div>
                                        </div>
                                    @endforeach
                                @else 
                                    <div class="form-row">
                                        <div class="form-group col-md-2">
                                            <label for="variantName">Variant Name</label>
                                            <input type="text" name="variant[0][name]" class="form-control" placeholder="Enter Variant Name">
                                            @error('variant.*.name')
                                                <div class="text-danger">{{ $message }}</div>
                                            @enderror
                                        </div>
                                        <div class="form-group col-md-2">
                                            <button type="button" name="addProduct" id="addMoreProduct" class="btn btn-success"><i class="fa fa-plus" aria-hidden="true"></i></button>
                                        </div>
                                    </div>
                                @endif
                            </div>
                        </div>
                        <div class="mt-3">
                            <button type="submit" onclick="this.disabled=true; this.innerText='Submitting...'; this.form.submit();" class="btn btn-primary-rgba mr-3">Save</button>
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
    var productIndex = {{ count(old('variant', [])) }};

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
@endsection

