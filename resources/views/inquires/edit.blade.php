@extends('layouts.main')

@section('title')
    Edit Inquire
@endsection

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
                        <li class="breadcrumb-item"><a href="{{url('/inquires')}}">Inquire</a></li>
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
                @if ($message = Session::get('success'))
                <div class="alert alert-success alert-dismissible fade show m-0 mt-3" role="alert">
                    {{ $message }}
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>         
                @endif
                    
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
                    <h5 class="card-title">Edit Inquire</h5>
                </div>
                <div class="card-body">
                <form method="POST" action="{{ route('inquires.update', $inquire->id) }}">
                    @csrf
                    @method('PATCH')
                    <input type="hidden" name="redirect" value="{{ urlencode($redirectUrl) }}">
                    <!-- Type: Radio Buttons -->
                    <div class="form-group">
                        <label>Type <span class="text-danger">*</span></label>
                        <div class="d-flex align-items-center">
                            <div class="form-check mr-3">
                                <input class="form-check-input @error('type') is-invalid @enderror" 
                                    type="radio" name="type" id="brand" 
                                    value="brand" 
                                    {{ old('type', $inquire->type) == 'brand' ? 'checked' : '' }} required>
                                <label class="form-check-label" for="brand">
                                    Brand
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input @error('type') is-invalid @enderror" 
                                    type="radio" name="type" id="generic" 
                                    value="generic" 
                                    {{ old('type', $inquire->type) == 'generic' ? 'checked' : '' }} required>
                                <label class="form-check-label" for="generic">
                                    Generic
                                </label>
                            </div>
                        </div>
                        @error('type')
                            <div class="text-danger">{{ $message }}</div>
                        @enderror
                    </div>

                    <!-- Brand Dropdown -->
                    <div class="form-group" id="brand_section">
                        <label for="brand_id">Brand Name</label>
                        <select name="brand_id" id="brand_id" 
                                class="form-control select2 @error('brand_id') is-invalid @enderror">
                            <option value="">Select Brand</option>
                            @foreach($brands as $brand)
                                @if($brand->status != 0 || old('brand_id', $inquire->brand_id) == $brand->id)
                                    <option value="{{ $brand->id }}" 
                                        {{ old('brand_id', $inquire->brand_id) == $brand->id ? 'selected' : '' }}>
                                        {{ $brand->name }}
                                    </option>
                                @endif
                            @endforeach
                        </select>
                        @error('brand_id')
                            <div class="text-danger">{{ $message }}</div>
                        @enderror
                    </div>

                    <!-- Generic Dropdown -->
                    <div class="form-group" id="generic_section" style="display: none;">
                        <label for="generic_id">Generic Name</label>
                        <select name="generic_id" id="generic_id" 
                                class="form-control select2 @error('generic_id') is-invalid @enderror">
                            <option value="">Select Generic</option>
                            @foreach($generics as $generic)
                                <option value="{{ $generic->id }}" 
                                    {{ old('generic_id', $inquire->generic_id) == $generic->id ? 'selected' : '' }}>
                                    {{ $generic->name }}
                                </option>
                            @endforeach
                        </select>
                        @error('generic_id')
                            <div class="text-danger">{{ $message }}</div>
                        @enderror
                    </div>

                    <div class="form-group">
                        <label for="no_of_brand">Number Of Brand</label>
                        <input type="number" name="no_of_brand" id="no_of_brand" class="form-control @error('no_of_brand') is-invalid @enderror" value="{{ old('no_of_brand', $inquire->no_of_brand) }}" min="1" placeholder="Enter number of brand">
                        @error('no_of_brand')
                            <div class="text-danger">{{ $message }}</div>
                        @enderror
                    </div>

                    <div class="form-group">
                        <label for="quantity">Quantity</label>
                        <input type="number" name="quantity" id="quantity" class="form-control @error('quantity') is-invalid @enderror" value="{{ old('quantity', $inquire->quantity) }}" min="1" placeholder="Enter quantity">
                        @error('quantity')
                            <div class="text-danger">{{ $message }}</div>
                        @enderror
                    </div>

                    <div class="form-group">
                        <label for="no_of_supplier">Number Of Supplier</label>
                        <input type="number" name="no_of_supplier" id="no_of_supplier" class="form-control @error('no_of_supplier') is-invalid @enderror" value="{{ old('no_of_supplier', $inquire->no_of_supplier) }}" min="1" placeholder="Enter number of supplier">
                        @error('no_of_supplier')
                            <div class="text-danger">{{ $message }}</div>
                        @enderror
                    </div>

                    <!-- Checkboxes -->
                    <div class="form-group">
                        <label>Options</label>
                        @foreach(['generic_name', 'brand_name', 'pack_size', 'manufacturer_name', 'gst', 'storage_condition', 'product_photo', 'product_doc', 'vendor_name', 'price_per_pack', 'expiry', 'lead_time'] as $option)
                            <div class="form-check">
                                @if(in_array($option, ['pack_size', 'price_per_pack', 'expiry', 'lead_time']))
                                    <!-- Hidden compulsory field -->
                                    <input type="hidden" name="is_{{ $option }}" value="true">
                                @else
                                    <!-- Optional fields -->
                                    <input type="hidden" name="is_{{ $option }}" value="0"> <!-- Default value -->
                                    <input class="form-check-input @error('is_' . $option) is-invalid @enderror" 
                                        type="checkbox" 
                                        name="is_{{ $option }}" 
                                        id="is_{{ $option }}" 
                                        value="1" 
                                        {{ old('is_' . $option, isset($inquire) ? $inquire->{'is_' . $option} : false) == 1 ? 'checked' : '' }}>
                                    <label class="form-check-label" for="is_{{ $option }}">{{ ucfirst(str_replace('_', ' ', $option)) }}</label>
                                @endif
                            </div>
                            @error('is_' . $option) 
                                <div class="text-danger">{{ $message }}</div> 
                            @enderror
                        @endforeach
                    </div>

                    <!-- Submit and Cancel Buttons -->
                    <div class="mt-3">
                        <button type="submit" class="btn btn-primary-rgba mr-3" onclick="this.disabled=true; this.innerText='Updating...'; this.form.submit();">Update</button>
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
    document.addEventListener('DOMContentLoaded', function () {
        function toggleSections() {
            var selectedType = document.querySelector('input[name="type"]:checked');
            var brandSection = document.getElementById('brand_section');
            var genericSection = document.getElementById('generic_section');
            var numberOfBrandSection = document.getElementById('no_of_brand').closest('.form-group');
            var isBrandName = document.getElementById('is_brand_name');
            var isGenericName = document.getElementById('is_generic_name');

            if (selectedType && selectedType.value === 'brand') {
                brandSection.style.display = 'block';
                genericSection.style.display = 'none';
                numberOfBrandSection.style.display = 'none';
                isBrandName.disabled = true;
                isGenericName.disabled = false;
            } else if (selectedType && selectedType.value === 'generic') {
                brandSection.style.display = 'none';
                genericSection.style.display = 'block';
                numberOfBrandSection.style.display = 'block';
                isBrandName.disabled = false;
                isGenericName.disabled = true;
            } else {
                brandSection.style.display = 'none';
                genericSection.style.display = 'none';
                numberOfBrandSection.style.display = 'none';
                isBrandName.disabled = true;
                isGenericName.disabled = true;
            }
        }

        // Initial call to set state correctly
        toggleSections();

        // Add event listeners to radio buttons
        document.querySelectorAll('input[name="type"]').forEach(function (radio) {
            radio.addEventListener('change', toggleSections);
        });
    });
</script>

@endsection
