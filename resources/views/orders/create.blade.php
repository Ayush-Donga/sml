@section('title')
Add New Order
@endsection
@extends('layouts.main')
@section('style')
<style>
    .form-group button, 
    .form-group select {
        height: calc(1.75rem + 0px);
        padding: 0.375rem 0.75rem;
    }
    .form-group {
        margin-bottom: 5px !important; /* Override the margin-bottom */
    }
</style>
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
                <a href="{{ urldecode($redirectUrl) }}" class="btn btn-primary-rgba btn-back">
                    <i class="ti-arrow-left mr-2"></i>Back</a>
                </a>
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
                    <h5 class="card-title">Add New Orders</h5>
                </div>
                <div class="card-body">
                    <form method="POST" action="{{ route('orders.store') }}">
                        @csrf
                        <input type="hidden" name="redirect" value="{{ urlencode($redirectUrl) }}">
                        <div class="form-row">
                            <div class="form-group col-md-11">
                                <label for="bill_to_id">Bill To<span class="text-danger">*</span></label>
                                <select class="form-control select2 bill-to" name="bill_to_customer_id" id="bill_to_id"
                                    placeholder="Please Select Bill To">
                                    <option value="">Select</option>
                                    @foreach($customers as $customer)
                                        <option value="{{ $customer->id }}" {{ old('bill_to_customer_id') == $customer->id ? 'selected' : '' }}>
                                            {{ $customer->client_code }} / {{ $customer->company_name }}
                                        </option>
                                    @endforeach
                                </select>
                            </div>

                            <div class="form-group col-md-1 d-flex align-items-end">
                                <button type="button" class="btn btn-success-rgba w-100" data-toggle="modal" data-target="#billToModel">
                                    <i class="fa fa-plus" aria-hidden="true"></i> Add Bill To
                                </button>
                            </div>

                            @error('bill_to_customer_id')
                                <div class="col-md-12 text-danger">{{ $message }}</div>
                            @enderror
                        </div>


                        <input type="hidden" class="form-control" name="bill_to_client_code" id="bill_to_client_code"
                            value="{{ old('bill_to_client_code') }}">
                        <input type="hidden" class="form-control" name="bill_to_company_name" id="bill_to_company_name"
                            value="{{ old('bill_to_company_name') }}">
                        <input type="hidden" class="form-control" name="bill_to_email" id="bill_to_email"
                            value="{{ old('bill_to_email') }}">
                        <input type="hidden" class="form-control" name="bill_to_phone_no" id="bill_to_phone_no"
                            value="{{ old('bill_to_phone_no') }}">
                        <input type="hidden" class="form-control" name="bill_to_address" id="bill_to_address"
                            value="{{ old('bill_to_address') }}">
                        <input type="hidden" class="form-control" name="bill_to_zip_code" id="bill_to_zip_code"
                            value="{{ old('bill_to_zip_code') }}">
                        <input type="hidden" class="form-control" name="currency" id="currency" 
                        value="{{ old('currency') }}">
                        <div id="bill_to_details">
                            <!-- Display selected bill to details here -->
                            @if(old('bill_to_client_code'))
                                <p class="text-uppercase">
                                    <strong>Client Code:</strong> <span>{{ old('bill_to_client_code') }}</span><br>
                                    <strong>Company Name / Patient Name:</strong> <span>{{ old('bill_to_company_name') }}</span><br>
                                    <strong>Email:</strong> <span>{{ old('bill_to_email') }}</span><br>
                                    <strong>Phone:</strong> <span>{{ old('bill_to_phone_no') }}</span><br>
                                    <strong>Address:</strong> <span>{{ old('bill_to_address') }}</span><br>
                                    <strong>Zip Code:</strong> <span>{{ old('bill_to_zip_code') }}</span>
                                </p>
                            @endif
                        </div>

                        <div class="form-row">
                            <div class="form-group col-md-11">
                                <label for="ship_to_id">Ship To<span class="text-danger">*</span></label>
                                <select class="form-control select2 ship-to" name="ship_to_customer_id" id="ship_to_id">
                                    <option value="">Select</option>
                                    @foreach($customers as $customer)
                                        <option value="{{ $customer->id }}" {{ old('ship_to_customer_id') == $customer->id ? 'selected' : '' }}>
                                            {{ $customer->client_code }} / {{ $customer->company_name }}
                                        </option>
                                    @endforeach
                                </select>
                            </div>

                            <div class="form-group col-md-1 d-flex align-items-end">
                                <button type="button" class="btn btn-success-rgba w-100" data-toggle="modal"
                                    data-target="#shipToModel">
                                    <i class="fa fa-plus" aria-hidden="true"></i> Add Ship To
                                </button>
                            </div>

                            @error('ship_to_customer_id')
                                <div class="col-md-12 text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <input type="hidden" class="form-control" name="ship_to_client_code" id="ship_to_client_code"
                            value="{{ old('ship_to_client_code') }}">
                        <input type="hidden" class="form-control" name="ship_to_company_name" id="ship_to_company_name"
                            value="{{ old('ship_to_company_name') }}">
                        <input type="hidden" class="form-control" name="ship_to_email" id="ship_to_email"
                            value="{{ old('ship_to_email') }}">
                        <input type="hidden" class="form-control" name="ship_to_phone_no" id="ship_to_phone_no"
                            value="{{ old('ship_to_phone_no') }}">
                        <input type="hidden" class="form-control" name="ship_to_address" id="ship_to_address"
                            value="{{ old('ship_to_address') }}">
                        <input type="hidden" class="form-control" name="ship_to_zip_code" id="ship_to_zip_code"
                            value="{{ old('ship_to_zip_code') }}">
                        <div id="ship_to_details">
                            <!-- Display selected ship to details here -->
                            @if(old('ship_to_client_code'))
                                <p class="text-uppercase">
                                    <strong>Client Code:</strong> <span>{{ old('ship_to_client_code') }}</span><br>
                                    <strong>Company Name / Patient Name:</strong> <span>{{ old('ship_to_company_name') }}</span><br>
                                    <strong>Email:</strong> <span>{{ old('ship_to_email') }}</span><br>
                                    <strong>Phone:</strong> <span>{{ old('ship_to_phone_no') }}</span><br>
                                    <strong>Address:</strong> <span>{{ old('ship_to_address') }}</span><br>
                                    <strong>Zip Code:</strong> <span>{{ old('ship_to_zip_code') }}</span>
                                </p>
                            @endif
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Country<span class="text-danger">*</span></label>
                            <input type="text" name="country" value="{{old('country')}}"
                                class="form-control" aria-describedby="country"
                                placeholder="Enter Your Country">
                            @error('country')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>
                        @php
                            $date = new DateTime();
                            $serveDate = $date->format('Y-m');
                        @endphp
                        <div class="form-group">
                            <label for="exampleInputEmail1">Serve Date<span class="text-danger">*</span></label>
                            <input type="month" name="serve_date" class="form-control"
                                value="{{ old('serve_date', $serveDate) }}" required>
                            @error('serve_date')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">PI No</label>
                            <input type="text" name="pi_number" value="{{old('pi_number')}}" class="form-control"
                                aria-describedby="Name" placeholder="Enter PI No">
                            @error('pi_number')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Payment Terms</label>
                            <select class="form-control select2-payment-terms" name="payment_terms" placeholder="Please Select Payment Terms">
                                <option value="">Select</option>
                                <option value="50% ADVANCE 50% BEFORE DELIVERY" {{ old('payment_terms') == '50% ADVANCE 50% BEFORE DELIVERY' ? 'selected' : '' }}>50% ADVANCE 50% BEFORE DELIVERY</option>
                                <option value="75% ADVANCE 25% BEFORE DELIVERY" {{ old('payment_terms') == '75% ADVANCE 25% BEFORE DELIVERY' ? 'selected' : '' }}>75% ADVANCE 25% BEFORE DELIVERY</option>
                                <option value="100% ADVANCE BEFORE DELIVERY" {{ old('payment_terms') == '100% ADVANCE BEFORE DELIVERY' ? 'selected' : '' }}>100% ADVANCE BEFORE DELIVERY</option>
                            </select>
                            @error('payment_terms')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Delivery By</label>
                            <input type="text" name="delivery_by" value="{{old('delivery_by')}}"
                                class="form-control @error('delivery_by') is-invalid @enderror"
                                aria-describedby="delivery_by" placeholder="Enter Delivery By">
                            @error('delivery_by')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Delivery Time</label>
                            <input type="text" name="delivery_time" value="{{old('delivery_time')}}"
                                class="form-control @error('delivery_time') is-invalid @enderror"
                                aria-describedby="delivery_time" placeholder="Enter Delivery Time">
                            @error('delivery_time')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Delivery Terms</label>
                            <input type="text" name="delivery_terms" value="{{old('delivery_terms')}}"
                                class="form-control @error('delivery_terms') is-invalid @enderror"
                                aria-describedby="delivery_terms" placeholder="Enter Delivery Terms">
                            @error('delivery_terms')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Port Of Discharge</label>
                            <input type="text" name="port_of_discharge" value="{{old('port_of_discharge')}}"
                                class="form-control @error('port_of_discharge') is-invalid @enderror"
                                aria-describedby="port_of_discharge" placeholder="Enter Port Of Discharge">
                            @error('port_of_discharge')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="mt-3">
                            <button type="submit" class="btn btn-primary-rgba mr-3"
                                onclick="this.disabled=true; this.innerText='Submitting...'; this.form.submit();">Submit</button>
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

