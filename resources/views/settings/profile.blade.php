@section('title') 
My profile
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
                    <li class="breadcrumb-item active" aria-current="page">@yield('title')</li>
                </ol>
            </div>
        </div>
        <div class="col-md-4 col-lg-4">                       
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
        <div class="col-lg-5 col-xl-3">
            <div class="card m-b-30">
                <div class="card-header">                                
                    <h5 class="card-title mb-0">My Account</h5>
                </div>
                <div class="card-body">
                    <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                        <a class="nav-link mb-2 {{ $activeTab === 'v-pills-profile' ? 'active' : '' }}" id="v-pills-profile-tab" data-toggle="pill" href="#v-pills-profile" role="tab" aria-controls="v-pills-profile" aria-selected="{{ $activeTab === 'v-pills-profile' ? 'true' : 'false' }}"><i class="feather icon-user mr-2"></i>My Profile</a>
                        <a class="nav-link mb-2 {{ $activeTab === 'v-pills-dashboard' ? 'active' : '' }}" id="v-pills-dashboard-tab" data-toggle="pill" href="#v-pills-dashboard" role="tab" aria-controls="v-pills-dashboard" aria-selected="{{ $activeTab === 'v-pills-dashboard' ? 'true' : 'false' }}"><i class="feather icon-grid mr-2"></i>Change Password</a>
                        <a class="nav-link {{ $activeTab === 'v-pills-logout' ? 'active' : '' }}" id="v-pills-logout-tab" data-toggle="pill" href="#v-pills-logout" role="tab" aria-controls="v-pills-logout" aria-selected="{{ $activeTab === 'v-pills-logout' ? 'true' : 'false' }}"><i class="feather icon-log-out mr-2"></i>Logout</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- End col -->
        <!-- Start col -->
        <div class="col-lg-7 col-xl-9">
            <div class="tab-content" id="v-pills-tabContent">
                <!-- Dashboard Start -->
                <div class="tab-pane fade {{ $activeTab === 'v-pills-dashboard' ? 'show active' : '' }}" id="v-pills-dashboard" role="tabpanel" aria-labelledby="v-pills-dashboard-tab">
                <div class="card m-b-30">
                        <div class="card-header">                                
                            <h5 class="card-title mb-0">Update Your Password</h5>
                        </div>
                        <div class="card-body">
                        <form method="POST" action="{{ url('changepassword') }}">
                            @csrf
                            <div class="form-row">
                                <!-- Current Password Field -->
                                <div class="form-group col-md-7">
                                    <label for="currentpassword">Current Password<span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <input type="password" name="currentpassword" class="form-control text-uppercase @error('currentpassword') is-invalid @enderror" id="currentpassword" placeholder="Enter Current Password">
                                        <div class="input-group-append">
                                            <span class="input-group-text" toggle="#currentpassword">
                                                <i class="toggle-password fa fa-fw fa-eye-slash"></i>
                                            </span>
                                        </div>
                                    </div>
                                   
                                    @error('currentpassword')
                                        <div class="text-danger text-uppercase">{{ $message }}</div>
                                    @enderror
                                </div>


                                <!-- New Password Field -->
                                <div class="form-group col-md-7">
                                    <label for="newpassword">New Password<span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <input type="password" name="newpassword" class="form-control text-uppercase @error('newpassword') is-invalid @enderror" id="newpassword" placeholder="Enter New Password">
                                        <div class="input-group-append">
                                            <span class="input-group-text" toggle="#newpassword">
                                                <i class="toggle-password fa fa-fw fa-eye-slash" aria-hidden="true"></i>
                                            </span>
                                        </div>
                                    </div>
                                    @error('newpassword')
                                        <div class="text-danger text-uppercase">{{ $message }}</div>
                                    @enderror
                                </div>

                                <!-- Confirm Password Field -->
                                <div class="form-group col-md-7">
                                    <label for="newpassword_confirmation">Confirm Password<span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <input type="password" name="newpassword_confirmation" class="form-control text-uppercase @error('newpassword_confirmation') is-invalid @enderror" id="newpassword_confirmation" placeholder="Enter Confirm Password">
                                        <div class="input-group-append">
                                            <span class="input-group-text" toggle="#newpassword_confirmation">
                                                <i class="toggle-password fa fa-fw fa-eye-slash" aria-hidden="true"></i>
                                            </span>
                                        </div>
                                    </div>
                                    @error('newpassword_confirmation')
                                        <div class="text-danger text-uppercase">{{ $message }}</div>
                                    @enderror
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary-rgba font-16"><i class="feather icon-save mr-2"></i>Update</button>
                        </form>
                        </div>
                    </div>
                </div>
                <!-- Dashboard End -->
               
                <!-- My Profile Start -->
                <div class="tab-pane fade {{ $activeTab === 'v-pills-profile' ? 'show active' : '' }}" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">
                    <div class="card m-b-30">
                        <div class="card-header">                                
                            <h5 class="card-title mb-0">Edit Profile Informations</h5>
                        </div>
                        <div class="card-body">
                            <form method="POST" action="{{ url('profile') }}">
                                @csrf
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label for="username">Username<span class="text-danger">*</span></label>
                                        <input type="text" name="name" value="{{ $profile->name }}"
                                            class="form-control @error('name') is-invalid @enderror" id="username">
                                        @error('name')
                                            <div class="text-danger text-uppercase">{{ $message }}</div>
                                        @enderror
                                    </div>
                                    <div class="form-group col-md-6">
                                    <label for="useremail">Email<span class="text-danger">*</span></label>
                                    <input type="email" name="email" value="{{ $profile->email }}"
                                        class="form-control @error('email') is-invalid @enderror" id="useremail" readonly>
                                    @error('email')
                                        <div class="text-danger text-uppercase">{{ $message }}</div>
                                    @enderror
                                </div>
                                </div>
                                <button type="submit" class="btn btn-primary-rgba font-16"><i class="feather icon-save mr-2"></i>Update</button>
                            </form>
                        </div>
                    </div>
                </div>
                <!-- My Profile End -->
                <!-- My Logout Start -->
                <div class="tab-pane fade" id="v-pills-logout" role="tabpanel" aria-labelledby="v-pills-logout-tab">
                    <div class="card m-b-30">
                        <div class="card-header">                                
                            <h5 class="card-title mb-0">Logout</h5>                                       
                        </div>
                        <div class="card-body">
                            <div class="row justify-content-center">
                                <div class="col-lg-6 col-xl-4">
                                <div class="logout-content text-center my-5">
                                        <img src="assets/images/ecommerce/logout.svg" class="img-fluid mb-5" alt="logout">
                                        <h2 class="text-success">Logout ?</h2>
                                        <p class="my-4">Are you sure you want to Log out?</p>
                                        <div class="button-list">
                                            <a href="{{ route('logout') }}" 
                                            onclick="event.preventDefault(); document.getElementById('logout-form').submit();" 
                                            class="btn btn-danger font-16">
                                                <i class="feather icon-check mr-2"></i>Yes, I'm sure
                                            </a>
                                            <form id="logout-form" action="{{ route('logout') }}" method="POST" class="d-none">
                                                @csrf
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- My Logout End -->                            
            </div>                        
        </div>
        <!-- End col -->
    </div>
    <!-- End row -->                  
