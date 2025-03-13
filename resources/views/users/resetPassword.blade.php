@section('title')
Reset Password User
@endsection
@extends('layouts.main')
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
                    <li class="breadcrumb-item"><a href="{{url('/users')}}">Users</a></li>
                    <li class="breadcrumb-item active" aria-current="page">@yield('title')</li>
                </ol>
            </div>
        </div>
        <div class="col-md-4 col-lg-4">
            <div class="widgetbar">
                <a href="{{ route('users.index') }}" class="btn btn-primary-rgba"><i class="ti-arrow-left mr-2"></i>Back</a>
            </div>
        </div>
    </div>
    </div>
    <!-- End Breadcrumbbar -->
@endsection


@section('rightbar-content')
<!-- Start Contentbar -->
<div class="contentbar">
    <!-- Start row -->
    <div class="row">
        <!-- Start col -->
        <div class="col-lg-6">
            <div class="card m-b-30">
                <div class="card-header">
                    <h5 class="card-title">Reset Password User</h5>
                </div>
                <div class="card-body">
                    <form method="POST" action="{{ route('users.updateResetPassword', $user->id) }}">
                        @method('PATCH')
                        @csrf
                        <div class="form-group">
                            <label for="newpassword">New Password<span class="text-danger">*</span></label>
                            <div class="input-group">
                            <input type="password" name="newpassword" 
                                    class="form-control @error('newpassword') is-invalid @enderror"
                                    id="newpassword" placeholder="Enter new password" value="{{ old('newpassword') }}">
                                <div class="input-group-append">
                                    <span class="input-group-text" onclick="togglePasswordVisibility('newpassword', 'toggleNewPasswordIcon')">
                                        <i class="fa fa-eye-slash" id="toggleNewPasswordIcon"></i>
                                    </span>
                                </div>
                                @error('newpassword')
                                    <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="newpassword_confirmation">Confirm Password<span class="text-danger">*</span></label>
                            <div class="input-group">
                            <input type="password" name="newpassword_confirmation"
                                    class="form-control @error('newpassword_confirmation') is-invalid @enderror"
                                    id="newpassword_confirmation" placeholder="Confirm new password" value="{{ old('newpassword_confirmation') }}">
                                <div class="input-group-append">
                                    <span class="input-group-text" onclick="togglePasswordVisibility('newpassword_confirmation', 'toggleConfirmPasswordIcon')">
                                        <i class="fa fa-eye-slash" id="toggleConfirmPasswordIcon"></i>
                                    </span>
                                </div>
                                @error('newpassword_confirmation')
                                    <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>
                        </div>
                        <div class="mt-3">
                            <button type="submit" class="btn btn-primary-rgba mr-3">Save</button>
                            <a href="{{ route('users.index') }}" class="btn btn-danger-rgba">Cancel</a>
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
function togglePasswordVisibility(fieldId, iconId) {
    const field = document.getElementById(fieldId);
    const icon = document.getElementById(iconId);
    if (field.type === 'password') {
        field.type = 'text';
        icon.classList.remove('fa-eye-slash');
        icon.classList.add('fa-eye');
    } else {
        field.type = 'password';
        icon.classList.remove('fa-eye');
        icon.classList.add('fa-eye-slash');
    }
}
</script>
@endsection