<!-- bill to create model -->
<div class="modal fade" id="billToModel" tabindex="-1" role="dialog" aria-labelledby="billToModelLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="billToModelLabel">Bill To Customer Create</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="billToForm" method="POST" action="{{ url('createCustomer') }}">
      @csrf
      <div class="modal-body">
            <div class="card-body">
                <div class="form-group">
                    <label for="exampleInputEmail1">Bill To</label>
                    <select class="form-control" name="parent_id" placeholder="Please Select Parent Name">
                        <option value="">Select</option>
                        @foreach($customers as $customer)
                                <option value="{{ $customer->id }}">
                                    {{  $customer->client_code.' / '.$customer->company_name }}
                                </option>
                        @endforeach
                    </select>
                </div>
                <div class="form-group">
                    <label for="exampleInputEmail1">COMPANY / PATIENT NAME<span class="text-danger">*</span></label>
                    <input type="text"  name="company_name" value="{{old('company_name')}}" class="form-control @error('company_name') is-invalid @enderror"  aria-describedby="company_name" placeholder="Enter COMPANY / PATIENT NAME">
                    @error('company_name')
                        <div class="error-message">{{ $message }}</div>
                    @enderror
                </div>
                <div class="form-group">
                    <label for="exampleInputEmail1">Email ID</label>
                    <input type="text" name="email" value="{{old('email')}}"
                        class="form-control @error('email') is-invalid @enderror" aria-describedby="email"
                        placeholder="Enter Email ID">
                    @error('email')
                        <div class="error-message">{{ $message }}</div>
                    @enderror
                </div>

                <div class="form-group">
                    <label for="exampleInputEmail1">Phone Number<span class="text-danger">*</span></label>
                    <input type="text" name="phone_no" value="{{old('phone_no')}}"
                        class="form-control @error('phone_no') is-invalid @enderror" aria-describedby="phone_no"
                        placeholder="Enter Phone Number">
                    @error('phone_no')
                        <div class="error-message">{{ $message }}</div>
                    @enderror
                </div>

                <div class="form-group">
                    <label for="exampleInputEmail1">Registration Number</label>
                    <input type="text" name="registration_no" value="{{old('registration_no')}}"
                        class="form-control @error('registration_no') is-invalid @enderror"
                        aria-describedby="registration_no" placeholder="Enter Registration Number">
                </div>

                <div class="form-group">
                    <label for="exampleInputEmail1">Address<span class="text-danger">*</span></label>
                    <textarea name="address" class="form-control @error('address') is-invalid @enderror"
                        placeholder="Enter Address">{{ old('address')}}</textarea>
                    @error('address')
                        <div class="error-message">{{ $message }}</div>
                    @enderror
                </div>

                <div class="form-group">
                    <label for="exampleInputEmail1">Zip Code</label>
                    <input type="text" name="zip_code" value="{{old('zip_code')}}"
                        class="form-control @error('zip_code') is-invalid @enderror" aria-describedby="zip_code"
                        placeholder="Enter Zip Code">
                    @error('zip_code')
                        <div class="error-message">{{ $message }}</div>
                    @enderror
                </div>

                <div class="form-group">
                    <label for="exampleInputEmail1">Bank Name<span class="text-danger">*</span></label>
                    <select class="form-control" name="bank_id" placeholder="Please Select Bank Name">
                        <option value="">Select</option>
                        @foreach($banks as $bank)
                            <option value="{{ $bank->id }}"
                                {{ old('bank_id') == $bank->id ? 'selected' : '' }}>
                                {{ $bank->name . ' (AC No : ' . $bank->account_no . ')' }}
                            </option>
                        @endforeach
                    </select>
                    @error('bank_id')
                        <div class="error-message">{{ $message }}</div>
                    @enderror
                </div>

                <div class="form-group">
                    <label for="exampleInputEmail1">Currency<span class="text-danger">*</span></label>
                    <select class="form-control" name="currency" placeholder="Please Select Currency">
                        <option value="">Select</option>
                        <option value="USD" {{ old('currency') == 'USD' ? 'selected' : '' }}>USD</option>
                        <option value="EURO" {{ old('currency') == 'EURO' ? 'selected' : '' }}>EURO</option>
                        <option value="SGD" {{ old('currency') == 'SGD' ? 'selected' : '' }}>SGD</option>
                        <option value="AED" {{ old('currency') == 'AED' ? 'selected' : '' }}>AED</option>
                        <option value="GBP" {{ old('currency') == 'GBP' ? 'selected' : '' }}>GBP</option>
                    </select>
                    @error('currency')
                        <div class="error-message">{{ $message }}</div>
                    @enderror
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-danger-rgba" data-dismiss="modal">Close</button>
            <button type="submit" class="btn btn-primary-rgba mr-3">Save</button>
        </div>
      </form>
    </div>
  </div>