</div>
<!-- End Contentbar -->
@endsection 
@section('script')
<!-- eCommerce My Account Page js -->
<script src="{{ asset('assets/js/custom/custom-ecommerce-myaccount.js') }}"></script>
<!-- Parsley js -->
<script src="{{ asset('assets/plugins/validatejs/validate.min.js') }}"></script>
<!-- Validate js -->
<script src="{{ asset('assets/js/custom/custom-validate.js') }}"></script>
<script src="{{ asset('assets/js/custom/custom-form-validation.js') }}"></script>
<script>
document.addEventListener("DOMContentLoaded", function() {
    document.querySelectorAll('.nav-link').forEach(function(element) {
        element.addEventListener('click', function(e) {
            var activeTab = e.currentTarget.getAttribute('href').substring(1);
            var url = new URL(window.location.href);
            url.searchParams.set('active_tab', activeTab);
            window.history.replaceState({}, '', url);
        });
    });
});
</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    $(document).ready(function () {
        $(".toggle-password").click(function () {
            $(this).toggleClass("fa-eye fa-eye-slash");
            var input = $(this).closest('.input-group').find("input");
            if (input.attr("type") === "password") {
                input.attr("type", "text");
            } else {
                input.attr("type", "password");
            }
        });
    });
</script>

@endsection 