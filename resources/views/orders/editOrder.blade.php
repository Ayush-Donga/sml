@section('title')
Edit Order
@endsection
@extends('layouts.main')
@section('style')
<!-- Select2 css -->
<link href="{{ asset('assets/plugins/select2/select2.min.css') }}" rel="stylesheet" type="text/css" />
<!-- Tagsinput css -->
<link href="{{ asset('assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput.css') }}" rel="stylesheet"
    type="text/css" />
<link href="{{ asset('assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput-typeahead.css') }}" rel="stylesheet"
    type="text/css" />
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
                    <li class="breadcrumb-item"><a href="{{url('/orders')}}">Orders</a></li>
                    <li class="breadcrumb-item active" aria-current="page">@yield('title')</li>
                </ol>
            </div>
        </div>
        <div class="col-md-4 col-lg-4">
            <div class="widgetbar">
                <a href="{{ urldecode($redirectUrl) }}" class="btn btn-primary-rgba"><i
                        class="ti-arrow-left mr-2"></i>Back</a>
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
        <!-- Start col -->
        <div class="col-lg-12">
            <div class="card m-b-30">
                <div class="card-header">
                    <h5 class="card-title">Edit Order</h5>
                </div>
                <div class="card-body">
                    <form method="post" action="{{ route('orders.updateOrder', $order->id) }}">
                        @method('PATCH')
                        @csrf
                        <input type="hidden" name="redirect" value="{{ urlencode($redirectUrl) }}">
                        <div class="form-group">
                            <label for="exampleInputEmail1">Bill To<span class="text-danger">*</span></label>
                            <select class="form-control select2 bill-to" name="bill_to_customer_id" id="bill_to_id"
                                placeholder="Please Select Bill To">
                                <option value="">Select</option>
                                @foreach($customers as $customer)
                                    @php
                                        $isSelected = ($customer->id == $order->bill_to_customer_id) ? 'selected' : '';
                                    @endphp
                                    <option value="{{ $customer->id }}" {{$isSelected}}>
                                        {{ $customer->client_code }} / {{ $customer->company_name }}
                                    </option>
                                @endforeach
                            </select>
                            @error('bill_to_customer_id')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div id="bill_to_details">
                            <!-- Display selected bill to details here -->
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Ship To<span class="text-danger">*</span></label>
                            <select class="form-control select2 ship-to" name="ship_to_customer_id" id="ship_to_id"
                                placeholder="Please Select Ship To">
                                <option value="">Select</option>
                                @foreach($parents as $parent)
                                    @if($order->bill_to_customer_id == $parent->parent_id)
                                        @php
                                            $isSelected = ($parent->id == $order->ship_to_customer_id) ? 'selected' : '';
                                        @endphp
                                        <option value="{{ $parent->id }}" {{$isSelected}}>
                                            {{ $parent->client_code }} / {{ $parent->company_name }}
                                        </option>
                                    @endif
                                @endforeach
                            </select>
                            @error('ship_to_customer_id')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div id="ship_to_details">
                            <!-- Display selected ship to details here -->
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Country<span class="text-danger">*</span></label>
                            <input type="text" name="country" 
                                value="{{ old('country', $order->country) ?? ''}}" 
                                class="form-control @error('country') is-invalid @enderror" 
                                aria-describedby="country" placeholder="Enter Your Country" required>
                            @error('country')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Serve Date<span class="text-danger">*</span></label>
                            <input type="month" name="serve_date" 
                                value="{{ old('serve_date', $order->serve_date) ?? ''}}" 
                                class="form-control" required>
                            @error('serve_date')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Invoice Date</label>
                            <input type="date" name="invoice_date" value="{{ old('invoice_date', $order->invoice_date) ?? '' }}"
                                class="form-control" aria-describedby="Name" placeholder="Enter Invoice Date">
                            @error('invoice_date')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">PI No</label>
                            <input type="text" name="pi_number" 
                            value="{{ old('pi_number', $order->pi_number) ?? ''}}" 
                            class="form-control" aria-describedby="Name" placeholder="Enter PI No">
                            @error('pi_number')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="payment_terms">Payment Terms</label>
                            <select class="form-control select2-payment-terms @error('payment_terms') is-invalid @enderror"
                                name="payment_terms" id="payment_terms" placeholder="Please Select Payment Terms">
                                <option value="">Select</option>
                                <option value="50% ADVANCE 50% BEFORE DELIVERY" {{ $order->payment_terms == '50% ADVANCE 50% BEFORE DELIVERY' ? 'selected' : '' }}>50% ADVANCE 50% BEFORE DELIVERY</option>
                                <option value="75% ADVANCE 25% BEFORE DELIVERY" {{ $order->payment_terms == '75% ADVANCE 25% BEFORE DELIVERY' ? 'selected' : '' }}>75% ADVANCE 25% BEFORE DELIVERY</option>
                                <option value="100% ADVANCE BEFORE DELIVERY" {{ $order->payment_terms == '100% ADVANCE BEFORE DELIVERY' ? 'selected' : '' }}>100% ADVANCE BEFORE DELIVERY</option>
                            </select>
                            @error('payment_terms')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Delivery By</label>
                            <input type="text" name="delivery_by" value="{{ old('delivery_by', $order->delivery_by) ?? ''}}"
                                class="form-control @error('delivery_by') is-invalid @enderror"
                                aria-describedby="delivery_by" placeholder="Enter Delivery By">
                            @error('delivery_by')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Delivery Time</label>
                            <input type="text" name="delivery_time" value="{{ old('delivery_time', $order->delivery_time) ?? ''}}"
                                class="form-control @error('delivery_time') is-invalid @enderror"
                                aria-describedby="delivery_time" placeholder="Enter Delivery Time">
                            @error('delivery_time')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Delivery Terms</label>
                            <input type="text" name="delivery_terms" value="{{ old('delivery_terms', $order->delivery_terms) ?? ''}}"
                                class="form-control @error('delivery_terms') is-invalid @enderror"
                                aria-describedby="delivery_terms" placeholder="Enter Delivery Terms">
                            @error('delivery_terms')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Port Of Discharge</label>
                            <input type="text" name="port_of_discharge" value="{{ old('port_of_discharge', $order->port_of_discharge) ?? ''}}"
                                class="form-control @error('port_of_discharge') is-invalid @enderror"
                                aria-describedby="port_of_discharge" placeholder="Enter Port Of Discharge">
                            @error('port_of_discharge')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="mt-3">
                            <button type="submit" class="btn btn-primary-rgba mr-3">Save</button>
                            <a href="{{ urldecode($redirectUrl) }}" class="btn btn-danger-rgba btn-cancel">
                                Cancel
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- End col -->
    </div> <!-- End row -->
