@section('title') 
User View
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

        @if ($message = Session::get('success'))
            <div class="alert alert-success">
            <p>{{ $message }}</p>
            </div>
        @endif

        
        <!-- Start col -->
        <div class="col-lg-12">
            <div class="col-lg-12 d-flex justify-content-end">
                
            </div>
            <div class="card m-b-30">
            <div class="col-lg-7 col-xl-8">
                        <div class="card m-b-30">
                            <div class="card-header">                                
                                <div class="row align-items-center">
                                </div>
                            </div>
                            <div class="card-body">                                
                                <div class="row mb-5">
                                    <div class="col-md-6 col-lg-6 col-xl-3">
                                        <div class="order-primary-detail mb-4">
                                        <h6>Name</h6>
                                        <p class="mb-0">{{ $user->name }}</p>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-lg-6 col-xl-3">
                                        <div class="order-primary-detail mb-4">
                                        <h6>Email ID</h6>
                                        <p class="mb-0 text-truncate d-inline-block" style="max-width: 200px;" 
                                            data-toggle="tooltip" data-placement="top" title="{{ $user->email }}">
                                                {{ $user->email }}
                                            </p>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-lg-6 col-xl-3">
                                        <div class="order-primary-detail mb-4">
                                        <h6>Role</h6>
                                        @if(!empty($user->getRoleNames()))
                                                @foreach($user->getRoleNames() as $v)
                                                    <span class="badge badge-success-inverse">{{ $v }}</span>
                                                @endforeach
                                            @endif 
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-lg-6 col-xl-3">
                                        <div class="order-primary-detail mb-4">
                                        <h6>Parent Name</h6>
                                        <p class="mb-0">{{ $user->parent ? $user->parent->name : '' }}</p>
                                        </div>
                                    </div>
                                </div>                          
                            </div>
                        </div>             
                    </div>
            </div>
        </div>
        <!-- End col -->
    </div>
    <!-- End row -->
</div>
<!-- End Contentbar -->
@endsection 
@section('script')
<script>
    $(document).ready(function(){
        $('[data-toggle="tooltip"]').tooltip();
    });
</script>
@endsection 