@section('title')
Add New Customer
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
                    <li class="breadcrumb-item"><a href="{{url('/customers')}}">Customers</a></li>
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
                    <h5 class="card-title">Add New Customer</h5>
                </div>
                <div class="card-body">
                    <form method="POST" action="{{ route('customers.store') }}">
                        @csrf
                        <input type="hidden" name="redirect" value="{{ urlencode($redirectUrl) }}">
                        <div class="form-group">
                            <label for="exampleInputEmail1">Ship To</label>
                            <select class="form-control select2" name="parent_id" placeholder="Please Select Parent Name">
                                <option value="">Select</option>
                                @foreach($customers as $customer)
                                    <option value="{{ $customer->id }}" {{ old('parent_id') == $customer->id ? 'selected' : '' }}>
                                        {{ $customer->client_code . ' / ' . $customer->company_name }}
                                    </option>
                                @endforeach
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">COMPANY / PATIENT NAME<span
                                    class="text-danger">*</span></label>
                            <input type="text" name="company_name" value="{{old('company_name')}}"
                                class="form-control @error('company_name') is-invalid @enderror"
                                aria-describedby="company_name" placeholder="Enter COMPANY / PATIENT NAME" required>
                            @error('company_name')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Email ID</label>
                            <input type="text" name="email" value="{{old('email')}}"
                                class="form-control @error('email') is-invalid @enderror" aria-describedby="email"
                                placeholder="Enter Email ID" required>
                            @error('email')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Phone Number<span class="text-danger">*</span></label>
                            <input type="text" name="phone_no" value="{{old('phone_no')}}"
                                class="form-control @error('phone_no') is-invalid @enderror" aria-describedby="phone_no"
                                placeholder="Enter Phone Number" required>
                            @error('phone_no')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Registration Number</label>
                            <input type="text" name="registration_no" value="{{old('registration_no')}}"
                                class="form-control @error('registration_no') is-invalid @enderror"
                                aria-describedby="registration_no" placeholder="Enter Registration Number">
                                @error('registration_no')
                                    <div class="text-danger">{{ $message }}</div>
                                @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Address<span class="text-danger">*</span></label>
                            <textarea name="address" class="form-control @error('address') is-invalid @enderror"
                                placeholder="Enter Address" required>{{ old('address')}}</textarea>
                            @error('address')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Zip Code</label>
                            <input type="text" name="zip_code" value="{{old('zip_code')}}"
                                class="form-control @error('zip_code') is-invalid @enderror" aria-describedby="zip_code"
                                placeholder="Enter Zip Code" required>
                            @error('zip_code')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Bank Name<span class="text-danger">*</span></label>
                            <select class="form-control" name="bank_id" placeholder="Please Select Bank Name">
                                <option value="">Select</option>
                                @foreach($banks as $bank)
                                    <option value="{{ $bank->id }}" {{ old('bank_id') == $bank->id ? 'selected' : '' }}>
                                        {{ $bank->name . ' (AC No : ' . $bank->account_no . ')' }}
                                    </option>
                                @endforeach
                            </select>
                            @error('bank_id')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Currency<span class="text-danger">*</span></label>
                            <select class="form-control select2" name="currency" placeholder="Please Select Currency">
                                <option value="">Select</option>
                                <option value="USD" {{ old('currency') == 'USD' ? 'selected' : '' }}>USD</option>
                                <option value="EURO" {{ old('currency') == 'EURO' ? 'selected' : '' }}>EURO</option>
                                <option value="SGD" {{ old('currency') == 'SGD' ? 'selected' : '' }}>SGD</option>
                                <option value="AED" {{ old('currency') == 'AED' ? 'selected' : '' }}>AED</option>
                                <option value="GBP" {{ old('currency') == 'GBP' ? 'selected' : '' }}>GBP</option>
                            </select>
                            @error('currency')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="mt-3">
                            <button type="submit" class="btn btn-primary-rgba mr-3"
                                onclick="this.disabled=true; this.innerText='Submitting...'; this.form.submit();">Submit</button>
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
@endsection

