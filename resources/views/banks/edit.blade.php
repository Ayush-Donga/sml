@section('title')
Edit Bank
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
                    <li class="breadcrumb-item"><a href="{{url('/banks')}}">Bank</a></li>
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
                    <h5 class="card-title">Edit Bank</h5>
                </div>
                <div class="card-body">
                    <form method="post" action="{{ route('banks.update', $bank->id) }}">
                        @method('PATCH')
                        @csrf
                        <input type="hidden" name="redirect" value="{{ old('redirect', urlencode($redirectUrl)) }}">
                        <div class="form-group">
                            <label for="exampleInputEmail1">Bank Name<span class="text-danger">*</span></label>
                            <input type="text" name="name" value="{{ old('name', $bank->name) }}" class="form-control @error('name') is-invalid @enderror" aria-describedby="name" placeholder="Enter Bank NAME" required>
                            @error('name')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Account Name<span class="text-danger">*</span></label>
                            <input type="text" name="account_name" value="{{ old('account_name', $bank->account_name) }}" class="form-control @error('account_name') is-invalid @enderror" aria-describedby="account_name" placeholder="Enter Account Name" required>
                            @error('account_name')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Account Number<span class="text-danger">*</span></label>
                            <input type="text" name="account_no" value="{{ old('account_no', $bank->account_no) }}" class="form-control @error('account_no') is-invalid @enderror" aria-describedby="account_no" placeholder="Enter Account Number" required>
                            @error('account_no')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Swift Code No<span class="text-danger">*</span></label>
                            <input type="text" name="swift_code_no" value="{{ old('swift_code_no', $bank->swift_code_no) }}" class="form-control @error('swift_code_no') is-invalid @enderror" aria-describedby="swift_code_no" placeholder="Enter Swift Code Number" required>
                            @error('swift_code_no')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">IFSC Code<span class="text-danger">*</span></label>
                            <input type="text" name="ifsc_code" value="{{ old('ifsc_code', $bank->ifsc_code) }}" class="form-control @error('ifsc_code') is-invalid @enderror" aria-describedby="ifsc_code" placeholder="Enter IFSC Code" required>
                            @error('ifsc_code')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Branch<span class="text-danger">*</span></label>
                            <input type="text" name="branch" value="{{ old('branch', $bank->branch) }}" class="form-control @error('branch') is-invalid @enderror" aria-describedby="branch" placeholder="Enter Branch" required>
                            @error('branch')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="mt-3">
                            <button type="submit" class="btn btn-primary-rgba mr-3" onclick="this.disabled=true; this.innerText='Submitting...'; this.form.submit();">Submit</button>
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