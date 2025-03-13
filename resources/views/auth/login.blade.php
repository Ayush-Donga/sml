<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="author" content="Themesbox">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>SMPL - Login</title>
    <!-- Fevicon --> 
    <link rel="shortcut icon" href="{{ asset('assets/images/smpl-logo.png') }}">
    <!-- Start CSS -->
    <link href="{{ asset('assets/css/bootstrap.min.css') }}" rel="stylesheet" type="text/css">
    <link href="{{ asset('assets/css/icons.css') }}" rel="stylesheet" type="text/css">
    <link href="{{ asset('assets/css/flag-icon.min.css') }}" rel="stylesheet" type="text/css">
    <link href="{{ asset('assets/css/style.css') }}" rel="stylesheet" type="text/css">
    <!-- End CSS -->
</head>
<body class="vertical-layout">
    <!-- Start Containerbar -->
    <div id="containerbar" class="containerbar authenticate-bg">
        <!-- Start Container -->
        <div class="container">
            <div class="auth-box login-box">
                <!-- Start row -->
                <div class="row no-gutters align-items-center justify-content-center">
                    <!-- Start col -->
                    <div class="col-md-6 col-lg-5">
                        <!-- Start Auth Box -->
                        <div class="auth-box-right">
                            <div class="card">
                                <div class="card-body">
                                    @if (session('error'))
                                        <div class="alert alert-danger">
                                            {{ session('error') }}
                                        </div>
                                    @endif
                                     <form method="POST" class="form-validate"  action="{{ route('login') }}">
                                        @csrf
                                        <div class="form-head">
                                            <a href="{{url('/')}}" class="logo"><img src="assets/images/smpl-logo.png" class="img-fluid" alt="logo"></a>
                                        </div>
                                        <h4 class="text-primary my-4">Log in !</h4>
                                        <div class="form-group">
                                            <input id="val-email" type="email" class="form-control @error('email') is-invalid @enderror" name="email" value="{{ old('email') }}" placeholder="Enter email here" autocomplete="email" autofocus>

                                            @error('email')
                                                <span class="invalid-feedback" role="alert">
                                                    <strong>{{ $message }}</strong>
                                                </span>
                                            @enderror
                                        </div>
                                        <div class="form-group">
                                            <input id="val-password" type="password" class="form-control @error('password') is-invalid @enderror" name="password" placeholder="Enter password here" autocomplete="current-password">

                                            @error('password')
                                                <span class="invalid-feedback" role="alert">
                                                    <strong>{{ $message }}</strong>
                                                </span>
                                            @enderror
                                        </div>
                                        <div class="form-row mb-3">
                                            <!-- <div class="col-sm-6">
                                                <div class="custom-control custom-checkbox text-left">
                                                    <input class="custom-control-input" type="checkbox" name="remember" id="remember" {{ old('remember') ? 'checked' : '' }}>
                                                  <label class="custom-control-label font-14" for="remember">Remember Me</label>
                                                </div>
                                            </div> -->
                                            {{-- <div class="col-sm-6">
                                              <div class="forgot-psw">
                                                @if (Route::has('password.request'))
                                                    <a id="forgot-psw" class="font-14" href="{{ route('password.request') }}">
                                                        {{ __('Forgot Your Password?') }}
                                                    </a>
                                                @endif
                                              </div>
                                            </div> --}}
                                        </div>
                                      <button type="submit" class="btn btn-success btn-lg btn-block font-18">Log in</button>
                                    </form>
                                    {{-- <div class="login-or">
                                        <h6 class="text-muted">OR</h6>
                                    </div>
                                    <p class="mb-0 mt-3">Don't have a account? <a href="{{url('/register')}}">Sign up</a></p> --}}
                                </div>
                            </div>
                        </div>
                        <!-- End Auth Box -->
                    </div>
                    <!-- End col -->
                </div>
                <!-- End row -->
            </div>
        </div>
        <!-- End Container -->
    </div>
    <!-- End Containerbar -->
    <!-- Start JS -->
    <script src="{{ asset('assets/js/jquery.min.js') }}"></script>
    <script src="{{ asset('assets/js/popper.min.js') }}"></script>
    <script src="{{ asset('assets/js/bootstrap.min.js') }}"></script>
    <script src="{{ asset('assets/js/modernizr.min.js') }}"></script>
    <script src="{{ asset('assets/js/detect.js') }}"></script>
    <script src="{{ asset('assets/js/jquery.slimscroll.js') }}"></script>
    <!-- Parsley js -->
    <script src="{{ asset('assets/plugins/validatejs/validate.min.js') }}"></script>
    <!-- Validate js -->
    <script src="{{ asset('assets/js/custom/custom-validate.js') }}"></script>
    <script src="{{ asset('assets/js/custom/custom-form-validation.js') }}"></script>
    <!-- End js -->
</body>
</html>
