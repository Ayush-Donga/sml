@extends('layouts.main')

@section('title', 'Show Quotation')

@section('style')
<!-- Select2 css -->
<link href="{{ asset('assets/plugins/select2/select2.min.css') }}" rel="stylesheet" type="text/css" />
<!-- Tagsinput css -->
<link href="{{ asset('assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput.css') }}" rel="stylesheet" type="text/css" />
<link href="{{ asset('assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput-typeahead.css') }}" rel="stylesheet" type="text/css" />
<style>
    .add-more {
        margin-top: -30px;
    }
    .remove-supplier-detail {
        margin-top: 26px;
    }
    .photo-preview img {
        width: 50px;
        height: 50px;
        object-fit: cover;
    }
</style>
@endsection

@section('breadcrumbbar')
<div class="breadcrumbbar">
    <div class="row align-items-center">
        <div class="col-md-8 col-lg-8">
            <h4 class="page-title">@yield('title')</h4>
            <div class="breadcrumb-list">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="{{url('/')}}">Home</a></li>
                    <li class="breadcrumb-item"><a href="{{url('/quotations')}}">Quotation</a></li>
                    <li class="breadcrumb-item active" aria-current="page">@yield('title')</li>
                </ol>
            </div>
        </div>
        <div class="col-md-4 col-lg-4">
            <div class="widgetbar">
                <a href="{{ urldecode($redirectUrl) }}" class="btn btn-primary-rgba btn-back">
                    <i class="ti-arrow-left mr-2"></i>Back
                </a>
            </div>
        </div>
    </div>
</div>
@endsection

