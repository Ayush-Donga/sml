@section('title')
Edit Customer
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
                    <li class="breadcrumb-item"><a href="{{url('/customers')}}">Customers</a></li>
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
                    <h5 class="card-title">Edit Customer</h5>
                </div>
                <div class="card-body">
                    <form method="post" action="{{ route('customers.update', $customer->id) }}">
                        @method('PATCH')
                        @csrf
                        <input type="hidden" name="redirect" value="{{ urlencode($redirectUrl) }}">
                        <div class="form-group">
                            <label for="exampleInputEmail1">Ship To</label>
                            <select class="form-control select2" name="parent_id" placeholder="Please Select Parent Name">
                                <option value="">Select</option>
                                @foreach($customers as $parent)
                                    @if($customer->id !== $parent->id)
                                        <option value="{{ $parent->id }}" {{ old('parent_id', $customer->parent_id) == $parent->id ? 'selected' : '' }}>
                                            {{ $parent->client_code . ' / ' . $parent->company_name }}
                                        </option>
                                    @endif
                                @endforeach
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">COMPANY / PATIENT NAME<span
                                    class="text-danger">*</span></label>
                            <input type="text" name="company_name" value="{{ old('company_name', $customer->company_name) }}"
                                class="form-control @error('company_name') is-invalid @enderror"
                                aria-describedby="company_name" placeholder="Enter COMPANY / PATIENT NAME" required>
                            @error('company_name')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Email ID</label>
                            <input type="text" name="email" value="{{ old('email', $customer->email) }}"
                                class="form-control @error('email') is-invalid @enderror" aria-describedby="email"
                                placeholder="Enter Email ID" required>
                            @error('email')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Phone Number<span class="text-danger">*</span></label>
                            <input type="text" name="phone_no" value="{{ old('phone_no', $customer->phone_no) }}"
                                class="form-control @error('phone_no') is-invalid @enderror" aria-describedby="phone_no"
                                placeholder="Enter Phone Number" required>
                            @error('phone_no')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Registration Number</label>
                            <input type="text" name="registration_no" value="{{ old('registration_no', $customer->registration_no) }}"
                                class="form-control @error('registration_no') is-invalid @enderror"
                                aria-describedby="registration_no" placeholder="Enter Registration Number" required>
                                @error('registration_no')
                                    <div class="text-danger">{{ $message }}</div>
                                @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Address<span class="text-danger">*</span></label>
                            <textarea name="address" 
                                    class="form-control @error('address') is-invalid @enderror" 
                                    placeholder="Enter Address" 
                                    required>{{ old('address', $customer->address) }}</textarea>
                            @error('address')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Zip Code</label>
                            <input type="text" name="zip_code" value="{{ old('zip_code', $customer->zip_code) }}"
                                class="form-control @error('zip_code') is-invalid @enderror" aria-describedby="zip_code"
                                placeholder="Enter Zip Code" required>
                            @error('zip_code')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="bank_id">Bank Name<span class="text-danger">*</span></label>
                            <select class="form-control" name="bank_id" id="bank_id" placeholder="Please Select Bank Name">
                                <option value="">Select</option>
                                @foreach($banks as $bank)
                                    <option value="{{ $bank->id }}" {{ old('bank_id', $customer->bank_id) == $bank->id ? 'selected' : '' }}>
                                        {{ $bank->name . ' (AC No : ' . $bank->account_no . ')' }}
                                    </option>
                                @endforeach
                            </select>
                            @error('bank_id')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Currency<span class="text-danger">*</span></label>
                            <select class="form-control select2" name="currency" placeholder="Please Select Currency">
                                <option value="">Select</option>
                                <option value="USD" {{ (old('currency') == 'USD' || (isset($customer) && $customer->currency == 'USD')) ? 'selected' : '' }}>USD</option>
                                <option value="EURO" {{ (old('currency') == 'EURO' || (isset($customer) && $customer->currency == 'EURO')) ? 'selected' : '' }}>EURO</option>
                                <option value="SGD" {{ (old('currency') == 'SGD' || (isset($customer) && $customer->currency == 'SGD')) ? 'selected' : '' }}>SGD</option>
                                <option value="AED" {{ (old('currency') == 'AED' || (isset($customer) && $customer->currency == 'AED')) ? 'selected' : '' }}>AED</option>
                                <option value="GBP" {{ (old('currency') == 'GBP' || (isset($customer) && $customer->currency == 'GBP')) ? 'selected' : '' }}>GBP</option>
                            </select>
                            @error('currency')
                                <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>

                        <div class="mt-3">
                            <button type="submit"
                                onclick="this.disabled=true; this.innerText='Submitting...'; this.form.submit();"
                                class="btn btn-primary-rgba mr-3">Save</button>
                            <a href="{{ urldecode($redirectUrl) }}" class="btn btn-danger-rgba">
                                Cancel
                            </a>
                        </div>
                    </form>
                </div>

                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <tr>
                                <th class="font-weight-bold">Client Code </th>
                                <th class="font-weight-bold">Company / Patient Name</th>
                                <th class="font-weight-bold">Action</th>
                            </tr>
                            <tbody>
                                @foreach($parents as $parent)
                                    <tr>
                                        <td class="font-weight-normal">{{ $parent->client_code  }}</td>
                                        <td class="font-weight-normal">{{ $parent->company_name }}</td>
                                        <td>
                                            <a href="{{ route('customers.editParent', ['id' => $parent->id, 'redirect' => urlencode(url()->full())]) }}"
                                                class="btn btn-success-rgba">
                                                <i class="feather icon-edit-2"></i>
                                            </a>
                                            <button type="button" data-customer-id="{{ $parent->id }}"
                                                class="btn btn-danger-rgba deleteCustomer"><i
                                                    class="feather icon-trash"></i></button>
                                        </td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                        <div class="d-flex justify-content-between align-items-center">
                            <!-- Pagination Text -->
                            <div>
                                <p class="mb-0">Showing {{ $parents->firstItem() }} to {{ $parents->lastItem() }} of
                                    {{ $parents->total() }}
                                    entries
                                </p>
                            </div>
                            <!-- Pagination Links -->
                            <div class="pagination-links mt-4">
                                {{ $parents->links() }}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End col -->
    </div> <!-- End row -->
