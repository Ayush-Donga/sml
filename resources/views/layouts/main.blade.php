<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
        <meta name="csrf-token" content="{{ csrf_token() }}">
        <title> @yield('title') </title>
        <!-- Fevicon -->
        <link rel="shortcut icon" href="{{ asset('assets/images/smpl-logo.png') }}">
        <!-- Start CSS -->
        @yield('style')
        <link href="{{ asset('assets/plugins/switchery/switchery.min.css') }}" rel="stylesheet" type="text/css">
        <link href="{{ asset('assets/css/bootstrap.min.css') }}" rel="stylesheet" type="text/css">
        <link href="{{ asset('assets/css/icons.css') }}" rel="stylesheet" type="text/css">
        <link href="{{ asset('assets/css/flag-icon.min.css') }}" rel="stylesheet" type="text/css">
        <link href="{{ asset('assets/css/style.css') }}" rel="stylesheet" type="text/css">
        <!-- End CSS -->
    </head>
    <body class="vertical-layout">
        <!-- Start Infobar Setting Sidebar -->
        <!-- <div id="infobar-settings-sidebar" class="infobar-settings-sidebar">
            <div class="infobar-settings-sidebar-head d-flex w-100 justify-content-between">
                <h4>Settings</h4><a href="javascript:void(0)" id="infobar-settings-close" class="infobar-settings-close"><img src="{{ asset('assets/images/svg-icon/close.svg') }}" class="img-fluid menu-hamburger-close" alt="close"></a>
            </div>
            <div class="infobar-settings-sidebar-body">
                <div class="custom-mode-setting">
                    <div class="row align-items-center pb-3">
                        <div class="col-8"><h6 class="mb-0">Payment Reminders</h6></div>
                        <div class="col-4 text-right"><input type="checkbox" class="js-switch-setting-first" checked /></div>
                    </div>
                    <div class="row align-items-center pb-3">
                        <div class="col-8"><h6 class="mb-0">Stock Updates</h6></div>
                        <div class="col-4 text-right"><input type="checkbox" class="js-switch-setting-second" checked /></div>
                    </div>
                    <div class="row align-items-center pb-3">
                        <div class="col-8"><h6 class="mb-0">Open for New Products</h6></div>
                        <div class="col-4 text-right"><input type="checkbox" class="js-switch-setting-third" /></div>
                    </div>
                    <div class="row align-items-center pb-3">
                        <div class="col-8"><h6 class="mb-0">Enable SMS</h6></div>
                        <div class="col-4 text-right"><input type="checkbox" class="js-switch-setting-fourth" checked /></div>
                    </div>
                    <div class="row align-items-center pb-3">
                        <div class="col-8"><h6 class="mb-0">Newsletter Subscription</h6></div>
                        <div class="col-4 text-right"><input type="checkbox" class="js-switch-setting-fifth" checked /></div>
                    </div>
                    <div class="row align-items-center pb-3">
                        <div class="col-8"><h6 class="mb-0">Show Map</h6></div>
                        <div class="col-4 text-right"><input type="checkbox" class="js-switch-setting-sixth" /></div>
                    </div>
                    <div class="row align-items-center pb-3">
                        <div class="col-8"><h6 class="mb-0">e-Statement</h6></div>
                        <div class="col-4 text-right"><input type="checkbox" class="js-switch-setting-seventh" checked /></div>
                    </div>
                    <div class="row align-items-center">
                        <div class="col-8"><h6 class="mb-0">Monthly Report</h6></div>
                        <div class="col-4 text-right"><input type="checkbox" class="js-switch-setting-eightth" checked /></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="infobar-settings-sidebar-overlay"></div> -->
        <!-- End Infobar Setting Sidebar -->
        <!-- Start Containerbar -->
        <div id="containerbar">
            <!-- Start Leftbar -->
            @include('layouts.leftbar')
            <!-- End Leftbar -->
            <!-- Start Rightbar -->
            @include('layouts.rightbar')
            @yield('content')
            <!-- End Rightbar -->
        </div>
        <!-- End Containerbar -->
        <!-- Start JS -->
        <script src="{{ asset('assets/js/jquery.min.js') }}"></script>
        <script src="{{ asset('assets/js/popper.min.js') }}"></script>
        <script src="{{ asset('assets/js/bootstrap.min.js') }}"></script>
        <script src="{{ asset('assets/js/modernizr.min.js') }}"></script>
        <script src="{{ asset('assets/js/detect.js') }}"></script>
        {{-- <script src="{{ asset('assets/js/jquery.slimscroll.js') }}"></script> --}}
        <script src="{{ asset('assets/js/vertical-menu.js') }}"></script>
        <script src="{{ asset('assets/plugins/switchery/switchery.min.js') }}"></script>
        @yield('script')
        <!-- Core JS -->
        <script src="{{ asset('assets/js/core.js') }}"></script>
        <script>
            $(document).ready(function() {
                $('.module-switch').on('click', function() {
                    console.log("Module switch clicked, clearing DataTables state...");
                    sessionStorage.setItem('clearDatatableState', 'yes'); // Mark state for clearing
                });

                if (sessionStorage.getItem('clearDatatableState') === 'yes') {
                    sessionStorage.removeItem('clearDatatableState'); // Remove the flag

                    setTimeout(function () {
                        if ($.fn.DataTable.isDataTable('#users-table')) {
                            var table = $('#users-table').DataTable();
                            table.state.clear(); // Clear stored state
                            table.search('').columns().search('').draw(); // Clear all search fields and redraw
                            console.log("Users DataTable state and search cleared.");
                        }

                        if ($.fn.DataTable.isDataTable('#roles-table')) {
                            var table = $('#roles-table').DataTable();
                            table.state.clear();
                            table.search('').columns().search('').draw();
                            console.log("Roles DataTable state and search cleared.");
                        }
                    }, 100); // Add a slight delay to ensure the table is fully initialized before clearing
                }
            });
        </script>
        <!-- End JS -->
    </body>
</html>
