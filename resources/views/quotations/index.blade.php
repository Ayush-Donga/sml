@section('title')
Quotations List
@endsection
@extends('layouts.main')

@section('style')
<!-- Sweet Alert css -->
<link href="{{ asset('assets/plugins/sweet-alert2/sweetalert2.min.css') }}" rel="stylesheet" type="text/css" />
<!-- DataTables css -->
<link href="{{ asset('assets/plugins/datatables/dataTables.bootstrap4.min.css') }}" rel="stylesheet" type="text/css" />
<link href="{{ asset('assets/plugins/datatables/buttons.bootstrap4.min.css') }}" rel="stylesheet" type="text/css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

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
            @if ($message = Session::get('success'))
            <div class="alert alert-success alert-dismissible fade show m-0 mt-3" role="alert">
                {{ $message }}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            @endif

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
                            <h5 class="card-title mb-0">All Quotations</h5>
                        </div>
                        <div class="col-6 d-flex justify-content-end">
                            <div class="status-tabs">
                                <ul class="nav nav-tabs" id="statusTabs">
                                    <li class="nav-item">
                                        <a class="nav-link {{ $status === 'open' || $status === 'reopen' ? 'active' : '' }}"
                                        href="{{ route('quotations.index', ['status' => 'open', 'perPage' => $perPage, 'search' => $search]) }}">
                                            Query ({{ $openAndReopenCount }})
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link {{ $status === 'pending' ? 'active' : '' }}"
                                        href="{{ route('quotations.index', ['status' => 'pending', 'perPage' => $perPage, 'search' => $search]) }}">
                                            Pending ({{ $pendingCount }})
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link {{ $status === 'close' ? 'active' : '' }}"
                                        href="{{ route('quotations.index', ['status' => 'close', 'perPage' => $perPage, 'search' => $search]) }}">
                                            Close ({{ $closeCount }})
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <div class="dataTables_wrapper container-fluid dt-bootstrap4 no-footer">
                            <div class="row">
                                <div class="col-sm-12 col-md-6 d-flex">
                                    <form id="perPageForm" method="GET" action="{{ route('quotations.index') }}">
                                        <input type="hidden" name="status" value="{{ $status }}">
                                        <input type="hidden" name="search" value="{{ $search }}">
                                        <div class="dataTables_length" id="">
                                            <label style="margin-left: -14px;">
                                                Show
                                                <select name="perPage" class="form-control form-control-sm"
                                                    onchange="this.form.submit()">
                                                    @foreach($perPageOptions as $option)
                                                    <option value="{{ $option }}" {{ $option == $perPage ? 'selected' : '' }}>
                                                        {{ $option }}
                                                    </option>
                                                    @endforeach
                                                </select>
                                                entries
                                            </label>
                                        </div>
                                    </form>
                                </div>
                                <div class="col-sm-12 col-md-6 d-flex justify-content-end">
                                    <form id="searchForm" action="{{ route('quotations.index') }}" method="GET" class="d-flex align-items-center">
                                        <input type="hidden" name="status" value="{{ $status }}">
                                        <input type="hidden" name="perPage" value="{{ $perPage }}">
                                            <label style="margin-right: 3px; margin-top: 2px;">Search:</label>
                                                <input type="search" class="form-control form-control-sm"
                                                    name="search" id="searchInput" value="{{ $search }}" style="margin-right: -15px; margin-top: -8px;">
                                    </form>
                                </div>
                            </div>
                        </div>
                        @php
                            $sno = $inquires->firstItem() ?? 1;
                        @endphp

                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th class="font-weight-bold text-nowrap">SR NO</th>
                                    <th class="font-weight-bold text-nowrap">Quote No</th>
                                    <th class="font-weight-bold text-nowrap">Inquire Brand Name</th>
                                    <th class="font-weight-bold text-nowrap">Inquire Generic Name</th>
                                    <th class="font-weight-bold text-nowrap">Quantity</th>
                                    <th class="font-weight-bold text-nowrap">No Of Brand</th>
                                    <th class="font-weight-bold text-nowrap">Status</th>
                                    <th class="font-weight-bold text-nowrap">Brand Name</th>
                                    <th class="font-weight-bold text-nowrap">Generic Name</th>
                                    <th class="font-weight-bold text-nowrap">Pack Size</th>
                                    <th class="font-weight-bold text-nowrap">Manufacturer Name</th>
                                    <th class="font-weight-bold text-nowrap">Gst</th>
                                    <th class="font-weight-bold text-nowrap">Storage Condition</th>
                                    <th class="font-weight-bold text-nowrap">Product Photos</th>
                                    <th class="font-weight-bold text-nowrap">Product Documents</th>
                                    <th class="font-weight-bold text-nowrap">No Of Supplier</th>
                                    <th class="font-weight-bold text-nowrap">Supplier Details</th>
                                    <th class="font-weight-bold text-nowrap">Created At</th>
                                    <th class="font-weight-bold text-nowrap">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse($inquires as $inquire)
                                    @php
                                        $quotationGroup = $inquire->quotations; 
                                        $rowCount       = $quotationGroup->count();
                                        // Just for convenience:
                                        $brandName      = optional($inquire->brand)->name;
                                        $genericName    = optional($inquire->generic)->name;
                                    @endphp

                                    {{-- CASE 1: If there ARE quotations for this Inquire --}}
                                    @if($rowCount > 0)
                                        @foreach($quotationGroup as $index => $quotation)
                                            <tr>
                                                {{-- Only do these row-spanned cells on the first quotation row --}}
                                                @if($index === 0)
                                                    {{-- Serial No --}}
                                                    <td class="font-weight-normal text-nowrap" rowspan="{{ $rowCount }}">{{ $sno }}</td>

                                                    {{-- Quote Number --}}
                                                    <td class="font-weight-normal text-nowrap" rowspan="{{ $rowCount }}">{{ $inquire->quote_number }}</td>

                                                    {{-- Inquire Brand Name --}}
                                                    <td class="font-weight-normal text-nowrap" rowspan="{{ $rowCount }}">
                                                        {{ $brandName ?? '' }}
                                                    </td>

                                                    {{-- Inquire Generic Name --}}
                                                    <td class="font-weight-normal text-nowrap" rowspan="{{ $rowCount }}">
                                                        {{ $genericName ?? '' }}
                                                    </td>

                                                    {{-- Quantity --}}
                                                    <td class="font-weight-normal text-nowrap" rowspan="{{ $rowCount }}">
                                                        {{ $inquire->quantity}}
                                                    </td>

                                                    {{-- (Example) No of Brand (rowspan) --}}
                                                    @php
                                                        $hasPendingDetails = false; 
                                                        if ($inquire->no_of_brand > 0) {
                                                            $totalBrands = $inquire->no_of_brand;
                                                            $addedBrands = 0;
                                                            // Check if required brands are complete
                                                            foreach ($inquire->quotations as $quote) {
                                                                if ($quote->inquire_id === $inquire->id) {
                                                                    // We'll consider the brand "complete" by default here
                                                                    $addedBrands++;
                                                                }
                                                            }
                                                            if ($addedBrands < $totalBrands) {
                                                                $hasPendingDetails = true;
                                                            }
                                                        }
                                                        // Determine CSS class for the brand cell
                                                        $highlightBrandCell = ($inquire->status === 'pending' && $hasPendingDetails)
                                                            ? 'quotation-pending-cell'
                                                            : '';
                                                    @endphp
                                                    <td class="font-weight-normal text-nowrap {{ $highlightBrandCell }}" rowspan="{{ $rowCount }}">
                                                        @if($inquire->no_of_brand > 0)
                                                            @php
                                                                $totalBrands = $inquire->no_of_brand ?? 0;
                                                                $addedBrands = 0;
                                                                foreach ($inquire->quotations as $quote) {
                                                                    if ($quote->inquire_id === $inquire->id) {
                                                                        $addedBrands++;
                                                                    }
                                                                }
                                                                $addedBrands = min($addedBrands, $totalBrands);
                                                            @endphp
                                                            {{ $addedBrands }}/{{ $totalBrands }}
                                                        @else
                                                            N/A
                                                        @endif
                                                    </td>

                                                    {{-- Status (rowspan) --}}
                                                    <td class="font-weight-normal text-nowrap" rowspan="{{ $rowCount }}">
                                                        {{ $inquire->status }}
                                                    </td>
                                                @endif

                                                {{-- Now the columns which repeat for each quotation --}}
                                                {{-- Brand Name (from $quotation->brand_id) --}}
                                                <td class="font-weight-normal text-nowrap">
                                                    {{ $brands->firstWhere('id', $quotation->brand_id)->name ?? '' }}
                                                </td>

                                                {{-- Generic Name (from $quotation->generic_id) --}}
                                                <td class="font-weight-normal text-nowrap">
                                                    {{ $generics->firstWhere('id', $quotation->generic_id)->name ?? '' }}
                                                </td>

                                                {{-- Pack Size --}}
                                                @php
                                                    $highlightPackSizeCell = ($inquire->status == 'pending' && $inquire->is_pack_size && $quotation->product_variant_id == null)
                                                        ? 'quotation-pending-cell'
                                                        : '';
                                                @endphp
                                                <td class="font-weight-normal text-nowrap {{ $highlightPackSizeCell }}">
                                                    {{ $productVariants->firstWhere('id', $quotation->product_variant_id)->name ?? '' }}
                                                </td>

                                                {{-- Manufacturer Name --}}
                                                @php
                                                    $highlightManufacturerCell = ($inquire->status == 'pending' && $inquire->is_manufacturer_name && $quotation->manufacturer_id == null)
                                                        ? 'quotation-pending-cell'
                                                        : '';
                                                @endphp
                                                <td class="font-weight-normal text-nowrap {{ $highlightManufacturerCell }}">
                                                    {{ $manufacturers->firstWhere('id', $quotation->manufacturer_id)->name ?? '' }}
                                                </td>

                                                {{-- GST --}}
                                                @php
                                                    $highlightGstCell = ($inquire->status == 'pending' && $inquire->is_gst && $quotation->gst == null)
                                                        ? 'quotation-pending-cell'
                                                        : '';
                                                @endphp
                                                <td class="font-weight-normal text-nowrap {{ $highlightGstCell }}">
                                                    {{ $quotation->gst }}
                                                </td>

                                                {{-- Storage Condition --}}
                                                @php
                                                    $highlightStorageConditionCell = ($inquire->status == 'pending' && $inquire->is_storage_condition && $quotation->storage_condition == null)
                                                        ? 'quotation-pending-cell'
                                                        : '';
                                                @endphp
                                                <td class="font-weight-normal text-nowrap {{ $highlightStorageConditionCell }}">
                                                    {{ $quotation->storage_condition }}
                                                </td>

                                                {{-- Product Photos --}}
                                                @php
                                                    $photos = $quotation->productPhotos;
                                                    $highlightPhotosCell = (
                                                        $inquire->status == 'pending' 
                                                        && $inquire->is_product_photo 
                                                        && $photos->count() == 0
                                                    ) ? 'quotation-pending-cell' : '';
                                                @endphp
                                                <td class="font-weight-normal text-nowrap {{ $highlightPhotosCell }}">
                                                    @foreach($photos as $photo)
                                                        <a href="{{ asset('productPhotos/' . $photo->photo) }}" target="_blank">
                                                            <img src="{{ asset('productPhotos/' . $photo->photo) }}" style="width: 50px; height: 50px;">
                                                        </a>
                                                    @endforeach
                                                </td>

                                                {{-- Product Documents --}}
                                                @php
                                                    $documents = $quotation->productDocuments;
                                                    $highlightProductDocumentsCell = (
                                                        $inquire->status == 'pending' 
                                                        && $inquire->is_product_doc 
                                                        && $documents->count() == 0
                                                    ) ? 'quotation-pending-cell' : '';
                                                @endphp
                                                <td class="font-weight-normal text-nowrap {{ $highlightProductDocumentsCell }}">
                                                    @foreach($documents as $document)
                                                        <a href="{{ asset('productDocuments/' . $document->document) }}" target="_blank">
                                                            <i class="feather icon-file-text"></i> View Document
                                                        </a>
                                                    @endforeach
                                                </td>

                                                {{-- No of Supplier --}}
                                                @php
                                                    $hasPendingDetails = false;
                                                    if ($inquire->no_of_supplier > 0) {
                                                        $totalSuppliers = $inquire->no_of_supplier;
                                                        $addedSuppliers = 0;
                                                        foreach ($quotation->suppliers as $supplier) {
                                                            // For now, assume "complete" if it exists
                                                            $addedSuppliers++;
                                                        }
                                                        if ($addedSuppliers < $totalSuppliers) {
                                                            $hasPendingDetails = true;
                                                        }
                                                    }
                                                    $highlightSupplierCell = ($inquire->status == 'pending' && $hasPendingDetails)
                                                        ? 'quotation-pending-cell'
                                                        : '';
                                                @endphp
                                                <td class="font-weight-normal text-nowrap {{ $highlightSupplierCell }}">
                                                    @if($inquire->no_of_supplier > 0)
                                                        @php
                                                            $totalSuppliers = $inquire->no_of_supplier;
                                                            $addedSuppliers = 0;
                                                            if ($quotation->suppliers) {
                                                                foreach ($quotation->suppliers as $supplier) {
                                                                    if (!empty($supplier)) {
                                                                        $addedSuppliers++;
                                                                    }
                                                                }
                                                            }
                                                            $addedSuppliers = min($addedSuppliers, $totalSuppliers);
                                                        @endphp
                                                        {{ $addedSuppliers }}/{{ $totalSuppliers }}
                                                    @else
                                                        N/A
                                                    @endif
                                                </td>

                                                {{-- Supplier Details --}}
                                                <td class="font-weight-normal text-nowrap">
                                                    <table class="table table-bordered">
                                                        <thead>
                                                            <tr>
                                                                <th class="font-weight-bold text-nowrap">Vendor Name</th>
                                                                <th class="font-weight-bold text-nowrap">Price Per Pack</th>
                                                                <th class="font-weight-bold text-nowrap">Expiry Date</th>
                                                                <th class="font-weight-bold text-nowrap">Lead Time</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            @foreach($quotation->suppliers as $supplier)
                                                                <tr>
                                                                    {{-- Vendor Name --}}
                                                                    @php
                                                                        $highlightVenderNameCell = (
                                                                            $inquire->status == 'pending' 
                                                                            && $inquire->is_vendor_name 
                                                                            && $supplier->vender_id == null
                                                                        ) ? 'quotation-pending-cell' : '';
                                                                    @endphp
                                                                    <td class="font-weight-normal text-nowrap {{ $highlightVenderNameCell }}">
                                                                        @php
                                                                            $vendor = $venders->firstWhere('id', $supplier->vender_id);
                                                                        @endphp
                                                                        {{ $vendor ? $vendor->name : '' }}
                                                                    </td>

                                                                    {{-- Price Per Pack --}}
                                                                    @php
                                                                        $highlightPricePerPackCell = (
                                                                            $inquire->status == 'pending' 
                                                                            && $inquire->is_price_per_pack 
                                                                            && $supplier->price_per_pack == null
                                                                        ) ? 'quotation-pending-cell' : '';
                                                                    @endphp
                                                                    <td class="font-weight-normal text-nowrap {{ $highlightPricePerPackCell }}">
                                                                        {{ $supplier->price_per_pack }}
                                                                    </td>

                                                                    {{-- Expiry Date --}}
                                                                    @php
                                                                        $highlightExpiryDateCell = (
                                                                            $inquire->status == 'pending' 
                                                                            && $inquire->is_expiry 
                                                                            && $supplier->expiry_date == null
                                                                        ) ? 'quotation-pending-cell' : '';
                                                                    @endphp
                                                                    <td class="font-weight-normal text-nowrap {{ $highlightExpiryDateCell }}">
                                                                        {{ $supplier->expiry_date }}
                                                                    </td>

                                                                    {{-- Lead Time --}}
                                                                    @php
                                                                        $highlightLeadTimeCell = (
                                                                            $inquire->status == 'pending' 
                                                                            && $inquire->is_lead_time 
                                                                            && $supplier->lead_time == null
                                                                        ) ? 'quotation-pending-cell' : '';
                                                                    @endphp
                                                                    <td class="font-weight-normal text-nowrap {{ $highlightLeadTimeCell }}">
                                                                        {{ $supplier->lead_time }}
                                                                    </td>
                                                                </tr>
                                                            @endforeach
                                                        </tbody>
                                                    </table>
                                                </td>

                                                {{-- Created At --}}
                                                <td class="font-weight-normal text-nowrap">
                                                    {{ \Carbon\Carbon::parse($quotation->created_at)->setTimezone('Asia/Kolkata')->format('d/m/Y h:i A') }}
                                                </td>

                                                {{-- Actions --}}
                                                @if($index === 0)
                                                    <td class="font-weight-normal text-nowrap" rowspan="{{ $rowCount }}">
                                                        @if($status !== 'close')
                                                            @can('quotation-edit')
                                                                <a href="{{ route('quotations.edit', ['quotation' => $inquire->id, 'redirect' => urlencode(url()->full())]) }}"
                                                                class="btn btn-success-rgba">
                                                                <i class="feather icon-edit-2"></i>
                                                                </a>
                                                            @endcan
                                                        @endif
                                                        @if($status !== 'pending')
                                                            <a href="{{ route('quotations.show', ['quotation' => $quotation->id, 'redirect' => urlencode(url()->full())]) }}"
                                                            class="btn btn-primary-rgba">
                                                            <i class="feather icon-eye"></i>
                                                            </a>
                                                        @endif
                                                        @can('quotation-create')
                                                            @if($status === 'pending')
                                                                <button class="btn btn-danger-rgba closeInquire"
                                                                    data-status-inquire-id="{{ $inquire->id }}">
                                                                    <i class="feather icon-x"></i>
                                                                </button>
                                                            @endif
                                                        @endcan
                                                    </td>
                                                    @php
                                                        // Increment SNo only once per inquiry group
                                                        $sno++;
                                                    @endphp
                                                @endif
                                            </tr>
                                        @endforeach

                                        {{-- CASE 2: If there are NO quotations for this Inquire --}}
                                        @elseif($inquire->status === 'pending')
                                            <tr>
                                                {{-- Show the main inquiry details as if "rowspan" = 1 --}}
                                                <td class="font-weight-normal text-nowrap">{{ $sno }}</td>
                                                <td class="font-weight-normal text-nowrap">{{ $inquire->quote_number }}</td>
                                                <td class="font-weight-normal text-nowrap">{{ $brandName ?? '' }}</td>
                                                <td class="font-weight-normal text-nowrap">{{ $genericName ?? '' }}</td>
                                                <td class="font-weight-normal text-nowrap">{{ $inquire->quantity }}</td>
                                                @php
                                                    $highlightNoOfBrandCell = ($inquire->no_of_brand)
                                                        ? 'quotation-pending-cell'
                                                        : '';
                                                @endphp
                                                <td class="font-weight-normal text-nowrap {{ $highlightNoOfBrandCell }}">
                                                    @if($inquire->no_of_brand)
                                                        0/{{ $inquire->no_of_brand }} 
                                                    @else
                                                        ''
                                                    @endif
                                                </td>
                                                <td class="font-weight-normal text-nowrap">
                                                    {{ $inquire->status }}
                                                </td>
                                                @php
                                                    $highlightBrandNameCell = (
                                                        $inquire->is_brand_name 
                                                    ) ? 'quotation-pending-cell' : '';
                                                @endphp
                                                <td class="font-weight-normal text-nowrap {{ $highlightBrandNameCell }}"></td> {{-- Quotation brand name --}}
                                                @php
                                                    $highlightGenericNameCell = (
                                                        $inquire->is_generic_name 
                                                    ) ? 'quotation-pending-cell' : '';
                                                @endphp
                                                <td class="font-weight-normal text-nowrap {{ $highlightGenericNameCell }}"></td> {{-- Quotation generic name --}}
                                                {{-- Pack Size --}}
                                                @php
                                                    $highlightPackSizeCell = ($inquire->is_pack_size)
                                                        ? 'quotation-pending-cell'
                                                        : '';
                                                @endphp
                                                <td class="font-weight-normal text-nowrap {{  $highlightPackSizeCell }}"></td> {{-- Pack size --}}
                                                {{-- Manufacturer Name --}}
                                                @php
                                                    $highlightManufacturerCell = ($inquire->is_manufacturer_name)
                                                        ? 'quotation-pending-cell'
                                                        : '';
                                                @endphp
                                                <td class="font-weight-normal text-nowrap {{ $highlightManufacturerCell }}"></td> {{-- Manufacturer --}}
                                                @php
                                                    $highlightGstCell = ($inquire->is_gst)
                                                        ? 'quotation-pending-cell'
                                                        : '';
                                                @endphp
                                                <td class="font-weight-normal text-nowrap {{ $highlightNoOfBrandCell }}"></td> {{-- GST --}}
                                                @php
                                                    $highlightStorageConditionCell = ($inquire->is_storage_condition)
                                                        ? 'quotation-pending-cell'
                                                        : '';
                                                @endphp
                                                <td class="font-weight-normal text-nowrap {{ $highlightStorageConditionCell }}"></td> {{-- Storage condition --}}
                                                {{-- Product Photos --}}
                                                @php
                                                    $highlightPhotosCell = (
                                                        $inquire->is_product_photo 
                                                    ) ? 'quotation-pending-cell' : '';
                                                @endphp
                                                <td class="font-weight-normal text-nowrap {{ $highlightPhotosCell }}"></td> {{-- Photos --}}
                                                {{-- Product Documents --}}
                                                @php
                                                    $highlightProductDocumentsCell = (
                                                        $inquire->is_product_doc
                                                    ) ? 'quotation-pending-cell' : '';
                                                @endphp
                                                <td class="font-weight-normal text-nowrap {{ $highlightProductDocumentsCell }}"></td> {{-- Documents --}}
                                                @php
                                                    $highlightNoOFSupplierCell = (
                                                        $inquire->no_of_supplier 
                                                    ) ? 'quotation-pending-cell' : '';
                                                @endphp
                                                <td class="font-weight-normal text-nowrap {{ $highlightNoOFSupplierCell }}">
                                                    @if($inquire->no_of_supplier)
                                                        0/{{ $inquire->no_of_supplier }} 
                                                    @else
                                                        N/A
                                                    @endif
                                                </td> {{-- No of suppliers --}}
                                                
                                                {{-- Supplier Table column --}}
                                                <td class="font-weight-normal text-nowrap">
                                                    <table class="table table-bordered">
                                                        <thead>
                                                            <tr>
                                                                <th class="font-weight-bold text-nowrap">Vendor Name</th>
                                                                <th class="font-weight-bold text-nowrap">Price Per Pack</th>
                                                                <th class="font-weight-bold text-nowrap">Expiry Date</th>
                                                                <th class="font-weight-bold text-nowrap">Lead Time</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td colspan="4"></td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>

                                                <td class="font-weight-normal text-nowrap"></td>

                                                {{-- Actions (edit, show, etc.) as needed --}}
                                                <td class="font-weight-normal text-nowrap">
                                                    @if($status !== 'close')
                                                        @can('quotation-edit')
                                                        <a href="{{ route('quotations.edit', ['quotation' => $inquire->id, 'redirect' => urlencode(url()->full())]) }}"
                                                        class="btn btn-success-rgba">
                                                        <i class="feather icon-edit-2"></i>
                                                        </a>
                                                        @endcan
                                                    @endif
                                                    {{-- Possibly you show or hide more buttons here --}}
                                                    @can('quotation-create')
                                                        @if($status === 'pending')
                                                            <button class="btn btn-danger-rgba closeInquire"
                                                                data-status-inquire-id="{{ $inquire->id }}">
                                                                <i class="feather icon-x"></i>
                                                            </button>
                                                        @endif
                                                    @endcan
                                                </td>
                                            </tr>
                                            @php $sno++; @endphp
                                        @endif

                                    @empty
                                        {{-- If $inquires itself is empty, you can show a single row saying "No Inquiries Found" --}}
                                        <tr>
                                            <td colspan="19">No Inquiries Found</td>
                                        </tr>
                            @endforelse
                        </tbody>
                        </table>
                        {{-- Pagination --}}
                
                        <!-- Pagination Links -->
                        <div class="d-flex justify-content-between align-items-center">
                            <!-- Pagination Text -->
                            <div>
                                <p class="mb-0">Showing {{ $inquires->firstItem() }} to {{ $inquires->lastItem() }} of
                                    {{ $inquires->total() }} entries
                                </p>
                            </div>
                            
                            <!-- Pagination Links with Fixed Previous and Next Buttons -->
                            <div class="pagination-links mt-4">
                                @if ($inquires->lastPage() > 1)
                                    <ul class="pagination">
                                        <!-- Previous Button -->
                                        <li class="page-item {{ ($inquires->currentPage() == 1) ? 'disabled' : '' }}">
                                            <a class="page-link" href="{{ $inquires->previousPageUrl() }}">Previous</a>
                                        </li>

                                        <!-- Pagination Links -->
                                        @foreach(range(1, $inquires->lastPage()) as $page)
                                            <li class="page-item {{ ($inquires->currentPage() == $page) ? 'active' : '' }}">
                                                <a class="page-link" href="{{ $inquires->url($page) }}">{{ $page }}</a>
                                            </li>
                                        @endforeach

                                        <!-- Next Button -->
                                        <li class="page-item {{ ($inquires->currentPage() == $inquires->lastPage()) ? 'disabled' : '' }}">
                                            <a class="page-link" href="{{ $inquires->nextPageUrl() }}">Next</a>
                                        </li>
                                    </ul>
                                @endif
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End col -->
        </div>
        <!-- End row -->

        <!--Close inquire modal -->
        <div class="modal fade" id="closeInquireModal" tabindex="-1" aria-labelledby="closeInquireModalLabel"
            aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Close Inquire</h5>
                    </div>
                    <div class="modal-body">
                        <label for="remarks" class="form-label">Comments:</label>
                        <textarea id="remarks" class="form-control" rows="4" placeholder="Please enter comments"></textarea>
                        <div id="validationError"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-primary" data-dismiss="modal">No</button>
                        <button type="button" class="btn btn-outline-danger confirm-close">Yes</button>
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
        // JavaScript to submit the form when the dropdown value changes
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelector('select[name="perPage"]').addEventListener('change', function() {
                this.closest('form').submit();
            });
        });
        </script>
        <script>
        // JavaScript to submit the form when typing in the search input
        document.addEventListener('DOMContentLoaded', function() {
            let timer;
            const searchInput = document.getElementById('searchInput');
            const form = document.getElementById('searchForm');

            searchInput.addEventListener('input', function() {
                clearTimeout(timer); // Clear the timer if the user is still typing
                timer = setTimeout(() => {
                    form.submit(); // Submit the form after 500ms of inactivity
                }, 500);
            });
        });
        </script>
        <script>
        $(function() {
            $('[data-toggle="tooltip"]').tooltip();
        });
        </script>
        <script>
        $('.closeInquire').click(function() {
            var statusInquireId = $(this).data('status-inquire-id');
            $('#closeInquireModal').modal('show');
            $('.confirm-close').off('click').on('click', function() {
                var remarks = $('#remarks').val();
                if (!remarks) { 
        
                $('#validationError').remove(); 

                $('#remarks').after('<div id="validationError" class="text-danger mt-2">Comments are required.</div>');
                    return; 
                } else {
                    $('#validationError').remove(); 
                }

                $.ajax({
                    url: '/inquires/' + statusInquireId + '/close',
                    type: 'POST',
                    data: {
                        _token: '{{ csrf_token() }}',
                        status: 'close',
                        remarks: remarks
                    },
                    success: function(result) {
                        $('#closeInquireModal').modal('hide');
                        if (result.message) {
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
                            window.location.reload();
                        }, 2500);
                    },
                    error: function(xhr) {
                        console.error(xhr.responseText);
                        alert('An error occurred while closing the inquire.');
                    }
                });
            });
        });
        </script>
@endsection