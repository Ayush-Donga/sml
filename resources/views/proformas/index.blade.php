@section('title')
    Proforma List
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
    <style>
        .logistic {
            background: #a4c2f4;
        }
        .bd-department {
            background: #ead1dc;
        }
        .purchase {
            background: #fce5cd;
        }
        .where-house {
            background: #cfe2f3;
        }
        .billing {
            background: #e6b8af;
        }
        .where-house-packing-list {
            background: #cfe2f3;
        }
    </style>
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
                    @can('proforma-create')
                        <a href="{{ route('proformas.create') }}" class="btn btn-primary-rgba"><i
                                class="feather icon-plus mr-2"></i>Add New proforma</a>
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
                 @php
                if (isset($_GET['success'])) {
                    $successMessage = $_GET['success'];
                    echo "<div class='alert alert-success alert-dismissible fade show m-0 mt-3' role='alert'>{$successMessage}<button type='button' class='close' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button></div>";
                }
                @endphp
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
                                <h5 class="card-title mb-0">All Proformas</h5>
                            </div>
                            <div class="col-6 d-flex justify-content-end">
                           
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                    {{-- Filter Form --}}
                     <form id="monthForm" action="{{ route('proformas.index') }}" method="GET" class="mt-3">
                        <div class="d-flex justify-content-center align-items-center">
                            <!-- Previous month button -->
                            <button type="button" id="prevMonth" class="btn btn-primary mr-2">
                                <i class="feather icon-arrow-left"></i>
                            </button>

                            <!-- Month input -->
                            <div>
                                <input type="month" id="monthInput" name="month" class="form-control text-capitalize" value="{{ old('month', $month) }}">
                            </div>

                            <!-- Next month button -->
                            <button type="button" id="nextMonth" class="btn btn-primary ml-2">
                                <i class="feather icon-arrow-right"></i>
                            </button>
                        </div>
                       
                    </form>
                    <br>
                   
                    <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead class="text-center">
                                    <tr>
                                        <th colspan="6" class="font-weight-bold logistic text-nowrap">Proforma Invoice</th>
                                        <th colspan="8" class="font-weight-bold bd-department text-nowrap">BD Department</th>
                                    </tr>
                                </thead>
                                <thead class="text-center">
                                    <tr>
                                        <th class="font-weight-bold text-nowrap">Invoice Date</th>
                                        <th class="font-weight-bold text-nowrap">Invoice No</th>
                                        <th class="font-weight-bold text-nowrap">Bill To</th>
                                        <th class="font-weight-bold text-nowrap">Ship To</th>
                                        <th class="font-weight-bold text-nowrap">Created By</th>
                                        <th class="font-weight-bold text-nowrap">Edit</th>
                                        <th class="font-weight-bold text-nowrap">Country</th>
                                        <th class="font-weight-bold text-nowrap">Currency </th>
                                        <th class="font-weight-bold text-nowrap">Product Description</th>
                                        <th class="font-weight-bold text-nowrap">Pack Size</th>
                                        <th class="font-weight-bold text-nowrap">Pack Quantity</th>
                                        <th class="font-weight-bold text-nowrap">Price Per Set</th>
                                        <th class="font-weight-bold text-nowrap">Total</th>
                                        <th class="font-weight-bold text-nowrap">Action</th>
                                    </tr>
                                </thead>
                                <tbody class="text-center">
                                    @foreach($proformas as $proforma)
                                        @php
                                            $numProducts = $proforma->proformaProducts->count();
                                            $isShowBd = proformaBDIssueCheck($proforma);
                                            $totalValue = calculateProformaBdTotalValue($proforma);
                                        @endphp
                                    <tr>
                                        <td rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" class="font-weight-normal text-nowrap">
                                            {{ $proforma->invoice_date ? \Carbon\Carbon::parse($proforma->invoice_date)->format('d-m-Y') : '' }}
                                        </td>
                                        <td rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" class="font-weight-normal text-nowrap">{{ $proforma->invoice_no }}</td>
                                        <td rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" class="font-weight-normal text-nowrap">
                                            <span class="default-info">
                                                @if($proforma->bill_to_customer_id != null)
                                                    {{ $proforma->bill_to_client_code }} / {{ $proforma->bill_to_company_name }}, 
                                                @endif
                                            </span>
                                            <span class="toggle-arrow">▼</span><br>
                                            <span class="additional-info" style="display: none;">
                                                @if($proforma->bill_to_customer_id != null)
                                                    <span>{{ $proforma->bill_to_address }}, {{ $proforma->bill_to_zip_code }}</span><br>
                                                    <span><strong>Registration No:</strong> {{ $proforma->bill_to_registration_no }}</span><br>
                                                    <span>{{ $proforma->bill_to_email }}, {{ $proforma->bill_to_phone_no }}</span>
                                                @endif
                                            </span>
                                        </td>
                                        <td rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" class="font-weight-normal text-nowrap">
                                            <span class="default-info">
                                                @if($proforma->ship_to_customer_id != null)                                
                                               {{ $proforma->ship_to_client_code }} / {{ $proforma->ship_to_company_name }}
                                                @endif
                                            </span>
                                            <span class="toggle-arrow">▼</span><br>
                                            <span class="additional-info" style="display: none;">
                                                @if($proforma->ship_to_customer_id != null)                                
                                                    <span>{{ $proforma->ship_to_address }}, {{ $proforma->ship_to_zip_code }}</span><br>
                                                    <span><strong>Registration No:</strong> {{ $proforma->ship_to_registration_no }}</span><br>
                                                    <span>{{ $proforma->ship_to_email }}, {{ $proforma->ship_to_phone_no }}</span><br>
                                                @endif
                                            </span>
                                        </td>
                                        <td rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" class="font-weight-normal text-nowrap">
                                             {{ $users->firstWhere('id', $proforma->created_by)->name ?? '' }}
                                        </td>
                                        <td rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" class="font-weight-normal text-nowrap">
                                            @can('proforma-edit')
                                                @if($proforma->status !== 'completed')
                                                    <a href="{{ route('proformas.edit', ['proforma' => $proforma->id, 'redirect' => urlencode(url()->full())]) }}" class="btn btn-success-rgba">
                                                            <i class="feather icon-edit-2"></i>
                                                    </a>
                                                @endif
                                            @endcan
                                        </td>
                                        <td rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" class="font-weight-normal text-nowrap">{{ $proforma->country }}</td>
                                        <td rowspan="{{ $numProducts > 0 ? $numProducts : 1 }}" class="font-weight-normal text-nowrap">{{ $proforma->currency }}</td>
                                        @if($numProducts > 0)
                                            @foreach($proforma->proformaProducts as $productIndex => $proformaProduct)
                                                    @php
                                                        $productDes = '';
                                                        $productVariantName = '';
                                                        if ($proformaProduct->product_id == $proformaProduct->products->id) {
                                                            $productDes = $proformaProduct->products->name;
                                                        }
                                                        if ($proformaProduct->product_variant_id == $proformaProduct->productVariants->id) {
                                                            $productVariantName = $proformaProduct->productVariants->name;
                                                        }
                                                    @endphp
                                        <td class="font-weight-normal text-nowrap">{{ $productDes }}</td>
                                        <td class="font-weight-normal text-nowrap">{{ $productVariantName }}</td>
                                        <td class="font-weight-normal text-nowrap">{{ $proformaProduct->quantity }}</td>
                                        <td class="font-weight-normal text-nowrap">{{ format_currency($proformaProduct->price_per_set) }}</td>
                                        <td class="font-weight-normal text-nowrap">{{ format_currency($proformaProduct->total) }}</td>
                                        @if($productIndex === 0)
                                            <td rowspan="{{ $numProducts }}" class="font-weight-normal text-nowrap">
                                                @if ($isShowBd === true)
                                                    <a href="{{ route('pdf.proformaInvoice', $proforma->id) }}" class="btn btn-primary-rgba"><i class="feather icon-download"></i></a>
                                                @endif
                                                @if($proforma->status !== 'completed')
                                                    @can('proforma-edit')
                                                        <a href="{{ route('proformaProducts.edit', ['proformaProduct' => $proforma->id, 'redirect' => urlencode(url()->full())]) }}" class="btn btn-success-rgba">
                                                            <i class="feather icon-edit-2"></i>
                                                        </a>
                                                    @endcan
                                                    @can('proforma-delete')
                                                        <button type="button" data-proforma-id="{{ $proforma->id }}" data-redirect-url="{{ request('redirect') ?? url()->full() }}" class="btn btn-danger-rgba deleteProforma"><i class="feather icon-trash"></i></button>
                                                    @endcan
                                                    @canany(['proforma-edit', 'proforma-create'])
                                                        @if ($isShowBd)
                                                            <button type="button" 
                                                                    data-proformaid="{{ $proforma->id }}" 
                                                                    data-serve-month="{{ $proforma->serve_date }}" 
                                                                    class="btn btn-success-rgba convertOrder">
                                                                Order
                                                            </button>
                                                        @endif
                                                    @endcanany
                                                @endif
                                            </td>
                                        @endif
                                    </tr>
                                          <!-- Additional rows for shipping, soft boxes, data logger, clearance, and total -->
                                          @if($loop->last)
                                                    @include('partials.proforma_additional_rows', ['proforma' => $proforma, 'totalValue' => $totalValue])
                                          @endif                
                                         @endforeach
                                         @else
                                            <td class="font-weight-normal"></td>
                                            <td class="font-weight-normal"></td>
                                            <td class="font-weight-normal"></td>
                                            <td class="font-weight-normal"></td>
                                            <td class="font-weight-normal"></td>
                                            <td rowspan="1" class="font-weight-normal">
                                                @if ($isShowBd === true)
                                                    <a href="{{ route('pdf.proformaInvoice', $proforma->id) }}" class="btn btn-primary-rgba"><i class="feather icon-download"></i></a>
                                                @endif
                                                @if($proforma->status !== 'completed')
                                                    @can('proforma-edit')
                                                        <a href="{{ route('proformaProducts.edit', ['proformaProduct' => $proforma->id, 'redirect' => urlencode(url()->full())]) }}" class="btn btn-success-rgba">
                                                            <i class="feather icon-edit-2"></i>
                                                        </a>
                                                    @endcan
                                                    @can('proforma-delete')
                                                        <button type="button" data-proforma-id="{{ $proforma->id }}" data-redirect-url="{{ request('redirect') ?? url()->full() }}" class="btn btn-danger-rgba deleteProforma"><i class="feather icon-trash"></i></button>
                                                    @endcan
                                                    @canany(['proforma-edit', 'proforma-create'])
                                                        @if ($isShowBd)
                                                            <button type="button" 
                                                                    data-proformaid="{{ $proforma->id }}" 
                                                                    data-serve-month="{{ $proforma->serve_date }}" 
                                                                    class="btn btn-success-rgba convertOrder">
                                                                Order
                                                            </button>
                                                        @endif
                                                    @endcanany
                                                @endif
                                            <d> 
                                         @endif
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End col -->
        </div>
        <!-- End row -->

