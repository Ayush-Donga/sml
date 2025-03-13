@section('title')
    Dashboard
@endsection

@extends('layouts.main')

@section('style')
    <link href="{{ asset('assets/plugins/select2/select2.min.css') }}" rel="stylesheet" type="text/css" />
    <!-- Tagsinput css -->
    <link href="{{ asset('assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput.css') }}" rel="stylesheet" type="text/css" />
    <link href="{{ asset('assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput-typeahead.css') }}" rel="stylesheet"
        type="text/css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/5.2.7/css/fileinput.min.css" media="all"
        rel="stylesheet" type="text/css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" media="all" rel="stylesheet"
        type="text/css" />
    <!-- Datepicker css -->
    <link href="{{ asset('assets/plugins/datepicker/datepicker.min.css') }}" rel="stylesheet" type="text/css">
    <!-- DataTables css -->
    <link href="{{ asset('assets/plugins/datatables/dataTables.bootstrap4.min.css') }}" rel="stylesheet" type="text/css" />
    <link href="{{ asset('assets/plugins/datatables/buttons.bootstrap4.min.css') }}" rel="stylesheet" type="text/css" />
    <!-- Responsive Datatable css -->
    <link href="{{ asset('assets/plugins/datatables/responsive.bootstrap4.min.css') }}" rel="stylesheet" type="text/css" />
@endsection

@section('breadcrumbbar')
    <!-- Start Breadcrumbbar -->
    <div class="breadcrumbbar">
        <div class="row align-items-center">
            <div class="col-md-8 col-lg-8">
                <h4 class="page-title">@yield('title')</h4>
                <div class="breadcrumb-list">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="{{ url('/') }}">@yield('title')</a></li>
                    </ol>
                </div>
            </div>
           
        </div>
    </div>
    <!-- End Breadcrumbbar -->
@endsection


@section('rightbar-content')
    
@endsection
@section('script')
    <script src="https://cdn.onesignal.com/sdks/web/v16/OneSignalSDK.page.js" defer></script>
    <script>
        window.OneSignalDeferred = window.OneSignalDeferred || [];
        window.OneSignalDeferred.push(async function (OneSignal) {
            await OneSignal.init({
                appId: "{{ config('services.onesignal.app_id') }}",
            });
            
            if (OneSignal) {
                const player_id = OneSignal.User.PushSubscription.id;
                const user_id = '{{ auth()->user()->id }}';

                // Send Subscription Token to Laravel Backend if player_id and user_id are present
                if (player_id && user_id) {
                    fetch('/user-device-token', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            'X-CSRF-TOKEN': '{{ csrf_token() }}',
                        },
                        body: JSON.stringify({ 
                            user_id: user_id,
                            player_id: player_id,
                        })
                    })
                    .then(response => response.json())
                    .then(data => {
                        console.log('Subscription Token updated:', data);
                    })
                    .catch(error => {
                        console.error('Error updating Subscription Token:', error);
                    });
                }
            } else {
                console.warn('User is not subscribed.');
            }
        });
    </script>


    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
    <script>
        $(function() {
            $('#DOB').change(function() {
                var date = moment(document.getElementById("DOB").value);
                if (date.isValid()) {
                    var d = new Date(document.getElementById('DOB').value);
                    var year = d.getFullYear();
                    var month = ("0" + (d.getMonth() + 1)).slice(-2);
                    var day = ("0" + d.getDate()).slice(-2);
                    var c = new Date(year + 1, month, day)
                    $('input[name="expiry_date"]').val([c.getFullYear(), month, day].join("-"));
                }   
            });

        });

        $(document).ready(function() {
            // $('.customdata').click(function() {
            //     $('.nav-item a.active').removeClass('active');
            //     $('.customTable').addClass('show active');
            // });
        });
    </script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/5.2.7/js/fileinput.min.js"
        type="text/javascript"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/5.2.7/themes/fa/theme.min.js"
        type="text/javascript"></script>

    <!-- Custom Switchery js -->
    <script src="{{ asset('assets/js/custom/custom-switchery.js') }}"></script>
    <!-- Select2 js -->
    <script src="{{ asset('assets/plugins/select2/select2.min.js') }}"></script>
    <!-- Tagsinput js -->
    <script src="{{ asset('assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput.min.js') }}"></script>
    <script src="{{ asset('assets/plugins/bootstrap-tagsinput/typeahead.bundle.js') }}"></script>
    <script src="{{ asset('assets/js/custom/custom-form-select.js') }}"></script>


@endsection