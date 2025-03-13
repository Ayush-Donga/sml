@section('title')
    Venders List
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
                    @can('vender-create')
                        <a href="{{ route('venders.create', ['redirect' => urlencode(url()->full())]) }}" class="btn btn-primary-rgba"><i
                                class="feather icon-plus mr-2"></i>Add New Vender</a>
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
                                <h5 class="card-title mb-0">All Venders</h5>
                            </div>
                            <div class="col-6 d-flex justify-content-end">
        
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <div class="dataTables_wrapper container-fluid dt-bootstrap4 no-footer">
                                <div class="row">
                                    <div class="col-sm-12 col-md-6 d-flex">
                                        <form id="perPageForm" method="GET" action="{{ route('venders.index') }}">
                                            <div class="dataTables_length" id="">
                                                <label style="margin-left: -14px;">
                                                    Show
                                                    <select name="perPage" class="form-control form-control-sm" onchange="this.form.submit()">
                                                        @foreach($perPageOptions as $option)
                                                            <option value="{{ $option }}" {{ $option == $perPage ? 'selected' : '' }}>{{ $option }}
                                                            </option>
                                                        @endforeach
                                                    </select>
                                                    entries
                                                </label>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="col-sm-12 col-md-6 d-flex justify-content-end">
                                        <form id="searchForm" action="{{ route('venders.index') }}" method="GET" class="d-flex align-items-center">
                                                <label style="margin-right: 3px; margin-top: 2px;">Search: </label>
                                                    <input type="search" class="form-control form-control-sm" name="search" id="searchInput" style="margin-right: -15px; margin-top: -8px;">
                                        </form>
                                    </div>
                                </div>
                            </div>
                             <!-- Table to display venders -->
                           <div id="venderTable">
                                @include('venders.partials.vender_table', ['venders' => $venders])
                            </div>
                        </div>
                    </div>
                </div>
            <!-- End col -->
        </div>
        <!-- End row -->
        <!-- Vender delete model -->
        <div class="modal fade" id="deleteVenderModal" tabindex="-1" aria-labelledby="deleteVenderModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteVenderModalLabel">Delete Vender Confirmation</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to delete this vender?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-primary" data-dismiss="modal">No</button>
                        <button type="button" class="btn btn-outline-danger confirm-delete">Yes</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End Contentbar -->