</div>
<!-- end bill to create model -->

<!-- ship to create model -->
<div class="modal fade" id="shipToModel" tabindex="-1" role="dialog" aria-labelledby="shipToModelLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="shipToModelLabel">Ship To Customer Create</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="shipToForm" method="POST" action="{{ url('createCustomer') }}">
      @csrf
      <div class="modal-body">
        <div class="card-body">
            <div class="form-group">
                <label for="exampleInputEmail1">Ship To</label>
                <select id="ship-to-select" class="form-control" name="parent_id" placeholder="Please Select Parent Name">
                    <option value="">Select</option>
                    @foreach($customers as $customer)
                            <option value="{{ $customer->id }}">
                                {{  $customer->client_code.' / '.$customer->company_name }}
                            </option>
                    @endforeach
                </select>
            </div>
            
            <div class="form-group">
                <label for="exampleInputEmail1">COMPANY / PATIENT NAME<span class="text-danger">*</span></label>
                <input type="text"  name="company_name" value="{{old('company_name')}}" class="form-control @error('company_name') is-invalid @enderror"  aria-describedby="company_name" placeholder="Enter COMPANY / PATIENT NAME">
                @error('company_name')
                    <div class="error-message">{{ $message }}</div>
                @enderror
            </div>

            <div class="form-group">
                <label for="exampleInputEmail1">Email ID</label>
                <input type="text" name="email" value="{{old('email')}}"
                    class="form-control @error('email') is-invalid @enderror" aria-describedby="email"
                    placeholder="Enter Email ID">
                @error('email')
                    <div class="error-message">{{ $message }}</div>
                @enderror
            </div>

            <div class="form-group">
                <label for="exampleInputEmail1">Phone Number<span class="text-danger">*</span></label>
                <input type="text" name="phone_no" value="{{old('phone_no')}}"
                    class="form-control @error('phone_no') is-invalid @enderror" aria-describedby="phone_no"
                    placeholder="Enter Phone Number">
                @error('phone_no')
                    <div class="error-message">{{ $message }}</div>
                @enderror
            </div>

            <div class="form-group">
                <label for="exampleInputEmail1">Registration Number</label>
                <input type="text" name="registration_no" value="{{old('registration_no')}}"
                    class="form-control @error('registration_no') is-invalid @enderror"
                    aria-describedby="registration_no" placeholder="Enter Registration Number">
            </div>

            <div class="form-group">
                <label for="exampleInputEmail1">Address<span class="text-danger">*</span></label>
                <textarea name="address" class="form-control @error('address') is-invalid @enderror"
                    placeholder="Enter Address">{{ old('address')}}</textarea>
                @error('address')
                    <div class="error-message">{{ $message }}</div>
                @enderror
            </div>

            <div class="form-group">
                <label for="exampleInputEmail1">Zip Code</label>
                <input type="text" name="zip_code" value="{{old('zip_code')}}"
                    class="form-control @error('zip_code') is-invalid @enderror" aria-describedby="zip_code"
                    placeholder="Enter Zip Code">
                @error('zip_code')
                    <div class="error-message">{{ $message }}</div>
                @enderror
            </div>

            <div class="form-group">
                <label for="exampleInputEmail1">Bank Name<span class="text-danger">*</span></label>
                <select class="form-control" name="bank_id" placeholder="Please Select Bank Name">
                    <option value="">Select</option>
                    @foreach($banks as $bank)
                        <option value="{{ $bank->id }}"
                            {{ old('bank_id') == $bank->id ? 'selected' : '' }}>
                            {{ $bank->name . ' (AC No : ' . $bank->account_no . ')' }}
                        </option>
                    @endforeach
                </select>
                @error('bank_id')
                    <div class="error-message">{{ $message }}</div>
                @enderror
            </div>

            <div class="form-group">
                <label for="exampleInputEmail1">Currency<span class="text-danger">*</span></label>
                <select class="form-control" name="currency" placeholder="Please Select Currency">
                    <option value="">Select</option>
                    <option value="USD" {{ old('currency') == 'USD' ? 'selected' : '' }}>USD</option>
                    <option value="EURO" {{ old('currency') == 'EURO' ? 'selected' : '' }}>EURO</option>
                    <option value="SGD" {{ old('currency') == 'SGD' ? 'selected' : '' }}>SGD</option>
                    <option value="AED" {{ old('currency') == 'AED' ? 'selected' : '' }}>AED</option>
                    <option value="GBP" {{ old('currency') == 'GBP' ? 'selected' : '' }}>GBP</option>
                </select>
                @error('currency')
                    <div class="error-message">{{ $message }}</div>
                @enderror
            </div>
        </div>
      </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-danger-rgba" data-dismiss="modal">Close</button>
            <button type="submit" class="btn btn-primary-rgba mr-3">Save</button>
        </div>
      </form>
    </div>
  </div>
