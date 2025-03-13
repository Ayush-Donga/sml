@section('title')
Add New User
@endsection
@extends('layouts.main')
@section('style')
<!-- Select2 css -->
<link href="{{ asset('assets/plugins/select2/select2.min.css') }}" rel="stylesheet" type="text/css" />
<!-- Tagsinput css -->
<link href="{{ asset('assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput.css') }}" rel="stylesheet" type="text/css" />
<link href="{{ asset('assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput-typeahead.css') }}" rel="stylesheet" type="text/css" />
@endsection

{{-- @section('errormessege')
    <div class="contentbar p-0 m-0" style="padding-right :30px !important;">
        <!-- Start row -->
        <div class="row justify-content-end">
            <div class="col-lg-4">
            @if (count($errors) > 0)
                <div class="alert alert-danger alert-dismissible fade show m-0 mt-3" role="alert">
                <strong>Whoops!</strong> There were some problems with your input.<br><br>
                    @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            @endif

            </div>
        </div>
    </div>
@endsection --}}

@section('breadcrumbbar')
    <!-- Start Breadcrumbbar -->
    <div class="breadcrumbbar">
    <div class="row align-items-center">
        <div class="col-md-8 col-lg-8">
            <h4 class="page-title">@yield('title')</h4>
            <div class="breadcrumb-list">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="{{url('/')}}">Home</a></li>
                    <li class="breadcrumb-item"><a href="{{url('/users')}}">Users</a></li>
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
                    <h5 class="card-title">Add New User</h5>
                </div>
                <div class="card-body">
                    <form method="POST" action="{{ route('users.store') }}">
                        @csrf
                        <input type="hidden" name="redirect" value="{{ old('redirect', urlencode($redirectUrl)) }}">
                        <div class="form-group">
                            <label for="exampleInputEmail1">Name<span class="text-danger">*</span></label>
                            <input type="text"  name="name" value="{{old('name')}}" class="form-control @error('name') is-invalid @enderror"  aria-describedby="Name" placeholder="Enter Your Name">
                            @if ($errors->has('name'))
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{ $errors->first('name') }}</strong>
                                </span>
                            @endif
                        </div>
                        
                        <div class="form-group">
                            <label for="exampleInputEmail1">Email address<span class="text-danger">*</span></label>
                            <input type="email" name="email" value="{{old('email')}}" class="form-control text-uppercase @error('email') is-invalid @enderror" aria-describedby="emailHelp" placeholder="Enter Your Email" autocomplete="off">
                            <small id="emailHelp" class="form-text text-muted text-uppercase">We'll never share your email with anyone else.</small>
                            @if ($errors->has('email'))
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{ $errors->first('email') }}</strong>
                                </span>
                            @endif
                        </div>

                        <div class="form-group">
                            <label for="exampleInputPassword1">Password<span class="text-danger">*</span></label>
                            <input type="password" name="password" value="{{old('password')}}" class="form-control text-uppercase @error('password') is-invalid @enderror" id="validationCustom03" placeholder="Password" autocomplete="off">
                            @if ($errors->has('password'))
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{ $errors->first('password') }}</strong>
                                </span>
                            @endif
                        </div>

                        <div class="form-group">
                            <label for="exampleInputPassword1">Confirm Password<span class="text-danger">*</span></label>
                            <input type="password" name="confirm-password" value="{{old('confirm-password')}}" class="form-control text-uppercase @error('confirm-password') is-invalid @enderror" id="validationCustom04" placeholder="Confirm Password" autocomplete="off">
                            @if ($errors->has('confirm-password'))
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{ $errors->first('confirm-password') }}</strong>
                                </span>
                            @endif
                        </div>

                        <div class="form-group">
                            <label for="validationCustom05">Role<span class="text-danger">*</span></label>
                            <select class="select2-multi-select form-control @error('role') is-invalid @enderror" 
                                    name="role[]" multiple id="validationCustom05">
                                <optgroup label="Select Role">
                                    @foreach ($roles as $role)
                                        <option value="{{$role}}" {{ old('role') && in_array($role, old('role')) ? "selected" : "" }}>{{$role}}</option>
                                    @endforeach
                                </optgroup>
                            </select>
                            @if ($errors->has('role'))
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{ $errors->first('role') }}</strong>
                                </span>
                            @endif
                        </div>

                        <div class="form-group orderProduct">
                            <label for="parentName">Parent Name</label>
                            <select class="form-control select2-multi-select" name="parent_id" id="parentName" placeholder="Please Select Parent Name">
                                <option value="">Select Parent Name</option>
                                @foreach($parents as $parent)
                                    <option value="{{ $parent->id }}" {{ old('parent_id') == $parent->id ? 'selected' : '' }}>
                                        {{ $parent->name }}
                                    </option>
                                @endforeach
                            </select>
                        </div>

                        <div class="switchery-list">
                            <label for="exampleInputEmail1">Status is Active ?</label>
                            <input type="checkbox" class="js-switch-primary" name="status" value="1" data-on="Active" stye data-off="InActive" style="width:22px; height:22px;" checked/>
                        </div>

                        <div class="mt-3">
                            <button type="submit" onclick="this.disabled=true; this.innerText='Submitting...'; this.form.submit();" class="btn btn-primary-rgba mr-3">Submit</button>
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
    // Initialize select2 with correct settings
    $('.select2-multi-select').select2({
        placeholder: "Select Roles",
        allowClear: true,
        width: '100%',
        closeOnSelect: false, // Keep dropdown open for multiple selections
        minimumResultsForSearch: 5, // Show search only if more than 5 options
    });

    // Prevent duplicate selections
    $('.select2-multi-select').on('change', function() {
        let selectedOptions = $(this).val() || [];
        let uniqueOptions = [...new Set(selectedOptions)]; // Remove duplicates
        $(this).val(uniqueOptions).trigger('change.select2'); // Reapply selection
    });

    // Fix the issue where selected values make the input area too big
    $('.select2-selection--multiple').css('overflow-y', 'hidden');

    // Ensure dropdown fits within the viewport properly
    $('.select2-dropdown').css({
        'max-height': '250px',
        'overflow-y': 'auto'
    });

    $('#parentName').select2({
        placeholder: "Select Parent Name",
        allowClear: true,
        width: '100%',
        minimumResultsForSearch: 5,
    });
});
</script>
@endsection