@endsection
@section('script')
    <!-- Sweet-Alert js -->
    <script src="{{ asset('assets/plugins/sweet-alert2/sweetalert2.min.js') }}"></script>
    <script src="{{ asset('assets/js/custom/custom-sweet-alert.js') }}"></script>
    <script src="{{ asset('vendor/datatables/buttons.server-side.js') }}"></script>

    <!-- Datatable js -->
    <script src="{{ asset('assets/plugins/datatables/jquery.dataTables.min.js') }}"></script>
    <script src="{{ asset('assets/plugins/datatables/dataTables.bootstrap4.min.js') }}"></script>
    <script src="{{ asset('assets/plugins/datatables/dataTables.responsive.min.js') }}"></script>
    <script>
        // JavaScript to submit the form when the dropdown value changes
        document.addEventListener('DOMContentLoaded', function () {
            document.querySelector('select[name="perPage"]').addEventListener('change', function () {
                this.closest('form').submit();
            });
        });
    </script>
    <script>
        $(document).ready(function() {
            // Set up CSRF token for all AJAX requests
            $.ajaxSetup({
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                }
            });

            let venderId = null; // Store vender ID for deletion

            // Open delete confirmation modal
            $(document).on('click', '.deleteVender', function() {
                venderId = $(this).data('vender-id');
                $('#deleteVenderModal').modal('show');
            });

            // Confirm delete action
            $(document).on('click', '.confirm-delete', function() {
                if (!venderId) return;

                $.ajax({
                    url: '/venders/' + venderId, // Ensure the route is correct
                    type: 'DELETE',
                    success: function(result) {
                        $('#deleteVenderModal').modal('hide'); // Hide modal

                        if (result.error) {
                            showAlert('danger', result.error); // Show error message
                        } else if (result.message) {
                            showAlert('success', result.message); // Show success message
                        }

                        // Reload the page after a short delay
                        setTimeout(function() {
                            window.location.reload();
                        }, 2000);
                    },
                    error: function(xhr) {
                        $('#deleteVenderModal').modal('hide'); // Hide modal on error
                        showAlert('danger', 'Error deleting vender. Please try again.');
                        console.error(xhr.responseText);
                    }
                });
            });

            // Helper function to display alert messages
            function showAlert(type, message) {
                $('#message').html(
                    `<div class="alert alert-${type} alert-dismissible fade show m-0 mt-3" role="alert">
                        ${message}
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>`
                );
            }
        });
    </script>
    <script>
        $(document).ready(function () {
            let currentPage = 1;
            let searchQuery = '';
            let perPage = $('select[name="perPage"]').val();
            let sortBy = 'id';
            let sortOrder = 'desc';

            function loadStateFromUrl() {
                const urlParams = new URLSearchParams(window.location.search);
                if (urlParams.has('page')) {
                    currentPage = parseInt(urlParams.get('page')) || 1;
                }
                if (urlParams.has('search')) {
                    searchQuery = urlParams.get('search');
                    $('#searchInput').val(searchQuery);
                }
                if (urlParams.has('perPage')) {
                    perPage = urlParams.get('perPage');
                    $('select[name="perPage"]').val(perPage);
                }
                if (urlParams.has('sortBy')) {
                    sortBy = urlParams.get('sortBy');
                }
                if (urlParams.has('sortOrder')) {
                    sortOrder = urlParams.get('sortOrder');
                }
            }

            function updateUrl() {
                const urlParams = new URLSearchParams();
                urlParams.set('page', currentPage);
                urlParams.set('perPage', perPage);
                urlParams.set('sortBy', sortBy);
                urlParams.set('sortOrder', sortOrder);
                if (searchQuery.trim().length > 0) {
                    urlParams.set('search', searchQuery);
                }
                const newUrl = window.location.pathname + '?' + urlParams.toString();
                window.history.replaceState({}, '', newUrl);
            }

            function fetchVenders() {
                $.ajax({
                    url: "{{ route('venders.index') }}",
                    method: "GET",
                    data: {
                        search: searchQuery,
                        page: currentPage,
                        perPage: perPage,
                        sortBy: sortBy,
                        sortOrder: sortOrder
                    },
                    success: function (data) {
                        $('#venderTable').html(data);
                        updateUrl();
                        updateSortIcons();
                    },
                    error: function (xhr) {
                        console.error('Error fetching vendors:', xhr.responseText);
                    },
                });
            }

            function updateSortIcons() {
                $('.sort-link').each(function () {
                    const $icon = $(this).find('i');
                    const currentSortBy = $(this).data('sort-by');

                    if (currentSortBy === sortBy) {
                        if (sortOrder === 'asc') {
                            $icon.removeClass().addClass('fas fa-sort-up float-right');
                        } else {
                            $icon.removeClass().addClass('fas fa-sort-down float-right');
                        }
                    } else {
                        $icon.removeClass().addClass('fa fa-sort float-right');
                    }
                });
            }

            loadStateFromUrl();
            fetchVenders();

            $('select[name="perPage"]').on('change', function () {
                perPage = $(this).val();
                fetchVenders();
            });

            $('#searchInput').on('keyup', function () {
                searchQuery = $(this).val();
                fetchVenders();
            });

            // Clear search input and trigger search
                $('#searchInput').on('search', function () {
                if ($(this).val() === '') {
                    searchQuery = '';
                    fetchVenders();
                }
            });

            $(document).on('click', '.pagination a', function (e) {
                e.preventDefault();
                let url = $(this).attr('href');
                let pageMatch = url.match(/page=(\d+)/);
                if (pageMatch) {
                    currentPage = parseInt(pageMatch[1]);
                    fetchVenders();
                }
            });

            $(document).on('click', '.sort-link', function (e) {
                e.preventDefault();
                let newSortBy = $(this).data('sort-by');

                if (sortBy === newSortBy) {
                    sortOrder = sortOrder === 'asc' ? 'desc' : 'asc';
                } else {
                    sortBy = newSortBy;
                    sortOrder = 'asc';
                }

                fetchVenders();
            });
        });
    </script>
@endsection