</div>
<!-- end ship to create model -->
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
        // Initialize select2 for Bill To and Ship To (if not already done)
        $('.select2').select2({
            placeholder: function() {
                return $(this).data('placeholder') || "Please Select an Option";
            },
            allowClear: true
        });

        // 1. Handle Bill To change to populate Ship To dropdown
        $('.bill-to').on('change', function () {
            let billToId = $(this).val();

            if (!billToId) {
                // If no Bill To selected, clear the Ship To dropdown
                $('#ship_to_id').html('<option value="">Select</option>');
                clearShipToDetails();
                return;
            }

            // Fetch possible Ship To(s) for the selected Bill To
            $.ajax({
                url: '/getShipTo', 
                type: 'POST',
                data: {
                    billToId: billToId,
                    _token: '{{ csrf_token() }}'
                },
                success: function (htmlResult) {
                    // Populate Ship To dropdown with new options
                    $('#ship_to_id').html(htmlResult);

                    // If there's an old Ship To we want to restore
                    let oldShipTo = '{{ old('ship_to_customer_id') }}';
                    if (oldShipTo) {
                        // Set the selected value and trigger details fetch
                        $('#ship_to_id').val(oldShipTo).trigger('change');
                    } else {
                        // Clear details if there's no old Ship To
                        clearShipToDetails();
                    }
                }
            });

            // Also fetch Bill To details for display
            $.ajax({
                url: '/getBillTo', 
                type: 'POST',
                data: {
                    billToId: billToId,
                    _token: '{{ csrf_token() }}'
                },
                success: function (result) {
                    if (result.client_code && result.company_name) {
                        $('#bill_to_client_code').val(result.client_code);
                        $('#bill_to_company_name').val(result.company_name);
                        $('#bill_to_email').val(result.email);
                        $('#bill_to_phone_no').val(result.phone_no);
                        $('#bill_to_address').val(result.address);
                        $('#bill_to_zip_code').val(result.zip_code);
                        $('#currency').val(result.currency);

                        let detailsHtml = `
                            <p class="text-uppercase">
                                <strong>Client Code:</strong> <span>${result.client_code}</span><br>
                                <strong>Company Name / Patient Name:</strong> <span>${result.company_name}</span><br>
                                <strong>Email:</strong> <span>${result.email ?? ''}</span><br>
                                <strong>Phone:</strong> <span>${result.phone_no}</span><br>
                                <strong>Registration No:</strong> <span>${result.registration_no ?? ''}</span><br>
                                <strong>Address:</strong> <span>${result.address}</span><br>
                                <strong>Zip Code:</strong> <span>${result.zip_code ?? ''}</span>
                            </p>`;
                        
                        $('#bill_to_details').html(detailsHtml).show();
                    } else {
                        $('#bill_to_details').hide();
                    }

                    // Important: Clear existing Ship To details whenever Bill To changes
                    clearShipToDetails();
                }
            });
        });

        // 2. Handle Ship To change to show Ship To details
        $('.ship-to').on('change', function () {
            let shipToId = $(this).val();

            if (!shipToId) {
                clearShipToDetails();
                return;
            }

            $.ajax({
                url: '/getShipToDetails',
                type: 'POST',
                data: {
                    shipToId: shipToId,
                    _token: '{{ csrf_token() }}'
                },
                success: function (result) {
                    if (result.client_code && result.company_name) {
                        $('#ship_to_client_code').val(result.client_code);
                        $('#ship_to_company_name').val(result.company_name);
                        $('#ship_to_email').val(result.email);
                        $('#ship_to_phone_no').val(result.phone_no);
                        $('#ship_to_address').val(result.address);
                        $('#ship_to_zip_code').val(result.zip_code);

                        let detailsHtml = `
                            <p class="text-uppercase">
                                <strong>Client Code:</strong> <span>${result.client_code}</span><br>
                                <strong>Company Name / Patient Name:</strong> <span>${result.company_name}</span><br>
                                <strong>Email:</strong> <span>${result.email ?? ''}</span><br>
                                <strong>Phone:</strong> <span>${result.phone_no}</span><br>
                                <strong>Address:</strong> <span>${result.address}</span><br>
                                <strong>Zip Code:</strong> <span>${result.zip_code ?? ''}</span>
                            </p>`;
                        $('#ship_to_details').html(detailsHtml).show();
                    } else {
                        clearShipToDetails();
                    }
                }
            });
        });

        // 3. Helper function to clear Ship To details
        function clearShipToDetails() {
            $('#ship_to_client_code').val('');
            $('#ship_to_company_name').val('');
            $('#ship_to_email').val('');
            $('#ship_to_phone_no').val('');
            $('#ship_to_address').val('');
            $('#ship_to_zip_code').val('');
            $('#ship_to_details').hide().empty();
        }

        // 4. On document ready, restore old Bill To & Ship To if they exist
        let oldBillTo = '{{ old('bill_to_customer_id') }}';
        let oldShipTo = '{{ old('ship_to_customer_id') }}';

        if (oldBillTo) {
            // Set Bill To first, triggers Bill To change which populates Ship To
            $('#bill_to_id').val(oldBillTo).trigger('change');
        } else if (oldShipTo) {
            // If no Bill To but an old Ship To is set, just set it directly
            // (Normally you'd want Bill To selected, but this handles fallback)
            $('#ship_to_id').val(oldShipTo).trigger('change');
        }
    });