</div>

<!-- End Contentbar -->
@endsection
@section('script')
<!-- Custom Switchery js -->
<script src="{{ asset('assets/js/custom/custom-switchery.js') }}"></script>
<!-- Select2 js -->
<script src="{{ asset('assets/plugins/select2/select2.min.js') }}"></script>
<!-- Tagsinput js -->
<script src="{{ asset('assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput.min.js') }}"></script>
<script src="{{ asset('assets/plugins/bootstrap-tagsinput/typeahead.bundle.js') }}"></script>
<script src="{{ asset('assets/js/custom/custom-form-select.js') }}"></script>
<!-- Parsley js -->
<script src="{{ asset('assets/plugins/validatejs/validate.min.js') }}"></script>
<!-- Validate js -->
<script src="{{ asset('assets/js/custom/custom-validate.js') }}"></script>
<script src="{{ asset('assets/js/custom/custom-form-validation.js') }}"></script>
<script>
    $(document).ready(function () {
        $('.select2').select2({
            placeholder: function() {
                return $(this).data('placeholder') || "Please Select an Option";
            },
            allowClear: true // Enables clear button
        });
        
        $('.select2-payment-terms').select2({
            placeholder: function() {
                return $(this).data('placeholder') || "Please Select an Option";
            },
            allowClear: true // Enables clear button
        });
    });
</script>
<script type="text/javascript">
    $(document).ready(function () {
        $('#bill_to_id').change(function () {
            let billToId = $(this).val();
            $.ajax({
                url: '/getShipTo',
                type: 'post',
                data: 'billToId=' + billToId + '&_token={{csrf_token()}}',
                success: function (result) {
                    $('#ship_to_id').html(result);
                }
            });
        });
    });
</script>
<script>
    $(document).ready(function () {
        // Function to fetch and display Bill To details
        function fetchBillToDetails(billToId) {
            if (billToId) {
                $.ajax({
                    url: '/getBillTo',
                    type: 'post',
                    data: { billToId: billToId, _token: '{{csrf_token()}}' },
                    success: function (result) {
                        if (result.client_code && result.company_name) {
                            var detailsHtml = '<p class="text-uppercase"><strong>Client Code:</strong> <span>' + result.client_code + '</span><br>' +
                                '<strong>Company Name / Patient Name:</strong> <span>' + result.company_name + '</span><br>' +
                                '<strong>Email:</strong> <span>' + (result.email || '') + '</span><br>' +
                                '<strong>Phone:</strong> <span>' + result.phone_no + '</span><br>' +
                                '<strong>Registration No:</strong> <span>' + (result.registration_no || '') + '</span><br>' +
                                '<strong>Address:</strong> <span>' + result.address + '</span><br>' +
                                '<strong>Zip Code:</strong> <span>' + (result.zip_code || '') + '</span></p>';
                            $('#bill_to_details').html(detailsHtml).show();
                        }
                    }
                });
            }
        }

        // Function to fetch and display Ship To details
        function fetchShipToDetails(shipToId) {
            if (shipToId) {
                $.ajax({
                    url: '/getShipToDetails',
                    type: 'post',
                    data: { shipToId: shipToId, _token: '{{csrf_token()}}' },
                    success: function (result) {
                        if (result.client_code && result.company_name) {
                            var detailsHtml = '<p class="text-uppercase"><strong>Client Code:</strong> <span>' + result.client_code + '</span><br>' +
                                '<strong>Company Name / Patient Name:</strong> <span>' + result.company_name + '</span><br>' +
                                '<strong>Email:</strong> <span>' + (result.email || '') + '</span><br>' +
                                '<strong>Phone:</strong> <span>' + result.phone_no + '</span><br>' +
                                '<strong>Registration No:</strong> <span>' + (result.registration_no || '') + '</span><br>' +
                                '<strong>Address:</strong> <span>' + result.address + '</span><br>' +
                                '<strong>Zip Code:</strong> <span>' + (result.zip_code || '') + '</span></p>';
                            $('#ship_to_details').html(detailsHtml).show();
                        }
                    }
                });
            }
        }

        // Call the functions to load details on page load
        fetchBillToDetails('{{ $order->bill_to_customer_id }}');
        fetchShipToDetails('{{ $order->ship_to_customer_id }}');

        // Attach event listeners for dynamic changes
        $('.bill-to').change(function () {
            let billToId = $(this).val();
            fetchBillToDetails(billToId);
            $('#ship_to_details').hide(); // Clear Ship To details
        });

        $('.ship-to').change(function () {
            let shipToId = $(this).val();
            fetchShipToDetails(shipToId);
        });
    });
</script>
@endsection