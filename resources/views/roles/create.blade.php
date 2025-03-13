@extends('layouts.main')

@section('title')
    Add Role
@endsection

@section('style')
    <!-- Additional styles -->
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
                        <li class="breadcrumb-item"><a href="{{url('/roles')}}">Role</a></li>
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
    <!-- Error message section -->
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
                        <h5 class="card-title">Add Role</h5>
                    </div>
                    <div class="card-body">
                        <form method="POST" action="{{ route('roles.store') }}">
                            @csrf
                    <input type="hidden" name="redirect" value="{{ old('redirect', urlencode($redirectUrl)) }}">    
                    <div class="row mt-3">
                        <div class="col-lg-4">
                            <label for="exampleInputEmail1">Name<span class="text-danger">*</span></label>
                            <input type="text" name="name" value="{{ old('name') }}" class="form-control @error('name') is-invalid @enderror" id="validationCustom01"  aria-describedby="Name" placeholder="Enter Role Name">
                            @error('name')
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{ $message }}</strong>
                                </span>
                            @enderror
                        </div>
                    </div>

                    <div class="row mt-3">
                        <div class="col-lg-4">
                            <label for="type">Type<span class="text-danger">*</span></label>
                            <select class="form-control select2" name="type" id="type">
                                <option value="">Select</option>
                                @foreach($roleTypes as $role)
                                    <option value="{{ $role['value'] }}" {{ old('type') == $role['value'] ? 'selected' : '' }}>
                                        {{ $role['label'] }}
                                    </option>
                                @endforeach
                            </select>
                            @error('type')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>
                    </div>

                    <div class="row mt-3">
                        @foreach($categories as $categoryKey => $categoryLabel)
                            <div class="col-lg-2 mb-4">
                                <h4 class="mb-2">{{ $categoryLabel }}</h4>

                                @foreach($permission as $perm)
                                    @if($perm->category === $categoryKey)
                                        <div class="form-check">
                                            <input 
                                                class="form-check-input" 
                                                name="permission[]" 
                                                type="checkbox" 
                                                id="permCheck{{ $perm->id }}" 
                                                value="{{ $perm->id }}"
                                                data-category="{{ $perm->category }}"
                                                data-action="{{ Str::after($perm->name, $perm->category . '-') }}"
                                                {{ is_array(old('permission')) && in_array($perm->id, old('permission')) ? 'checked' : '' }}
                                            >
                                            <label 
                                                class="form-check-label" 
                                                for="permCheck{{ $perm->id }}"
                                            >
                                                {{ Str::after($perm->name, $perm->category . '-') }}
                                            </label>
                                        </div>
                                    @endif
                                @endforeach
                            </div>
                        @endforeach
                    </div>

                    <div class="mt-3">
                        @error('permission')
                            <div class="text-danger">{{ $message }}</div></br>
                        @enderror
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
<!-- End Contentbar -->
@endsection

@section('script')
<script>
    $(document).ready(function(){
        // General labels for permissions
        $('.permission-label1').html('List');
        $('.permission-label2').html('Create');
        $('.permission-label3').html('Edit');
        $('.permission-label4').html('Delete');
        $('.permission-label5').html('Reset Password');
    });
</script>
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
    $(document).ready(function() {
        // Whenever any permission checkbox changes:
        $("input.form-check-input[name='permission[]']").on("change", function() {
            let isChecked  = $(this).is(":checked");
            let category   = $(this).data("category");  // e.g. "user"
            let action     = $(this).data("action");    // e.g. "list", "create", "edit", "delete"...

            if (category === "bd-department") {
                return; // Skip any additional logic for this module
            }

            // 1) If user checks "create", "edit", or "delete", automatically check "list".
            if (isChecked && (action === "create" || action === "edit" || action === "delete" || action === "update" || action === "reset-password")) {
                // Find the "list" checkbox for this category
                let listCheckbox = $(
                    "input.form-check-input[data-category='" + category + "'][data-action='list']"
                );
                // If not checked, check it
                if (!listCheckbox.is(":checked")) {
                    listCheckbox.prop("checked", true);
                }
            }

            // 2) (Optional) If user unchecks "list", uncheck all others in the same category
            if (!isChecked && action === "list") {
                // Uncheck all others in this category
                $("input.form-check-input[data-category='" + category + "']")
                    .not(this)     // skip the "list" itself
                    .prop("checked", false);
            }
        });
    });
</script>
@endsection