</script>
<script type="text/javascript">
    $(document).ready(function () {
        $('#bill_to_id').change(function () {
            let billToId = $(this).val();


            // Iterate through options in the ship-to select
            $('#ship-to-select option').each(function () {
                // Compare the value with the bill-to ID
                if ($(this).val() == billToId) {
                    // Set the selected attribute if there's a match
                    $(this).prop('selected', true);
                }
            });

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
        handleFormSubmission('#billToForm', '#billToModel', '{{ url('createCustomer') }}', 'bill_to');
        handleFormSubmission('#shipToForm', '#shipToModel', '{{ url('createCustomer') }}', 'ship_to');
    });

    function handleFormSubmission(formId, modalId, actionUrl, customerType) {
        $(formId).on('submit', function (event) {
            event.preventDefault();

            // Disable submit button to prevent multiple submissions
            $('button[type="submit"]', formId).prop('disabled', true);

            // Clear previous errors
            $('.modal-body .error-message', modalId).remove();

            // Get form data
            var formData = $(this).serialize();

            // Perform client-side validation
            var companyName = $('[name="company_name"]', formId).val().trim();
            var email = $('[name="email"]', formId).val().trim();
            var phoneNo = $('[name="phone_no"]', formId).val().trim();
            var address = $('[name="address"]', formId).val().trim();
            var zipCode = $('[name="zip_code"]', formId).val().trim();
            var bankId = $('[name="bank_id"]', formId).val().trim();
            var currency = $('[name="currency"]', formId).val().trim();

            var errors = {};

            if (companyName === '') {
                errors['company_name'] = 'The company name field is required.';
            }

            // if (email === '') {
            //     errors['email'] = 'The email field is required.';
            // } else if (!isValidEmail(email)) {
            //     errors['email'] = 'Please enter a valid email address.';
            // }

            if (phoneNo === '') {
                errors['phone_no'] = 'The phone number field is required.';
            } else if (isNaN(phoneNo)) {
                errors['phone_no'] = 'Please enter a valid phone number.';
            } else if (phoneNo.length < 1 || phoneNo.length > 25) {
                errors['phone_no'] = 'The phone number must be between 1 and 25 digits.';
            }

            if (address === '') {
                errors['address'] = 'The address field is required.';
            }

            // if (zipCode === '') {
            //     errors['zip_code'] = 'The zip code field is required.';
            // }

            if(bankId === ''){
                errors['bank_id'] = 'The bank name field is required.';
            }

            if (currency === '') {
                errors['currency'] = 'Please select currency.';
            }

            // Display validation errors if any
            if (Object.keys(errors).length > 0) {
                $.each(errors, function (key, value) {
                    $('[name="' + key + '"]', formId).after('<div class="text-danger error-message">' + value + '</div>');
                });

                // Re-enable submit button
                $('button[type="submit"]', formId).prop('disabled', false);

                return;
            }

            // If no errors, submit the form via AJAX
            $.ajax({
                type: 'POST',
                url: actionUrl,
                data: formData + '&customer_type=' + customerType, // Pass customer type as a parameter
                success: function (response) {
                    // Handle success response...
                    if (response.success) {
                        $('#message').html(
                            '<div class="alert alert-success alert-dismissible fade show m-0 mt-3" role="alert">' +
                            response.message +
                            '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                            '<span aria-hidden="true">&times;</span>' +
                            '</button>' +
                            '</div>'
                        );
                        setTimeout(function () {
                            window.location.reload();
                        }, 2500);
                    } else {
                        $('#message').html(
                            '<div class="alert alert-danger alert-dismissible fade show m-0 mt-3" role="alert">' +
                            response.message +
                            '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                            '<span aria-hidden="true">&times;</span>' +
                            '</button>' +
                            '</div>'
                        );
                    }
                },
                error: function (xhr, status, error) {
                    console.error(xhr.responseText);
                    // Handle error response...
                },
                complete: function () {
                    // Re-enable submit button after request completes
                    $('button[type="submit"]', formId).prop('disabled', false);
                }
            });
        });

        // Function to validate email format
        function isValidEmail(email) {
            var pattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return pattern.test(email);
        }
    }
</script>
@endsection