</div>


<!-- parent delete model -->
<div class="modal fade" id="deleteCustomerModal" tabindex="-1" aria-labelledby="deleteCustomerModalLabel"
    aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Customer parent delete confirmation</h5>
            </div>
            <div class="modal-body">
                <span>Are you sure you want to delete?</span>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-primary" data-dismiss="modal">No</button>
                <button type="button" class="btn btn-outline-danger confirm-delete">yes</button>
            </div>
        </div>
    </div>
</div>


<!-- end variant delete model -->
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
    $(document).ready(function() {
        // Initialize Select2
        $('.select2').select2({
            placeholder: function() {
                return $(this).data('placeholder');
            },
            allowClear: true, // Enables clear button
        });
    });
</script>
<script>
    $(document).ready(function () {
        $('.deleteCustomer').click(function () {
            var customerId = $(this).data('customer-id');

            $('#deleteCustomerModal').modal('show');

            // Moved the click event listener for confirmation button outside the main click event
            $('.confirm-delete').off('click').on('click', function () {
                // Perform AJAX request to delete the Customer
                $.ajax({
                    url: '/customersParent/' + customerId,
                    type: 'DELETE',
                    data: {
                        _token: '{{ csrf_token() }}' // Include CSRF token
                    },
                    success: function (result) {
                        // Update UI or provide feedback
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
                        setTimeout(function () {
                            window.location.reload();
                        }, 2500);
                    },
                    error: function (xhr, status, error) {
                        // Handle errors
                        console.error(xhr.responseText);
                        alert('Error deleting customer.'); // Display error message
                    }
                });
                $('#deleteCustomerModal').modal('hide');
            });
        });
    });
</script>
@endsection