@section('errormessege')
<div class="contentbar p-0 m-0" style="padding-right :30px !important;">
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
                    <strong>{{ $message }}</strong>
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
<div class="contentbar">
    <div class="row">
        <div class="col-lg-12">
            <div class="card m-b-30">
                <!-- Inquire Details -->
                <div class="card-header">
                    <h5 class="card-title">Inquire Details</h5>
                </div>
                <div class="card-body">
                <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                @if($inquire->type == 'brand')
                                <label class="font-weight-bold">Brand Name</label>
                                <p class="form-control-static font-weight-normal text-uppercase">
                                    {{ $brands->firstWhere('id', $inquire->brand_id)->name ?? '' }}
                                </p>
                                @else
                                <label class="font-weight-bold">Generic Name</label>
                                <p class="form-control-static font-weight-normal text-uppercase">
                                    {{ $generics->firstWhere('id', $inquire->generic_id)->name ?? '' }}
                                </p>
                                @endif
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label class="font-weight-bold">Quantity</label>
                                <p class="form-control-static font-weight-normal">{{ $inquire->quantity }}</p>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label class="font-weight-bold">Type</label>
                                <p class="form-control-static font-weight-normal text-uppercase">{{ $inquire->type }}
                                </p>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label class="font-weight-bold">Quote number</label>
                                <p class="form-control-static font-weight-normal">{{ $inquire->quote_number }}</p>
                            </div>
                        </div>
                        @if($inquire->type != 'brand')
                        <div class="col-md-3">
                            <div class="form-group">
                                <label class="font-weight-bold">No Of Brand</label>
                                <p class="form-control-static font-weight-normal">{{ $inquire->no_of_brand }}</p>
                            </div>
                        </div>
                        @endif
                        <div class="col-md-3">
                            <div class="form-group">
                                <label class="font-weight-bold">No Of Supplier</label>
                                <p class="form-control-static font-weight-normal">{{ $inquire->no_of_supplier }}</p>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label class="font-weight-bold">status</label>
                                <p class="form-control-static font-weight-normal">{{ $inquire->status }}</p>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label class="font-weight-bold">Required Field</label>
                                <p class="form-control-static font-weight-normal">
                                @php
                                    $fieldMap = [
                                        'is_generic_name' => 'Generic Name',
                                        'is_brand_name' => 'Brand Name',
                                        'is_pack_size' => 'Pack Size',
                                        'is_manufacturer_name' => 'Manufacturer Name',
                                        'is_gst' => 'GST',
                                        'is_storage_condition' => 'Storage Condition',
                                        'is_product_photo' => 'Product Photo',
                                        'is_product_doc' => 'Product Doc',
                                        'is_vendor_name' => 'Vendor Name',
                                        'is_price_per_pack' => 'Price Per Pack',
                                        'is_expiry' => 'Expiry Date',
                                        'is_lead_time' => 'Lead Time',
                                    ];

                                    $fields = [];
                                    foreach ($fieldMap as $field => $name) {
                                        if ($inquire->$field) {
                                            $fields[] = $name;
                                        }
                                    }

                                    $requiredFieldsName = implode(', ', $fields);
                                @endphp
                                {{ $requiredFieldsName }}
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End Inquire Details -->
                @php
                    $type = $inquire->type === 'generic';
                @endphp
                <div class="card-header">
                    <div class="d-flex justify-content-between align-items-center">
                    <div class="col-6">
                            <h5 class="card-title mb-0">Quotation Details</h5>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <tr>
                                <th class="font-weight-bold">SR NO</th>
                                @if($type === true)
                                <th class="font-weight-bold">Brand Name</th>
                                @else
                                <th class="font-weight-bold">Generic Name</th>
                                @endif
                                <th class="font-weight-bold">Pack Size</th>
                                <th class="font-weight-bold">Manufacturer Name</th>
                                <th class="font-weight-bold">Gst</th>
                                <th class="font-weight-bold">Storage Condition</th>
                                <th class="font-weight-bold">Product Photos</th>
                                <th class="font-weight-bold">Product Documents</th>
                                <th class="font-weight-bold">Supplier Details</th>
                            </tr>
                            <tbody>
                                @php
                                    $sno = 1;
                                @endphp
                                @foreach($quotations as $quotation)
                                <tr>
                                    <td class="font-weight-normal">{{ $sno;  }}</td>
                                    @if($type === true)
                                    <td>
                                        {{ $brands->firstWhere('id', $quotation->brand_id)->name ?? '' }}
                                    </td>
                                    @else
                                    <td class="font-weight-normal">
                                        {{ $generics->firstWhere('id', $quotation->generic_id)->name ?? '' }}
                                    </td>
                                    @endif
                                    <td class="font-weight-normal">
                                        {{ $productVariants->firstWhere('id', $quotation->product_variant_id)->name ?? '' }}
                                    </td>
                                    <td class="font-weight-normal">
                                        {{ $manufacturers->firstWhere('id', $quotation->manufacturer_id)->name ?? '' }}
                                    </td>
                                    <td class="font-weight-normal">{{ $quotation->gst  }}</td>
                                    <td class="font-weight-normal">{{ $quotation->storage_condition  }}</td>
                                    <td class="font-weight-normal">
                                        @foreach($quotation->productPhotos as $photo)
                                        <a href="{{ asset('productPhotos/' . $photo->photo) }}" target="_blank">
                                            <img src="{{ asset('productPhotos/' . $photo->photo) }}" alt="Product Photo"
                                                style="width: 50px; height: 50px; margin-right: 5px;">
                                        </a>
                                        @endforeach
                                    </td>
                                    <td class="font-weight-normal">
                                        @foreach($quotation->productDocuments as $document)
                                        <a href="{{ asset('productDocuments/' . $document->document) }}"
                                            target="_blank">
                                            <i class="feather icon-file-text"></i> View Document
                                        </a><br>
                                        @endforeach
                                    </td>
                                    <td>
                                        <table class="table table-bordered">
                                            <tr>
                                                <th class="font-weight-bold">Vender Name</th>
                                                <th class="font-weight-bold">Price Per Pack</th>
                                                <th class="font-weight-bold">Expiry Date</th>
                                                <th class="font-weight-bold">Lead Time(Days)</th>
                                            </tr>
                                            <tbody>
                                                @foreach($quotation->suppliers as $supplier)
                                                <tr>
                                                    <td class="font-weight-normal">
                                                        {{ $venders->firstWhere('id', $supplier->vender_id)->name ?? '' }}
                                                    </td>
                                                    <td class="font-weight-normal">{{ $supplier->price_per_pack }}</td>
                                                    <td class="font-weight-normal">{{ $supplier->expiry_date }}</td>
                                                    <td class="font-weight-normal">{{ $supplier->lead_time }}</td>
                                                </tr>
                                                @endforeach
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                                @php
                                    $sno++;
                                @endphp
                                @endforeach
                            </tbody>
                        </table>
                    </div>

                    <div class="comments-section">
                        <!-- Input Section -->
                        <div class="comment-input-group">
                            <input 
                                type="text" 
                                class="form-control add-comment" 
                                placeholder="Write your query here..." 
                                aria-label="Add a query" 
                                data-id="{{ $quotation->id }}"
                            >
                            <button 
                                class="btn send-comment" 
                                data-id="{{ $quotation->id }}" data-inquire-id="{{ $inquire->id }}"
                                id="send-comment-btn"
                            >
                                Send
                            </button>
                        </div>
                        <div class="Query-Message"></div>
                        <!-- Comments Listing -->
                        <div class="comments-list" id="comments-{{ $quotation->id }}" role="list">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    @if($inquiryHistory->count() > 0)
    <div class="row">
        <!-- Start col -->
        <div class="col-lg-12">
            <div class="card m-b-30">
                <div class="card-header">
                    <div class="row align-items-center">
                        <div class="col-6">
                            <h5 class="card-title mb-0">History Details</h5>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                    <table class="table table-bordered">
                            @if($inquiryHistory && $inquiryHistory->isNotEmpty())
                                @foreach($inquiryHistory as $history)
                                    <!-- Inquiry History Details -->
                                    <div>
                                        <strong>Created Date:</strong>
                                        {{ \Carbon\Carbon::parse($history->created_at)->format('d F, Y') }} 
                                            <button class="btn btn-primary-rgba showInquire"
                                                data-inquire-id="{{ $history->id }}">
                                                <i class="feather icon-eye"></i>
                                        </button>
                                    </div></br>
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th class="font-weight-bold text-nowrap">Quote No</th>
                                                @if($type !== true)
                                                <th class="font-weight-bold text-nowrap">Inquire Brand Name</th>
                                                @else
                                                <th class="font-weight-bold text-nowrap">Inquire Generic Name</th>
                                                @endif
                                                <th class="font-weight-bold text-nowrap">Quantity</th>
                                                <th class="font-weight-bold text-nowrap">No Of Brand</th>
                                                <th class="font-weight-bold text-nowrap">Status</th>
                                                @if($type === true)
                                                    <th class="font-weight-bold text-nowrap">Brand Name</th>
                                                @else
                                                    <th class="font-weight-bold text-nowrap">Generic Name</th>
                                                @endif
                                                <th class="font-weight-bold text-nowrap">Pack Size</th>
                                                <th class="font-weight-bold text-nowrap">Manufacturer Name</th>
                                                <th class="font-weight-bold text-nowrap">Gst</th>
                                                <th class="font-weight-bold text-nowrap">Storage Condition</th>
                                                <th class="font-weight-bold text-nowrap">Product Photos</th>
                                                <th class="font-weight-bold text-nowrap">Product Documents</th>
                                                <th class="font-weight-bold text-nowrap">No Of Supplier</th>
                                                <th class="font-weight-bold text-nowrap">Supplier Details</th>
                                                <th class="font-weight-bold text-nowrap">Created At</th>
                                                <th class="font-weight-bold text-nowrap">Assigned User</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            @php
                                                $quotationHistoryGroup = $history->quotationHistory; 
                                                $rowCount = $quotationHistoryGroup->count(); 
                                            @endphp
                                            <!-- Quotation History for Each Inquiry -->
                                            @foreach($history->quotationHistory as $index => $quotationHistory)
                                                <tr>
                                                    @if($index === 0)
                                                    <td class="font-weight-normal" rowspan="{{ $rowCount }}">{{ $history->quote_number}}</td>
                                                    @if($type !== true)
                                                    <td class="font-weight-normal" rowspan="{{ $rowCount }}">
                                                        {{ $brands->firstWhere('id', $history->brand_id)->name ?? '' }}
                                                    </td>
                                                    @else
                                                    <td class="font-weight-normal" rowspan="{{ $rowCount }}">
                                                        {{ $generics->firstWhere('id', $history->generic_id)->name ?? '' }}
                                                    </td>
                                                    @endif
                                                    <td class="font-weight-normal" rowspan="{{ $rowCount }}">{{ $history->quantity}}</td>
                                                    <td class="font-weight-normal" rowspan="{{ $rowCount }}">
                                                        @if($history->no_of_brand > 0)
                                                            @php
                                                                $totalBrands = $history->no_of_brand ?? 0;
                                                                $addedBrands = 0;
                                                                foreach ($history->quotationHistory as $quote) {
                                                                    if ($quote->inquire_id === $history->inquire_id) {
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
                                                    <td class="font-weight-normal" rowspan="{{ $rowCount }}">{{ $history->status}}</td>
                                                    @endif
                                                    @if($type === true)
                                                    <td class="font-weight-normal">
                                                        {{ $brands->firstWhere('id', $quotationHistory->brand_id)->name ?? '' }}
                                                    </td>
                                                    @else
                                                    <td class="font-weight-normal">
                                                        {{ $generics->firstWhere('id', $quotationHistory->generic_id)->name ?? '' }}
                                                    </td>
                                                    @endif
                                                    <td class="font-weight-normal">
                                                        {{ $productVariants->firstWhere('id', $quotationHistory->product_variant_id)->name ?? '' }}
                                                    </td>
                                                    <td class="font-weight-normal">
                                                        {{ $manufacturers->firstWhere('id', $quotationHistory->manufacturer_id)->name ?? '' }}
                                                    </td>
                                                    <td class="font-weight-normal">{{ $quotationHistory->gst }}</td>
                                                    <td class="font-weight-normal">{{ $quotationHistory->storage_condition }}</td>
                                                    <td class="font-weight-normal">
                                                        @foreach($quotationHistory->productPhotoHistory as $photo)
                                                            <a href="{{ asset('productPhotos/' . $photo->photo) }}" target="_blank">
                                                                <img src="{{ asset('productPhotos/' . $photo->photo) }}" alt="Product Photo" style="width: 30px; height: 30px; margin-right: 5px;">
                                                            </a>
                                                        @endforeach
                                                    </td>
                                                    <td class="font-weight-normal">
                                                        @foreach($quotationHistory->productDocumentHistory as $document)
                                                            <a href="{{ asset('productDocuments/' . $document->document) }}" target="_blank">
                                                                <i class="feather icon-file-text"></i> View Document
                                                            </a><br>
                                                        @endforeach
                                                    </td>
                                                     <td class="font-weight-normal text-nowrap">
                                                    @if($history->no_of_supplier > 0)
                                                        @php
                                                            $totalSuppliers = $history->no_of_supplier;
                                                            $addedSuppliers = 0;
                                                            if ($quotationHistory->supplierHistory) {
                                                                foreach ($quotationHistory->supplierHistory as $supplier) {
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
                                                    <td class="font-weight-normal">
                                                        <table class="table table-bordered">
                                                            <thead>
                                                                <tr>
                                                                    <th class="font-weight-bold text-nowrap">Vendor Name</th>
                                                                    <th class="font-weight-bold text-nowrap">Price Per Pack</th>
                                                                    <th class="font-weight-bold text-nowrap">Expiry Date</th>
                                                                    <th class="font-weight-bold text-nowrap">Lead Time (Days)</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                @foreach($quotationHistory->supplierHistory as $supplier)
                                                                    <tr>
                                                                        <td class="font-weight-normal">
                                                                            @foreach($venders as $vender)
                                                                                @if($vender->id === $supplier->vender_id)
                                                                                    {{ $vender->name }}
                                                                                @endif
                                                                            @endforeach
                                                                        </td>
                                                                        <td class="font-weight-normal">{{ $supplier->price_per_pack }}</td>
                                                                        <td class="font-weight-normal">{{ $supplier->expiry_date }}</td>
                                                                        <td class="font-weight-normal">{{ $supplier->lead_time }}</td>
                                                                    </tr>
                                                                @endforeach
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                    {{-- Created At --}}
                                                    <td class="font-weight-normal text-nowrap">
                                                        {{ \Carbon\Carbon::parse($quotationHistory->created_at)->setTimezone('Asia/Kolkata')->format('d/m/Y h:i A') }}
                                                    </td>
                                                    @if($index == 0)
                                                            <td class="font-weight-normal" rowspan="{{ $rowCount }}">@foreach($users as $user)
                                                                @if($user->id === $history->assigned_user_id)
                                                                    {{ $user->name }}
                                                                @endif
                                                            @endforeach
                                                        </td>
                                                    @endif
                                                </tr>
                                            @endforeach
                                        </tbody>
                                    </table>
                                @endforeach
                            @else
                                <p>No inquiry history available.</p>
                            @endif
                        </table>
                    </div>
                </div>
            </div>
            <!-- End col -->
        </div>
    </div>
    @endif
    @if($inquireStatusHistory->count() > 0)
    <div class="row">
        <!-- Start col -->
        <div class="col-lg-12">
            <div class="card m-b-30">
                <div class="card-header">
                    <div class="row align-items-center">
                        <div class="col-6">
                            <h5 class="card-title mb-0">Manual Close History Details</h5>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th class="font-weight-bold text-nowrap">SR NO</th>
                                    <th class="font-weight-bold text-nowrap">Quotation Closed Date</th>
                                    <th class="font-weight-bold text-nowrap">Comment</th>
                                    <th class="font-weight-bold text-nowrap">Quotation Closed By</th>
                                </tr>
                            </thead>
                            <tbody>
                                @php
                                    $sno = 1;
                                @endphp
                                @foreach($inquireStatusHistory as $history)
                                    <tr>
                                        <td class="font-weight-normal">
                                            {{ $sno; }}
                                        </td>
                                        <!-- Created Date -->
                                        <td class="font-weight-normal">
                                            {{ \Carbon\Carbon::parse($history->created_at)->format('d F, Y') }}
                                        </td>
                                        <!-- Comment -->
                                        <td class="font-weight-normal">
                                            {{ $history->remarks }}
                                        </td>
                                        <!-- Created By -->
                                        <td class="font-weight-normal">
                                            @php
                                                $userName = $users->firstWhere('id', $history->created_by)?->name ?? 'Unknown User';
                                            @endphp
                                            {{ $userName }}
                                        </td>
                                    </tr>
                                    @php
                                        $sno++;
                                    @endphp
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- End col -->
        </div>
    </div>
    @endif
</div>

 <!--Show inquire modal -->
 <div class="modal fade" id="showInquireModal" tabindex="-1" aria-labelledby="showInquireModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Show Inquiry Details</h5>
                </div>
                <div class="modal-body">
                    <div id="inquireDetailsCard">
                        <!-- Inquiry details will be inserted here -->
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
@endsection

@section('script')
<script src="{{ asset('assets/plugins/select2/select2.min.js') }}"></script>
<script src="{{ asset('assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput.min.js') }}"></script>
<script>
document.addEventListener('DOMContentLoaded', function () {
    // Fetch comments when the page loads
    document.querySelectorAll('.comments-list').forEach((list) => {
        const quotationId = list.id.split('-')[1];
        fetchComments(quotationId);
    });

    // Add comment functionality for "Enter" key
    document.querySelectorAll('.add-comment').forEach((input) => {
        input.addEventListener('keypress', function (e) {
            if (e.key === 'Enter') {
                handleAddComment(e);
            }
        });
    });

    // Handle Send button click
    document.querySelectorAll('.send-comment').forEach((button) => {
        button.addEventListener('click', handleAddComment);
    });

    // Add comment event handler
    function handleAddComment(event) {
        const inputGroup = event.target.closest('.comment-input-group');
        const input = inputGroup.querySelector('.add-comment');
        const commentText = input.value.trim();
        const quotationId = input.dataset.id;

        if (commentText) {
            addComment(quotationId, commentText);
            input.value = ''; // Clear input
        } else {
            $('.Query-Message').html(`</br><div class="alert alert-danger alert-dismissible">
                            <strong>Please enter a query before sending.</strong>
                            <button type="button" class="close"
                                data-dismiss="alert">
                                ×
                            </button>
                        </div>`);
            
        }
    }

    // Fetch comments from the server
    function fetchComments(quotationId) {
        fetch(`/comments/${quotationId}`)
            .then((response) => response.json())
            .then((data) => {
                const list = document.getElementById(`comments-${quotationId}`);
                list.innerHTML = ''; 
                data.forEach((comment) => {
                    list.appendChild(createCommentElement(comment));
                });
            })
            .catch((error) => console.error('Error fetching comments:', error));
    }

    // Add a new comment to the server
    function addComment(quotationId, commentText) {
        const inquireId = document
            .querySelector(`.send-comment[data-id="${quotationId}"]`)
            ?.getAttribute('data-inquire-id');

        if (!inquireId) {
            alert('Inquiry ID not found.');
            return;
        }

        const currentPageUrl = window.location.href; // Get the current page URL

        fetch(`/comments/${quotationId}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
            },
            body: JSON.stringify({
                text: commentText,
                inquire_id: inquireId,
                page_url: currentPageUrl,
            }),
        })
        .then((response) => {
            if (!response.ok) {
                return response.text().then((text) => {
                    throw new Error(`Server Error: ${text}`);
                });
            }
            return response.json();
        })
        .then((data) => {
            if (data.success) {
                const list = document.getElementById(`comments-${quotationId}`);
                list.appendChild(createCommentElement(data.comment)); // Add the new comment
                displaySuccessMessage(data.message);
            } else {
                alert(data.message || 'An error occurred. Please try again.');
            }
        })
        .catch((error) => {
            console.error('Error adding comment:', error);
            alert('An error occurred. Please try again.');
        });
    }

    // Create a comment element
    function createCommentElement(comment) {
        const commentElement = document.createElement('div');
        commentElement.classList.add('comment');
        commentElement.innerHTML = `
            <div class="content">
                <p>${comment.comment}</p>
            </div>
            <div class="metadata">
                <span>Posted by: ${comment.username}</span>
                <span>On: ${formatDate(comment.created_at)}</span>
            </div>
        `;
        return commentElement;
    }

    // Format date to "YYYY-MM-DD HH:MM AM/PM"
    function formatDate(dateString) {
        const options = {
            year: 'numeric',
            month: '2-digit',
            day: '2-digit',
            hour: '2-digit',
            minute: '2-digit',
            hour12: true,
        };
        return new Date(dateString).toLocaleString('en-US', options);
    }

    // Display a success message
    function displaySuccessMessage(message) {
        $('#message').html(
            '<div class="alert alert-success alert-dismissible fade show m-0 mt-3" role="alert">' +
            message +
            '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
            '<span aria-hidden="true">&times;</span>' +
            '</button>' +
            '</div>'
        );

        setTimeout(() => {
            window.location.reload();
        }, 50); // Refresh after 2 seconds
    }
});
</script>
<script>
        $(document).ready(function () {
            $('.showInquire').click(function () {
                var inquireId = $(this).data('inquire-id');
                $('#showInquireModal').modal('show');

                // Clear previous data before fetching new data
                $('#inquireDetailsCard').html('<p class="text-center">Loading...</p>');

                // AJAX Request
                $.ajax({
                    url: '/inquires/' + inquireId + '/showInquireHistory',
                    type: 'GET',
                    success: function (response) {
                        if (response.success) {
                            var inquiry = response.inquiry;
                            var requiredFields = response.requiredFields.join(', '); // Convert array to string

                            // Determine whether to show Brand Name or Generic Name
                            var nameField = inquiry.type === 'brand' 
                                ? `<div class="col-md-6">
                                    <div class="form-group">
                                        <label class="font-weight-bold">Brand Name</label>
                                        <p class="form-control-static font-weight-normal">${inquiry.brand_name || 'N/A'}</p>
                                    </div>
                                </div>`
                                : `<div class="col-md-6">
                                    <div class="form-group">
                                        <label class="font-weight-bold">Generic Name</label>
                                        <p class="form-control-static font-weight-normal">${inquiry.generic_name || 'N/A'}</p>
                                    </div>
                                </div>`;

                            var cardHtml = `
                                <div class="card p-3 shadow-sm">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="font-weight-bold">Quote Number</label>
                                                <p class="form-control-static font-weight-normal">${inquiry.quote_number}</p>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="font-weight-bold">Type</label>
                                                <p class="form-control-static font-weight-normal text-uppercase">${inquiry.type}</p>
                                            </div>
                                        </div>
                                        ${nameField}
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="font-weight-bold">No Of Brand</label>
                                                <p class="form-control-static font-weight-normal">${inquiry.no_of_brand || 'N/A'}</p>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="font-weight-bold">Status</label>
                                                <p class="form-control-static font-weight-normal">${inquiry.status}</p>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="font-weight-bold">Quantity</label>
                                                <p class="form-control-static font-weight-normal">${inquiry.quantity}</p>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="font-weight-bold">No Of Supplier</label>
                                                <p class="form-control-static font-weight-normal">${inquiry.no_of_supplier || 'N/A'}</p>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label class="font-weight-bold">Required Fields</label>
                                                <p class="form-control-static font-weight-normal">${requiredFields}</p>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label class="font-weight-bold">Assigned User</label>
                                                <p class="form-control-static font-weight-normal">${inquiry.assigned_user || 'N/A'}</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            `;

                            $('#inquireDetailsCard').html(cardHtml);
                        } else {
                            $('#inquireDetailsCard').html('<p class="text-center text-danger">No Data Found</p>');
                        }
                    },
                    error: function () {
                        $('#inquireDetailsCard').html('<p class="text-center text-danger">Error Fetching Data</p>');
                    }
                });
            });
        });
    </script>
@endsection