<!-- Proforma delete model -->
<div class="modal fade" id="deleteProformaModal" tabindex="-1" aria-labelledby="deleteProformaModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Proforma delete confirmation</h5>
            </div>
            <div class="modal-body">
                Are you sure you want to delete?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-primary" data-dismiss="modal">No</button>
                <button type="button" class="btn btn-outline-danger confirm-delete">yes</button>
            </div>
        </div>
    </div>
</div>
<!-- End Proforma delete model -->

<!-- Proforma to order convert model -->
<div class="modal fade" id="proformaToOrderModal" tabindex="-1" aria-labelledby="proformaToOrderModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Proforma To Convert Order</h5>
            </div>
            <div class="modal-body">
                <meta name="csrf-token" content="{{ csrf_token() }}">
                <div class="form-group">
                    <label for="serveMonthInput">Serve Month</label>
                    <input type="month" class="form-control serve-month" id="serveMonthInput" min="{{ date('Y-m') }}">
                    <div id="serveMonthError" class="text-danger mt-2" style="display: none;">Serve Month is required.</div>
                    <div id="serveMonthPastError" class="text-danger mt-2" style="display: none;">Past months are not allowed.</div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-primary" data-dismiss="modal">No</button>
                <button type="button" class="btn btn-outline-danger confirm-order">Yes</button>
            </div>
        </div>
    </div>
