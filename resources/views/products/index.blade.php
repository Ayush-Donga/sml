@section('title')
    Products List
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
                    @can('product-create')
                        <a href="{{ route('products.create', ['redirect' => urlencode(url()->full())]) }}" class="btn btn-primary-rgba"><i
                                class="feather icon-plus mr-2"></i>Add New Product</a>
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
                                <h5 class="card-title mb-0">All Products</h5>
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
                                        <form id="perPageForm" method="GET" action="{{ route('products.index') }}">
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
                                        <form id="searchForm" action="{{ route('products.index') }}" method="GET"  class="d-flex align-items-center">
                                                <label style="margin-right: 3px; margin-top: 2px;">Search:</label>
                                                <input type="search" class="form-control form-control-sm" name="search" id="searchInput" style="margin-right: -15px; margin-top: -8px;">
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <!-- Table to display customers -->
                            <div id="productTable">
                                @include('products.partials.product_table', ['products' => $products])
                            </div>
                        </div>
                    </div>
                </div>
            <!-- End col -->
        </div>
        <!-- End row -->
        <!-- Product delete model -->
        <div class="modal fade" id="deleteProductModal" tabindex="-1" aria-labelledby="deleteProductModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteProductModalLabel">Delete Product Confirmation</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to delete this product?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-primary" data-dismiss="modal">No</button>
                        <button type="button" class="btn btn-outline-danger confirm-delete">Yes</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Popup for showing more variant names -->
    <div class="modal fade" id="variantModal" tabindex="-1" role="dialog" aria-labelledby="variantModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="variantModalLabel">More Variant Names</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <ul id="variantList" class="list-group">
                        <!-- Variant names will be displayed here dynamically -->
                    </ul>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">Close</button>
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
    <script>
       function showVariantPopup(productId) {
            // Fetch variant data dynamically after table reloads
            var variants = {!! json_encode($products->pluck('productVariants', 'id')) !!}[productId];

            if (!variants || variants.length === 0) {
                $('#variantList').html('<li class="list-group-item text-danger">No Variants Found</li>');
            } else {
                $('#variantList').html('');
                variants.forEach(function(variant) {
                    $('#variantList').append('<li class="list-group-item">' + variant.name + '</li>');
                });
            }

            $('#variantModal').modal('show'); // Show the modal
        }

        // Use event delegation to handle dynamic elements after AJAX loads
        $(document).on('click', '.variant-btn', function () {
            var productId = $(this).data('product-id'); // Fetch the product ID
            showVariantPopup(productId);
        });
    </script>
    <script>
        // JavaScript to submit the form when the dropdown value changes
        document.addEventListener('DOMContentLoaded', function () {
            document.querySelector('select[name="perPage"]').addEventListener('change', function () {
                this.closest('form').submit();
            });
        });
    </script>
    <script>
    // Delete product functionality
    $(document).on('click', '.deleteProduct', function () {
        var productId = $(this).data('product-id'); // Get the product ID
        $('#deleteProductModal').modal('show'); // Show the confirmation modal

        // Attach the confirm delete functionality
        $('.confirm-delete').off('click').on('click', function () {
            $.ajax({
                url: '/products/' + productId, // Delete endpoint
                type: 'DELETE',
                data: {
                    _token: '{{ csrf_token() }}' // Include the CSRF token
                },
                success: function (result) {
                    // Handle success response
                    if (result.message) {
                        $('#message').html(
                            '<div class="alert alert-success alert-dismissible fade show m-0 mt-3" role="alert">' +
                            result.message +
                            '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                            '<span aria-hidden="true">&times;</span>' +
                            '</button>' +
                            '</div>'
                        );
                    } else if(result.error) {
                        $('#message').html(
                            '<div class="alert alert-danger alert-dismissible fade show m-0 mt-3" role="alert">' +
                            result.error +
                            '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                            '<span aria-hidden="true">&times;</span>' +
                            '</button>' +
                            '</div>'
                        );
                    }
                    setTimeout(function () {
                        window.location.reload(); // Reload the page to reflect changes
                    }, 2000);
                },
                error: function (xhr) {
                    // Handle error response
                    $('#message').html(
                        '<div class="alert alert-danger alert-dismissible fade show m-0 mt-3" role="alert">' +
                        'Error deleting product: ' + xhr.responseJSON.error +
                        '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                        '<span aria-hidden="true">&times;</span>' +
                        '</button>' +
                        '</div>'
                    );
                }
            });

            $('#deleteProductModal').modal('hide'); // Hide the confirmation modal
        });
    });

    // Status toggle functionality
    $(document).ready(function () {
        // Listen for status toggle switch change
        $(document).on('change', '.custom-control-input', function () {
            var productId = $(this).data('product-id'); // Get product ID
            var status = $(this).is(':checked') ? 1 : 0; // Determine new status

            // Send AJAX request
            $.ajax({
                url: '/products/' + productId + '/status',
                type: 'POST', // Laravel expects POST with _method='PUT' for updates
                data: {
                    _token: '{{ csrf_token() }}', // CSRF token
                    status: status,
                    _method: 'PUT' // Specify method override
                },
                success: function (response) {
                    // Show success message
                    $('#message').html(
                        '<div class="alert alert-success alert-dismissible fade show m-0 mt-3" role="alert">' +
                        response.message +
                        '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                        '<span aria-hidden="true">&times;</span>' +
                        '</button>' +
                        '</div>'
                    );
                },
                error: function (xhr) {
                    // Show error message and revert switch state
                    $('#message').html(
                        '<div class="alert alert-danger alert-dismissible fade show m-0 mt-3" role="alert">' +
                        'Error updating status. Please try again.' +
                        '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                        '<span aria-hidden="true">&times;</span>' +
                        '</button>' +
                        '</div>'
                    );
                    $(this).prop('checked', !status); // Revert switch state
                }
            });
        });
    });
