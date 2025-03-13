@section('title')
    User List
@endsection
@extends('layouts.main')

@section('style')
    <!-- Sweet Alert css -->
    <link href="{{ asset('assets/plugins/sweet-alert2/sweetalert2.min.css') }}" rel="stylesheet" type="text/css" />
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
                        <li class="breadcrumb-item"><a href="{{ url('/') }}">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">@yield('title')</li>
                    </ol>
                </div>
            </div>
            <div class="col-md-4 col-lg-4">
                <div class="widgetbar">
                    @can('user-create')
                        <a href="{{ route('users.create', ['redirect' => urlencode(url()->full())]) }}" class="btn btn-primary-rgba"><i
                                class="feather icon-plus mr-2"></i>Add New User</a>
                    @endcan
                </div>
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
                <div id="message"></div>
                <!-- @if ($message = Session::get('success'))
    -->
                <div class="alert alert-success alert-dismissible fade show m-0 mt-3" role="alert">
                    {{ $message }}
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <!--
    @endif -->

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
            <div class="col-lg-12">
                <div class="card m-b-30">
                    <div class="card-header">
                        <div class="row align-items-center">
                            <div class="col-6">
                                <h5 class="card-title mb-0">All Users</h5>
                            </div>
                            <div class="col-6 d-flex justify-content-end">
                              <meta name="csrf-token" content="{{ csrf_token() }}">
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            {!! $dataTable->table(['class' => 'display table table-striped table-bordered']) !!}
                        </div>
                    </div>
                </div>
            </div>
            <!-- End col -->
        </div>
        <!-- End row -->
        <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModal" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Are You Sure to Delete User</h5>
                </div>
                <div class="modal-body">
                    Are you sure you want to delete <strong><span class="item-name"></span></strong>?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary close-modal">No</button>
                    <button type="button" class="btn btn-outline-danger confirm-delete">Yes</button>
                </div>
            </div>
        </div>
    </div>


    <!-- End Contentbar -->
@endsection
@section('script')
    <script src="{{ asset('assets/plugins/sweet-alert2/sweetalert2.min.js') }}"></script>
    <script src="{{ asset('assets/js/custom/custom-sweet-alert.js') }}"></script>
    <script src="{{ asset('vendor/datatables/buttons.server-side.js') }}"></script>
    {{ $dataTable->scripts() }}
    <script src="{{ asset('assets/plugins/datatables/jquery.dataTables.min.js') }}"></script>
    <script src="{{ asset('assets/plugins/datatables/dataTables.bootstrap4.min.js') }}"></script>
    <script>
    $(document).ready(function() {
        let userId;
        let userName;

        function closeModal() {
            $('#deleteModal').modal('hide');
        }

        $(document).on('click', '.delete-user', function(e) {
            e.preventDefault();
            userId = $(this).data('id');
            userName = $(this).data('name');
            $('.item-name').html(userName);
            $('#deleteModal').modal('show');
        });

        $(document).on('click', '.close-modal', function() {
            closeModal();
        });

        $(document).on('click', '.confirm-delete', function() {
            deleteUser();
        });

        function deleteUser() {
            const token = $('meta[name="csrf-token"]').attr('content');
            let dataTable = $('#users-table').DataTable();
            let currentPage = dataTable.page(); // Get current page before deletion
            let totalRecords = dataTable.page.info().recordsTotal; // Get total records

            $.ajax({
                url: "/users/" + userId,
                method: 'DELETE',
                data: {
                    "_token": token,
                },
                success: function(response) {
                    closeModal(); 
                    handleResponse(response);

                    let remainingRecords = totalRecords - 1; // Reduce record count by 1 after deletion
                    let totalPages = Math.ceil(remainingRecords / dataTable.page.len()); // Total pages after deletion

                    if (remainingRecords > 0) {
                        if (currentPage + 1 > totalPages) {
                            dataTable.page('previous').draw('page'); // Move to previous page if the last item on a page was deleted
                        } else {
                            dataTable.ajax.reload(null, false); // Reload the data while keeping the current page
                        }
                    } else {
                        window.location.reload(); // If no data left, reload the entire page
                    }
                },
                error: function(xhr) {
                    closeModal();
                    handleResponse({ error: xhr.responseJSON?.error || 'An unexpected error occurred.' });
                }
            });
        }

        function handleResponse(response) {
            let alertClass = response.error ? 'alert-danger' : 'alert-success';
            let message = response.error || response.success;
            $('#message').html(
                `<div class="alert ${alertClass} alert-dismissible fade show m-0 mt-3" role="alert">
                    ${message}
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>`
            );
        }
    });
    </script>
@endsection
