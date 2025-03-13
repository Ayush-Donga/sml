@extends('layouts.main')

@section('title') 
Role View 
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
                <a href="{{ route('roles.index') }}" class="btn btn-primary-rgba"><i class="ti-arrow-left mr-2"></i>Back</a>
            </div>                        
        </div>
    </div>          
</div>
<!-- End Breadcrumbbar -->
@endsection

@section('rightbar-content')
<!-- Start Contentbar -->    
<div class="contentbar">                
    <div class="row">
        <div class="col-lg-12">
            <div class="card m-b-30">
                <div class="card-header">
                    <h5 class="card-title">Role Details</h5>
                </div>
                <div class="card-body">
                    <div class="row mb-6">
                        <!-- Role Name -->
                        <div class="col-md-6 col-lg-3">
                            <div class="order-primary-detail">
                                <label><strong>Role Name</strong></label>
                                <div>{{ $role->name }}</div>
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-3">
                            <div class="order-primary-detail">
                                <label><strong>Type</strong></label>
                                <div>{{ $role->type }}</div>
                            </div>
                        </div>

                        <!-- Permissions List in Two Columns -->
                        <div class="col-md-12 col-lg-6">
                            <div class="order-primary-detail">
                            <label><strong>Permissions</strong></label>
                                <div class="row">
                                  <!-- Left Column -->
                                    <div class="col-md-6">
                                        <ul class="list-unstyled">
                                            @foreach ($rolePermissions->slice(0, ceil($rolePermissions->count() / 2)) as $v)
                                                <li class="d-flex align-items-center mb-2">
                                                    <span class="badge badge-primary mr-2"><i class="feather icon-check"></i></span>
                                                    <div>{{ strtoupper(str_replace('-', ' ', $v->name)) }}</div>
                                                </li>
                                            @endforeach
                                        </ul>
                                    </div>

                                    <!-- Right Column -->
                                    <div class="col-md-6">
                                        <ul class="list-unstyled">
                                            @foreach ($rolePermissions->slice(ceil($rolePermissions->count() / 2)) as $v)
                                                <li class="d-flex align-items-center mb-2">
                                                    <span class="badge badge-primary mr-2"><i class="feather icon-check"></i></span>
                                                    <div>{{ strtoupper(str_replace('-', ' ', $v->name)) }}</div>
                                                </li>
                                            @endforeach
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>                          
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End Contentbar -->
@endsection 

@section('script')
<!-- Add custom scripts if required -->
@endsection