</div>
<!-- End Proforma to order convert model -->
        
    <!-- End Contentbar -->
@endsection
@section('script')
    <!-- Sweet-Alert js -->
    <script src="{{ asset('assets/plugins/sweet-alert2/sweetalert2.min.js') }}"></script>
    <script src="{{ asset('assets/js/custom/custom-sweet-alert.js') }}"></script>

<!-- DataTables js -->
<script src="{{ asset('assets/plugins/datatables/jquery.dataTables.min.js') }}"></script>
<script src="{{ asset('assets/plugins/datatables/dataTables.bootstrap4.min.js') }}"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Get references to elements
        const monthForm = document.getElementById('monthForm');
        const monthInput = document.getElementById('monthInput');
        const prevButton = document.getElementById('prevMonth');
        const nextButton = document.getElementById('nextMonth');

        // Function to handle previous button click
        prevButton.addEventListener('click', function() {
            const currentDate = new Date(monthInput.value + '-01');
            currentDate.setMonth(currentDate.getMonth() - 1);
            monthInput.value = currentDate.toISOString().slice(0, 7);
            monthForm.submit();
        });

        // Function to handle next button click
        nextButton.addEventListener('click', function() {
            const currentDate = new Date(monthInput.value + '-01');
            currentDate.setMonth(currentDate.getMonth() + 1);
            monthInput.value = currentDate.toISOString().slice(0, 7);
            monthForm.submit();
        });

        // Function to handle month input change
        monthInput.addEventListener('change', function() {
            monthForm.submit();
        });
    });
