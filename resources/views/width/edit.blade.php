@section('title')
Edit Weight
@endsection
@extends('layouts.main')
@section('style')

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
                    <li class="breadcrumb-item"><a href="{{url('/width')}}">Weight</a></li>
                    <li class="breadcrumb-item active" aria-current="page">@yield('title')</li>
                </ol>
            </div>
        </div>
        <div class="col-md-4 col-lg-4">
            <div class="widgetbar">
                <a href="{{ route('width.index') }}" class="btn btn-primary-rgba"><i class="ti-arrow-left mr-2"></i>Back</a>
            </div>
        </div>
    </div>
    </div>
    <!-- End Breadcrumbbar -->
@endsection

@section('errormessege')

{{-- <div class="contentbar p-0 m-0" style="padding-right :30px !important;">
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
</div> --}}

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
                    <h5 class="card-title">Edit Weight</h5>
                </div>
                <div class="card-body">
                    <form method="post" action="{{ route('width.update',$width->id) }}" >
                        @method('PATCH')
                        @csrf
                        <div class="form-group">
                            <label for="exampleInputEmail1">Weight<span class="text-danger">*</span></label>
                            <input type="text" name="name" value="{{ $width->name }}" class="form-control @error('name') is-invalid @enderror" placeholder="Enter Weight">
                            @if ($errors->has('name'))
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{ $errors->first('name') }}</strong>
                                </span>
                            @endif
                        </div>

                        <div class="switchery-list">
                        <label for="exampleInputEmail1">Status is Active ?</label>
                           <input type="checkbox" class="js-switch-primary" name="status" value="1" data-on="Active" stye data-off="InActive" style="width:22px; height:22px;" {{ $width->status == 1 ? 'checked' : ''}}/>
                        </div>

                        <div class="mt-3">
                            <button type="submit" class="btn btn-primary-rgba mr-3">Save</button>
                            <a href="{{ route('width.index') }}" class="btn btn-danger-rgba">Cancel</a>
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

<!-- Parsley js -->
<script src="{{ asset('assets/plugins/validatejs/validate.min.js') }}"></script>
<!-- Validate js -->
<script src="{{ asset('assets/js/custom/custom-validate.js') }}"></script>
<script src="{{ asset('assets/js/custom/custom-form-validation.js') }}"></script>
<!-- Custom Switchery js -->
<script src="{{ asset('assets/js/custom/custom-switchery.js') }}"></script>
@endsection