</script>
<script>
$(document).ready(function () {
    let currentPage = 1;
    let searchQuery = '';
    let perPage = $('select[name="perPage"]').val();
    let sortBy = 'id'; // Default sort column
    let sortOrder = 'desc'; // Default sort order
    let typingTimer; // Timer for search delay
    let doneTypingInterval = 300; // Delay for search request

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

    function fetchProducts() {
        clearTimeout(typingTimer); // Clear previous timer
        typingTimer = setTimeout(function () { // Add delay for search
            $.ajax({
                url: "{{ route('products.index') }}",
                method: "GET",
                data: {
                    search: searchQuery,
                    page: currentPage,
                    perPage: perPage,
                    sortBy: sortBy,
                    sortOrder: sortOrder
                },
                beforeSend: function () {
                    $('#productTable').fadeTo(100, 0.5); // Smooth fade effect
                },
                success: function (response) {
                    if (response.html) {
                        $('#productTable').html(response.html).fadeTo(100, 1); // Fade-in updated content
                    }
                    updateUrl();
                    updateSortIcons();
                },
                error: function (xhr) {
                    console.error('Error fetching products:', xhr.responseText);
                },
            });
        }, doneTypingInterval);
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
    fetchProducts();

    $('select[name="perPage"]').on('change', function () {
        perPage = $(this).val();
        fetchProducts();
    });

    $('#searchInput').on('keyup', function () {
        searchQuery = $(this).val();
        fetchProducts();
    });

     // Clear search input and trigger search
     $('#searchInput').on('search', function () {
        if ($(this).val() === '') {
            searchQuery = '';
            fetchProducts();
        }
    });

    $(document).on('click', '.pagination a', function (e) {
        e.preventDefault();
        let url = $(this).attr('href');
        let pageMatch = url.match(/page=(\d+)/);
        if (pageMatch) {
            currentPage = parseInt(pageMatch[1]);
            fetchProducts();
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

        fetchProducts();
    });
});
</script>
@endsection