</script>
<script>
$(document).ready(function() {
    $('.deleteProforma').click(function() {
        var proformaId = $(this).data('proforma-id');
        var redirectUrl = $(this).data('redirect-url'); // Get our redirect URL here
       
        $('#deleteProformaModal').modal('show');
        
        // Moved the click event listener for confirmation button outside the main click event
        $('.confirm-delete').off('click').on('click', function() {
            // Perform AJAX request to delete the product
            $.ajax({
                url: '/proformas/' + proformaId,
                type: 'DELETE',
                data: {
                    _token: '{{ csrf_token() }}' // Include CSRF token
                },
                success: function(result) {
                    if (result.error) {
                        $('#message').html(
                            '<div class="alert alert-danger alert-dismissible fade show m-0 mt-3" role="alert">' +
                                result.error +
                                '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                                    '<span aria-hidden="true">&times;</span>' +
                                '</button>' +
                            '</div>'
                        );
                    } else if (result.message) {
                        $('#message').html(
                            '<div class="alert alert-success alert-dismissible fade show m-0 mt-3" role="alert">' +
                                result.message +
                                '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                                    '<span aria-hidden="true">&times;</span>' +
                                '</button>' +
                            '</div>'
                        );
                    }
                    
                    // Redirect after 2.5 seconds to our dynamic redirectUrl
                    setTimeout(function() {
                        window.location.href = redirectUrl;
                    }, 2500);
                },
                error: function(xhr, status, error) {
                    // Handle errors
                    console.error(xhr.responseText);
                    alert('Error deleting order.'); // Display error message
                }
            });
            $('#deleteProformaModal').modal('hide');
        });
    });
    
    $('.convertOrder').click(function() {
    var proformaId = $(this).data('proformaid');
    var serveMonth = $(this).data('serve-month');
    $('.serve-month').val(serveMonth);

    $('#proformaToOrderModal').modal('show');

    $('.confirm-order').off('click').on('click', function() {
        var selectedMonth = $('#serveMonthInput').val();
        var csrfToken = $('meta[name="csrf-token"]').attr('content');
        var $confirmButton = $(this);

        var currentDate = new Date();
        var currentYearMonth = currentDate.getFullYear() + '-' + String(currentDate.getMonth() + 1).padStart(2, '0');

        if (!selectedMonth) {
            $('#serveMonthError').show();
            $('#serveMonthPastError').hide();
            return;
        } else if (selectedMonth < currentYearMonth) {
            $('#serveMonthPastError').show();
            $('#serveMonthError').hide();
            return;
        } else {
            $('#serveMonthError').hide();
            $('#serveMonthPastError').hide();
        }

        // Disable the button to prevent multiple clicks
        $confirmButton.prop('disabled', true);

        $.ajax({
            url: '/proformaToOrder',
            type: 'POST',
            data: {
                proformaId: proformaId,
                month: selectedMonth,
                _token: csrfToken
            },
            success: function(result) {
                $('#proformaToOrderModal').modal('hide');
                if (result.error) {
                    $('#message').html(
                        '<div class="alert alert-danger alert-dismissible fade show m-0 mt-3" role="alert">' +
                            result.error +
                            '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                                '<span aria-hidden="true">&times;</span>' +
                            '</button>' +
                        '</div>'
                    );
                } else if (result.message) {
                    $('#message').html(
                        '<div class="alert alert-success alert-dismissible fade show m-0 mt-3" role="alert">' +
                            result.message +
                            '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                                '<span aria-hidden="true">&times;</span>' +
                            '</button>' +
                        '</div>'
                    );
                }

                setTimeout(function() {
                    window.location.href = result.redirect;
                }, 2500);
            },
            error: function(xhr, status, error) {
                console.error(xhr.responseText);
                // Re-enable the button if there's an error
                $confirmButton.prop('disabled', false);
            }
        });
    });
});
});

$(document).ready(function(){
    $(".toggle-arrow").click(function(){
        $(this).siblings(".additional-info").toggle();
    });
});
</script>
@endsection
