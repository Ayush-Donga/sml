@extends('layouts.main')

@section('title', 'Add New Quotation')

@section('style')
<!-- Select2 css -->
<link href="{{ asset('assets/plugins/select2/select2.min.css') }}" rel="stylesheet" type="text/css" />
<!-- Tagsinput css -->
<link href="{{ asset('assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput.css') }}" rel="stylesheet"
    type="text/css" />
<link href="{{ asset('assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput-typeahead.css') }}" rel="stylesheet"
    type="text/css" />
<style>
.add-more {
    margin-top: -30px;
}

.remove-supplier-detail {
    margin-top: 26px;
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
                    <li class="breadcrumb-item"><a href="{{url('/')}}">Home</a></li>
                    <li class="breadcrumb-item"><a href="{{url('/quotations')}}">Quotation</a></li>
                    <li class="breadcrumb-item active" aria-current="page">@yield('title')</li>
                </ol>
            </div>
        </div>
        <div class="col-md-4 col-lg-4">
            <div class="widgetbar">
                <a href="{{ route('inquires.index') }}" class="btn btn-primary-rgba btn-back">
                    <i class="ti-arrow-left mr-2"></i>Back</a>
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
<div class="contentbar">
    @php
    $type = $inquire->type === 'generic';
    @endphp
    @can('quotation-create')
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
                                <label class="font-weight-bold">Quote Number</label>
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
                <!-- End Inquire Details  -->
                <div class="card-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="card-title">Add New Quotation</h5>
                        @if($type === true)
                        <button type="button" name="add" id="addMore" class="btn btn-success-rgba add-more-brand">
                            <i class="fa fa-plus"></i> Add More Brand
                        </button>
                        @endif
                    </div>
                </div>
                <div class="card-body">
                    <form method="POST" action="{{ route('quotations.store') }}" enctype="multipart/form-data">
                        <div class="border border-dark rounded p-3 mt-3">
                            <div class="form-row">
                                @csrf
                                <input type="hidden" name="redirect" value="{{ urlencode($redirectUrl) }}">
                                <input type="hidden" name="inquire_id" value="{{ $inquire->id }}">

                               <!-- Brand or Generic Dropdown -->
                                @if($type === true)
                                @if($inquire->is_brand_name === 1)
                                <div class="form-group col-md-3">
                                    <label for="brand_id">Brand Name</label>
                                    <select name="quotation[0][brand_id]" id="brand_id"
                                        class="form-control select2 @error('quotation.0.brand_id') is-invalid @enderror brand" data-placeholder="Select Brand">
                                        <option value="">Select Brand</option>
                                        @foreach($brands as $brand)
                                            @if($brand->status != 0)
                                                <option value="{{ $brand->id }}"
                                                    {{ old('quotation.0.brand_id') == $brand->id ? 'selected' : '' }}>
                                                    {{ $brand->name }}
                                                </option>
                                            @endif
                                        @endforeach
                                    </select>
                                    @error('quotation.0.brand_id')
                                    <div class="text-danger">{{ $message }}</div>
                                    @enderror
                                </div>
                                @endif
                                @else
                                @if($inquire->is_generic_name === 1)
                                <div class="form-group col-md-3">
                                    <label for="generic_id">Generic Name</label>
                                    <select name="quotation[0][generic_id]" id="generic_id"
                                        class="form-control select2 @error('quotation.0.generic_id') is-invalid @enderror" data-placeholder="Select Generic">
                                        <option value="">Select Generic</option>
                                        @foreach($generics as $generic)
                                        <option value="{{ $generic->id }}"
                                            {{ old('quotation.0.generic_id') == $generic->id ? 'selected' : '' }}>
                                            {{ $generic->name }}
                                        </option>
                                        @endforeach
                                    </select>
                                    @error('quotation.0.generic_id')
                                    <div class="text-danger">{{ $message }}</div>
                                    @enderror
                                </div>
                                @endif
                                @endif

                                @if($inquire->is_pack_size === 1)
                                <div class="form-group col-md-3">
                                    <label for="product_variant_id">Pack Size<span class="text-danger">*</span></label>
                                    <select name="quotation[0][product_variant_id]" id="product_variant_id"
                                        class="form-control select2 @error('quotation.0.product_variant_id') is-invalid @enderror">
                                        <option value="">Select Pack Size</option>
                                        @if($type !== true)
                                            @foreach($productVariants as $variant)
                                                @if($variant->status != 0)
                                                    <option value="{{ $variant->id }}"
                                                        {{ old('quotation.0.product_variant_id') == $variant->id ? 'selected' : '' }}>
                                                        {{ $variant->name }}
                                                    </option>
                                                @endif
                                            @endforeach
                                        @else
                                            @foreach($productVariants as $variant)
                                                @if($variant->status != 0)
                                                    <option value="{{ $variant->id }}"
                                                        {{ old('quotation.0.product_variant_id') == $variant->id ? 'selected' : '' }}>
                                                        {{ $variant->name }}
                                                    </option>
                                                @endif
                                            @endforeach
                                        @endif
                                    </select>
                                    @error('quotation.0.product_variant_id')
                                    <div class="text-danger">{{ $message }}</div>
                                    @enderror
                                </div>
                                @endif

                                @if($inquire->is_manufacturer_name === 1)
                                <!-- Manufacturer Dropdown -->
                                <div class="form-group col-md-3">
                                    <label for="manufacturer_id">Manufacturer Name</label>
                                    <select name="quotation[0][manufacturer_id]" id="manufacturer_id"
                                        class="form-control select2 @error('quotation.0.manufacturer_id') is-invalid @enderror">
                                        <option value="">Select Manufacturer</option>
                                        @foreach($manufacturers as $manufacturer)
                                        <option value="{{ $manufacturer->id }}"
                                            {{ old('quotation.0.manufacturer_id') == $manufacturer->id ? 'selected' : '' }}>
                                            {{ $manufacturer->name }}
                                        </option>
                                        @endforeach
                                    </select>
                                    @error('quotation.0.manufacturer_id')
                                    <div class="text-danger">{{ $message }}</div>
                                    @enderror
                                </div>
                                @endif

                                @if($inquire->is_gst === 1)
                                <div class="form-group col-md-3">
                                    <label for="gst">Gst</label>
                                    <input type="text" name="quotation[0][gst]" id="gst" value="{{ old('quotation.0.gst') }}"
                                        class="form-control @error('gst') is-invalid @enderror" placeholder="Enter Gst">
                                    @error('quotation.0.gst')
                                        <div class="text-danger">{{ $message }}</div>
                                    @enderror
                                </div>
                                @endif

                                @if($inquire->is_storage_condition === 1)
                                <div class="form-group col-md-3">
                                    <label for="storage_condition">Storage Condition</label>
                                    <input type="text" name="quotation[0][storage_condition]" id="storage_condition"
                                        value="{{ old('quotation.0.storage_condition') }}"
                                        class="form-control @error('storage_condition') is-invalid @enderror"
                                        placeholder="Enter Storage Condition">
                                    @error('quotation.0.storage_condition')
                                    <div class="text-danger">{{ $message }}</div>
                                    @enderror
                                </div>
                                @endif

                                @if($inquire->is_product_photo === 1)
                                <!-- Product Photos Field -->
                                <div class="form-group col-md-3">
                                    <label for="product_photos">Product Photos</label>
                                    <input type="file" name="quotation[0][product_photos][]" id="product_photos"
                                        class="form-control-file @error('product_photos.*') is-invalid @enderror"
                                        accept="image/*" multiple>
                                    @error('product_photos.*')
                                    <div class="text-danger">{{ $message }}</div>
                                    @enderror
                                    <div id="photoPreviews" class="mt-2"></div>
                                </div>
                                @endif

                                @if($inquire->is_product_doc === 1)
                                <!-- Product Documents Field -->
                                <div class="form-group col-md-3">
                                    <label for="product_documents">Product Documents</label>
                                    <input type="file" name="quotation[0][product_documents][]" id="product_documents"
                                        class="form-control-file @error('product_documents.*') is-invalid @enderror"
                                        accept=".pdf,.doc,.docx" multiple>
                                    @error('product_documents.*')
                                    <div class="text-danger">{{ $message }}</div>
                                    @enderror
                                    <div id="documentList" class="mt-2"></div>
                                </div>
                                @endif

                            </div>
                            <hr class="border-dark">
                            <div class="supplier-section">
                                <h5>Supplier Details</h5>
                                <div class="form-group mb-0">
                                    <div class="d-flex justify-content-end">
                                        <button type="button" id="add-supplier-detail"
                                            class="btn btn-success-rgba add-more">
                                            <i class="fa fa-plus"></i> Supplier
                                        </button>
                                    </div>
                                </div>
                                    <!-- Supplier detail rows will be added here -->
                                    <div id="supplier-details-container">
                                        @php
                                            // Safely fetch the old supplier array if it exists:
                                            $oldSuppliers = old('quotation.0.supplier', []);
                                        @endphp
                                        
                                        @if(!empty($oldSuppliers))
                                            {{-- We have old supplier data from a previous form submit --}}

                                            @foreach($oldSuppliers as $supplierIndex => $supplierData)
                                                <div class="row mb-2">
                                                    @if($inquire->is_vendor_name === 1)
                                                        <div class="col-md-2">
                                                            <div class="form-group">
                                                                <label for="vender_id_{{ $supplierIndex }}">Vendor</label>
                                                                <select name="quotation[0][supplier][{{ $supplierIndex }}][vender_id]"
                                                                        id="vender_id_{{ $supplierIndex }}"
                                                                        class="form-control select2">
                                                                    <option value="">Select Vendor</option>
                                                                    @foreach($venders as $vender)
                                                                        <option value="{{ $vender->id }}"
                                                                            {{ (old("quotation.0.supplier.{$supplierIndex}.vender_id") == $vender->id) ? 'selected' : '' }}>
                                                                            {{ $vender->name }}
                                                                        </option>
                                                                    @endforeach
                                                                </select>
                                                            </div>
                                                        </div>
                                                    @endif

                                                    @if($inquire->is_price_per_pack === 1)
                                                        <div class="col-md-2">
                                                            <div class="form-group">
                                                                <label for="price_per_pack_{{ $supplierIndex }}">Price Per Pack <span class="text-danger">*</span></label>
                                                                <input type="text"
                                                                    name="quotation[0][supplier][{{ $supplierIndex }}][price_per_pack]"
                                                                    id="price_per_pack_{{ $supplierIndex }}"
                                                                    class="form-control"
                                                                    placeholder="Enter Price Per Pack"
                                                                    value="{{ old("quotation.0.supplier.{$supplierIndex}.price_per_pack") }}">
                                                                @error("quotation.0.supplier.{$supplierIndex}.price_per_pack")
                                                                    <div class="text-danger">{{ $message }}</div>
                                                                @enderror
                                                            </div>
                                                        </div>
                                                    @endif

                                                    @if($inquire->is_expiry === 1)
                                                        <div class="col-md-2">
                                                            <div class="form-group mb-0">
                                                                <label for="expiry_date_{{ $supplierIndex }}">Expiry Date (Month and Year)
                                                                    <span class="text-danger">*</span>
                                                                </label>
                                                                <input type="month"
                                                                    name="quotation[0][supplier][{{ $supplierIndex }}][expiry_date]"
                                                                    value="{{ old("quotation.0.supplier.{$supplierIndex}.expiry_date") }}"
                                                                    id="expiry_date_{{ $supplierIndex }}"
                                                                    class="form-control">
                                                                @error("quotation.0.supplier.{$supplierIndex}.expiry_date")
                                                                    <div class="text-danger">{{ $message }}</div>
                                                                @enderror
                                                            </div>
                                                        </div>
                                                    @endif

                                                    @if($inquire->is_lead_time === 1)
                                                        <div class="col-md-2">
                                                            <div class="form-group mb-0">
                                                                <label for="lead_time_{{ $supplierIndex }}">Lead Time (Days)
                                                                    <span class="text-danger">*</span>
                                                                </label>
                                                                <input type="text"
                                                                    name="quotation[0][supplier][{{ $supplierIndex }}][lead_time]"
                                                                    id="lead_time_{{ $supplierIndex }}"
                                                                    class="form-control"
                                                                    placeholder="Enter Lead Time (Days)"
                                                                    value="{{ old("quotation.0.supplier.{$supplierIndex}.lead_time") }}">
                                                                @error("quotation.0.supplier.{$supplierIndex}.lead_time")
                                                                    <div class="text-danger">{{ $message }}</div>
                                                                @enderror
                                                            </div>
                                                        </div>
                                                    @endif
                                                    
                                                    @if($supplierIndex !== 0)
                                                    <div class="col-md-2">
                                                        <div class="form-group mb-0">
                                                            <button type="button" class="btn btn-danger remove-supplier-detail-old" style="margin-top: 26px;">
                                                                <i class="fa fa-minus" aria-hidden="true"></i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                    @endif
                                                </div>
                                            @endforeach

                                        @else
                                            {{-- No old supplier data: Show one default row if you wish --}}
                                            <div class="row mb-2">
                                                @if($inquire->is_vendor_name === 1)
                                                    <div class="col-md-2">
                                                        <div class="form-group">
                                                            <label for="vender_id_0">Vendor</label>
                                                            <select name="quotation[0][supplier][0][vender_id]" id="vender_id_0"
                                                                    class="form-control select2">
                                                                <option value="">Select Vendor</option>
                                                                @foreach($venders as $vender)
                                                                    <option value="{{ $vender->id }}">
                                                                        {{ $vender->name }}
                                                                    </option>
                                                                @endforeach
                                                            </select>
                                                        </div>
                                                    </div>
                                                @endif

                                                @if($inquire->is_price_per_pack === 1)
                                                    <div class="col-md-2">
                                                        <div class="form-group">
                                                            <label for="price_per_pack_0">Price Per Pack <span class="text-danger">*</span></label>
                                                            <input type="text"
                                                                name="quotation[0][supplier][0][price_per_pack]"
                                                                id="price_per_pack_0"
                                                                class="form-control"
                                                                placeholder="Enter Price Per Pack">
                                                        </div>
                                                    </div>
                                                @endif

                                                @if($inquire->is_expiry === 1)
                                                    <div class="col-md-2">
                                                        <div class="form-group mb-0">
                                                            <label for="expiry_date_0">Expiry Date (Month and Year)
                                                                <span class="text-danger">*</span>
                                                            </label>
                                                            <input type="month"
                                                                name="quotation[0][supplier][0][expiry_date]"
                                                                id="expiry_date_0"
                                                                class="form-control">
                                                        </div>
                                                    </div>
                                                @endif

                                                @if($inquire->is_lead_time === 1)
                                                    <div class="col-md-2">
                                                        <div class="form-group mb-0">
                                                            <label for="lead_time_0">Lead Time (Days)
                                                                <span class="text-danger">*</span>
                                                            </label>
                                                            <input type="text"
                                                                name="quotation[0][supplier][0][lead_time]"
                                                                id="lead_time_0"
                                                                class="form-control"
                                                                placeholder="Enter Lead Time (Days)">
                                                        </div>
                                                    </div>
                                                @endif
                                            </div>
                                        @endif
                                    </div>
                            </div>
                        </div>

                        @php
                            $oldQuotations = old('quotation', []);
                        @endphp

                        @if (!empty($oldQuotations))
                            </br>
                            @foreach ($oldQuotations as $index => $quotation)
                                @if ($index !== 0)
                                    <div class="quotation-row border border-dark rounded p-3 mb-3">
                                        <div class="row">
                                            <div class="col-md-12 text-right">
                                                <!-- Remove Button -->
                                                <button type="button" class="btn btn-danger remove-brand-detail-old" data-brand-index="{{ $index }}">
                                                    <i class="fa fa-minus"></i> Remove Brand
                                                </button>
                                            </div>
                                            @if ($inquire->is_brand_name === 1)
                                                <div class="form-group col-md-3">
                                                    <label for="brand_id_{{ $index }}">Brand Name</label>
                                                    <select name="quotation[{{ $index }}][brand_id]" id="brand_id_{{ $index }}"
                                                        class="form-control select2">
                                                        <option value="">Select Brand</option>
                                                        @foreach ($brands as $brand)
                                                            <option value="{{ $brand->id }}" {{ ($quotation['brand_id'] ?? '') == $brand->id ? 'selected' : '' }}>
                                                                {{ $brand->name }}
                                                            </option>
                                                        @endforeach
                                                    </select>
                                                </div>
                                            @endif

                                            @if ($inquire->is_generic_name === 1)
                                                <div class="form-group col-md-3">
                                                    <label for="generic_id_{{ $index }}">Generic Name</label>
                                                    <select name="quotation[{{ $index }}][generic_id]" id="generic_id_{{ $index }}"
                                                        class="form-control select2">
                                                        <option value="">Select Generic</option>
                                                        @foreach ($generics as $generic)
                                                            <option value="{{ $generic->id }}" {{ ($quotation['generic_id'] ?? '') == $generic->id ? 'selected' : '' }}>
                                                                {{ $generic->name }}
                                                            </option>
                                                        @endforeach
                                                    </select>
                                                </div>
                                            @endif

                                            @if ($inquire->is_pack_size === 1)
                                                <div class="form-group col-md-3">
                                                    <label for="product_variant_id_{{ $index }}">Pack Size<span class="text-danger">*</span></label>
                                                    <select name="quotation[{{ $index }}][product_variant_id]" id="product_variant_id_{{ $index }}"
                                                        class="form-control select2">
                                                        <option value="">Select Pack Size</option>
                                                        @foreach ($productVariants as $variant)
                                                            <option value="{{ $variant->id }}" {{ ($quotation['product_variant_id'] ?? '') == $variant->id ? 'selected' : '' }}>
                                                                {{ $variant->name }}
                                                            </option>   
                                                        @endforeach
                                                    </select>
                                                    @error("quotation.{$index}.product_variant_id")
                                                        <div class="text-danger">{{ $message }}</div>
                                                    @enderror
                                                </div>
                                            @endif

                                            @if ($inquire->is_manufacturer_name === 1)
                                                <div class="form-group col-md-3">
                                                    <label for="manufacturer_id_{{ $index }}">Manufacturer Name</label>
                                                    <select name="quotation[{{ $index }}][manufacturer_id]" id="manufacturer_id_{{ $index }}"
                                                        class="form-control select2">
                                                        <option value="">Select Manufacturer</option>
                                                        @foreach ($manufacturers as $manufacturer)
                                                            <option value="{{ $manufacturer->id }}" {{ ($quotation['manufacturer_id'] ?? '') == $manufacturer->id ? 'selected' : '' }}>
                                                                {{ $manufacturer->name }}
                                                            </option>
                                                        @endforeach
                                                    </select>
                                                </div>
                                            @endif

                                            @if ($inquire->is_gst === 1)
                                                <div class="form-group col-md-3">
                                                    <label for="gst_{{ $index }}">GST</label>
                                                    <input type="text" name="quotation[{{ $index }}][gst]" id="gst_{{ $index }}"
                                                        class="form-control" value="{{ $quotation['gst'] ?? '' }}" placeholder="Enter GST">
                                                    @error("quotation.{$index}.gst")
                                                        <div class="text-danger">{{ $message }}</div>
                                                    @enderror
                                                </div>
                                            @endif

                                            @if ($inquire->is_storage_condition === 1)
                                                <div class="form-group col-md-3">
                                                    <label for="storage_condition_{{ $index }}">Storage Condition</label>
                                                    <input type="text" name="quotation[{{ $index }}][storage_condition]" id="storage_condition_{{ $index }}"
                                                        class="form-control" value="{{ $quotation['storage_condition'] ?? '' }}" placeholder="Enter Storage Condition">
                                                    @error("quotation.{$index}.storage_condition")
                                                        <div class="text-danger">{{ $message }}</div>
                                                    @enderror
                                                </div>
                                            @endif

                                            @if($inquire->is_product_photo === 1)
                                            <!-- Product Photos Field -->
                                            <div class="form-group col-md-3">
                                                <label for="product_photos_{{ $index }}">Product Photos</label>
                                                <input type="file" name="quotation[{{ $index }}][product_photos][]" id="product_photos_{{ $index }}"
                                                    class="form-control-file product-photos-input"
                                                    accept="image/*" multiple data-preview-container="photoPreviews_{{ $index }}">
                                                
                                                <div id="photoPreviews_{{ $index }}" class="mt-2">
                                                    @if(old("quotation.{$index}.product_photos"))
                                                        @foreach(old("quotation.{$index}.product_photos") as $photo)
                                                            <div class="photo-preview" style="display: inline-block; margin-right: 10px;">
                                                                <img src="{{ asset('productPhotos/' . $photo) }}" alt="Product Photo" 
                                                                    class="img-thumbnail" style="width: 50px; height: 50px; object-fit: cover;">
                                                            </div>
                                                        @endforeach
                                                    @endif
                                                </div>
                                            </div>
                                            @endif

                                            @if($inquire->is_product_doc === 1)
                                                <!-- Product Documents Field -->
                                                <div class="form-group col-md-3">
                                                    <label for="product_documents_{{ $index }}">Product Documents</label>
                                                    <input type="file" name="quotation[{{ $index }}][product_documents][]" id="product_documents_{{ $index }}"
                                                        class="form-control-file product-documents-input"
                                                        accept=".pdf,.doc,.docx" multiple data-preview-container="documentList_{{ $index }}">
                                                    
                                                    <div id="documentList_{{ $index }}" class="mt-2">
                                                        @if(old("quotation.{$index}.product_documents"))
                                                            @foreach(old("quotation.{$index}.product_documents") as $document)
                                                                <div class="document-preview" style="margin-bottom: 5px;">
                                                                    <p style="display: inline;">{{ $document }}</p>
                                                                </div>
                                                            @endforeach
                                                        @endif
                                                    </div>
                                                </div>
                                            @endif
                                        </div>

                                        <!-- Supplier Section -->
                                        <hr class="border-dark">
                                        <div class="supplier-section">
                                            <h5>Supplier Details</h5>
                                            <div class="form-group mb-0">
                                                <div class="d-flex justify-content-end">
                                                <button type="button" 
                                                        class="btn btn-success-rgba add-supplier-detail" 
                                                        data-brand-index="{{ $index }}">
                                                    <i class="fa fa-plus"></i> Supplier
                                                </button>
                                                </div>
                                            </div>
                                            <div class="supplier-details-container" data-brand-index="{{ $index }}">
                                                <div class="row mb-2"> 
                                                    @foreach (($quotation['supplier'] ?? []) as $supplierIndex => $supplierData)
                                                            @if ($inquire->is_vendor_name === 1)
                                                                <div class="col-md-2">
                                                                    <div class="form-group">
                                                                        <label for="vender_id_{{ $index }}_{{ $supplierIndex }}">Vendor</label>
                                                                        <select name="quotation[{{ $index }}][supplier][{{ $supplierIndex }}][vender_id]"
                                                                            id="vender_id_{{ $index }}_{{ $supplierIndex }}" class="form-control select2">
                                                                            <option value="">Select Vendor</option>
                                                                            @foreach ($venders as $vender)
                                                                                <option value="{{ $vender->id }}" {{ ($supplierData['vender_id'] ?? '') == $vender->id ? 'selected' : '' }}>
                                                                                    {{ $vender->name }}
                                                                                </option>
                                                                            @endforeach
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            @endif

                                                            @if ($inquire->is_price_per_pack === 1)
                                                                <div class="col-md-2">
                                                                    <div class="form-group">
                                                                        <label for="price_per_pack_{{ $index }}_{{ $supplierIndex }}">Price Per Pack<span class="text-danger">*</span></label>
                                                                        <input type="text" name="quotation[{{ $index }}][supplier][{{ $supplierIndex }}][price_per_pack]"
                                                                            id="price_per_pack_{{ $index }}_{{ $supplierIndex }}" class="form-control"
                                                                            value="{{ $supplierData['price_per_pack'] ?? '' }}" placeholder="Enter Price Per Pack">
                                                                        @error("quotation.{$index}.supplier.{$supplierIndex}.price_per_pack")
                                                                            <div class="text-danger">{{ $message }}</div>
                                                                        @enderror
                                                                    </div>
                                                                </div>
                                                            @endif

                                                            @if ($inquire->is_expiry === 1)
                                                                <div class="col-md-2">
                                                                    <div class="form-group">
                                                                        <label for="expiry_date_{{ $index }}_{{ $supplierIndex }}">Expiry Date<span class="text-danger">*</span></label>
                                                                        <input type="month" name="quotation[{{ $index }}][supplier][{{ $supplierIndex }}][expiry_date]"
                                                                            id="expiry_date_{{ $index }}_{{ $supplierIndex }}" class="form-control"
                                                                            value="{{ $supplierData['expiry_date'] ?? '' }}">
                                                                        @error("quotation.{$index}.supplier.{$supplierIndex}.expiry_date")
                                                                            <div class="text-danger">{{ $message }}</div>
                                                                        @enderror
                                                                    </div>
                                                                </div>
                                                            @endif

                                                            @if ($inquire->is_lead_time === 1)
                                                                <div class="col-md-2">
                                                                    <div class="form-group">
                                                                        <label for="lead_time_{{ $index }}_{{ $supplierIndex }}">Lead Time (Days)<span class="text-danger">*</span></label>
                                                                        <input type="text" name="quotation[{{ $index }}][supplier][{{ $supplierIndex }}][lead_time]"
                                                                            id="lead_time_{{ $index }}_{{ $supplierIndex }}" class="form-control"
                                                                            value="{{ $supplierData['lead_time'] ?? '' }}" placeholder="Enter Lead Time(Days)">
                                                                        @error("quotation.{$index}.supplier.{$supplierIndex}.lead_time")
                                                                            <div class="text-danger">{{ $message }}</div>
                                                                        @enderror
                                                                    </div>
                                                                </div>
                                                            @endif
                                                            <div class="col-md-2">
                                                                <div class="form-group mb-0">
                                                                    <button type="button" class="btn btn-danger remove-supplier-detail-old" style="margin-top: 26px;">
                                                                        <i class="fa fa-minus" aria-hidden="true"></i>
                                                                    </button>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-2">
                                                                <div class="form-group mb-0">
                                                                
                                                                </div>
                                                            </div>
                                                    @endforeach
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                @endif
                            @endforeach
                        @endif

                        <div class="brand-container">
                            <div class="brand-details">
                        
                            </div>
                        </div>

                        <!-- Submit and Cancel Buttons -->
                        <div class="mt-3">
                            <button type="submit" class="btn btn-primary-rgba mr-3"
                                onclick="this.disabled=true; this.innerText='Submitting...'; this.form.submit();">Submit</button>
                            <a href="{{ route('inquires.index') }}" class="btn btn-danger-rgba btn-cancel">
                                Cancel
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    @endcan

    <div class="row">
        <!-- Start col -->
        <div class="col-lg-12">
            <div class="card m-b-30">
                <div class="card-header">
                    <div class="row align-items-center">
                        <div class="col-6">
                            <h5 class="card-title mb-0">All Quotations</h5>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        @php
                            $sno = $inquires->firstItem() ?? 1;
                        @endphp
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
                                <th class="font-weight-bold">Action</th>
                            </tr>
                            <tbody>
                                @forelse($inquires as $inquire)
                                    @php
                                        $quotationGroup = $inquire->quotations; 
                                        $rowCount = $quotationGroup->count(); 
                                    @endphp
                                    @foreach($quotationGroup as $index => $quotation)
                                        <tr>
                                            @if($index === 0)
                                                <td class="font-weight-normal" rowspan="{{ $rowCount }}">{{ $sno }}</td>
                                                @php $sno++; @endphp
                                            @endif
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
                                            <td class="font-weight-normal">{{ $quotation->gst }}</td>
                                            <td class="font-weight-normal">{{ $quotation->storage_condition }}</td>
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
                                                    <a href="{{ asset('productDocuments/' . $document->document) }}" target="_blank">
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
                                                            @php
                                                                $sno++;
                                                            @endphp
                                                        @endforeach
                                                    </tbody>
                                                </table>
                                            </td>
                                            @if($index === 0)
                                                <td rowspan="{{ $rowCount }}">
                                                    @can('quotation-edit')
                                                        <a href="{{ route('quotations.edit', ['quotation' => $quotation->inquire_id, 'redirect' => urlencode(url()->full())]) }}"
                                                            class="btn btn-success-rgba"><i class="feather icon-edit-2"></i></a>
                                                    @endcan
                                                </td>
                                            @endif
                                        </tr>
                                    @endforeach
                                @empty
                                    <tr>
                                        <td colspan="10" class="text-center">No records found.</td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>
                         <!-- History -->
                          <label>
                              <strong>History Details:</strong>
                          </label>
                         
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

    <!-- Quotation delete modal -->
    <div class="modal fade" id="deleteQuotationModal" tabindex="-1" aria-labelledby="deleteQuotationModalLabel"
        aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteQuotationModalLabel">Quotation delete confirmation</h5>
                </div>
                <div class="modal-body">
                    <span>Are you sure you want to delete?</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal">No</button>
                    <button type="button" class="btn btn-outline-danger confirm-delete">Yes</button>
                </div>
            </div>
        </div>
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
    <script src="{{ asset('assets/js/custom/custom-switchery.js') }}"></script>
    <script src="{{ asset('assets/plugins/select2/select2.min.js') }}"></script>
    <script src="{{ asset('assets/plugins/bootstrap-tagsinput/bootstrap-tagsinput.min.js') }}"></script>
    <script src="{{ asset('assets/plugins/bootstrap-tagsinput/typeahead.bundle.js') }}"></script>
    <script src="{{ asset('assets/js/custom/custom-form-select.js') }}"></script>
    <script src="{{ asset('assets/plugins/validatejs/validate.min.js') }}"></script>
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
    function initializeSelect2() {
            $('.select2').select2({
                placeholder: function () {
                    return $(this).data('placeholder');
                },
                allowClear: true, // Enables clear button
            });
        }
         // Call Select2 initializer on page load
         initializeSelect2();

        document.addEventListener('DOMContentLoaded', function() {
            var supplierIndex = 1; // Start index for supplier details

            function addSupplierDetail() {
                var supplierDetailsContainer = document.getElementById('supplier-details-container');
                var newRow = document.createElement('div');
                newRow.className = 'supplier-detail-row row mb-2'; // Ensure this matches the existing row class

                newRow.innerHTML = `
                @if($inquire->is_vendor_name === 1)
                <div class="col-md-2">
                    <div class="form-group">
                        <label for="vender_id_${supplierIndex}">Vendor</label>
                        <select name="quotation[0][supplier][${supplierIndex}][vender_id]" id="vender_id_0_${supplierIndex}" class="form-control select2">
                            <option value="">Select Vendor</option> 
                            @foreach($venders as $vender)
                                <option value="{{ $vender->id }}">{{ $vender->name }}</option>
                            @endforeach
                        </select>
                    </div>
                </div>
                @endif
                @if($inquire->is_price_per_pack === 1)
                <div class="col-md-2">
                    <div class="form-group">
                        <label for="price_per_pack_${supplierIndex}">Price Per Pack</label>
                        <input type="text" name="quotation[0][supplier][${supplierIndex}][price_per_pack]" id="price_per_pack_0_${supplierIndex}"
                            class="form-control" placeholder="Enter Price Per Pack">
                    </div>
                </div>
                @endif
                @if($inquire->is_expiry === 1)
                <div class="col-md-2">
                    <div class="form-group mb-0">
                        <label for="expiry_date_${supplierIndex}">Expiry Date (Month and Year)</label>
                        <input type="month" name="quotation[0][supplier][${supplierIndex}][expiry_date]" id="expiry_date_0_${supplierIndex}"
                            class="form-control">
                    </div>
                </div>
                @endif
                @if($inquire->is_lead_time === 1)
                <div class="col-md-2">
                    <div class="form-group mb-0">
                        <label for="lead_time_${supplierIndex}">Lead Time(Days)</label>
                        <input type="text" name="quotation[0][supplier][${supplierIndex}][lead_time]" id="lead_time_0_${supplierIndex}" class="form-control"
                            placeholder="Enter Lead Time(Days)">
                    </div>
                </div>
                @endif
                <div class="col-md-2">
                    <div class="form-group mb-0">
                        <button type="button" class="btn btn-danger remove-supplier-detail"><i class="fa fa-minus" aria-hidden="true"></i></button>
                    </div>
                </div>
            `;

                supplierDetailsContainer.appendChild(newRow);

                // Reinitialize Select2 for the newly added elements
                initializeSelect2();
                
                supplierIndex++;
            }

            document.getElementById('add-supplier-detail').addEventListener('click', addSupplierDetail);

            document.getElementById('supplier-details-container').addEventListener('click', function(e) {
                if (e.target && e.target.closest('.remove-supplier-detail')) {
                    e.target.closest('.supplier-detail-row').remove();
                }
            });

        });
    </script>

    <script>
    document.getElementById('product_photos').addEventListener('change', function(event) {
        var previewContainer = document.getElementById('photoPreviews');
        previewContainer.innerHTML = ''; // Clear previous previews

        var files = Array.from(event.target.files);
        files.forEach(function(file) {
            if (file.type.startsWith('image/')) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    var div = document.createElement('div');
                    div.classList.add('photo-preview');
                    div.style.display = 'inline-block';
                    div.style.marginRight = '10px'; // Adjust spacing as needed

                    var img = document.createElement('img');
                    img.classList.add('img-thumbnail');
                    img.style.width = '50px'; // Adjust size as needed
                    img.style.height = '50px'; // Adjust size as needed
                    img.style.objectFit = 'cover'; // Ensure image fits well in the box
                    img.src = e.target.result;
                    div.appendChild(img);

                    var removeButton = document.createElement('button');
                    removeButton.innerHTML =
                        '<i class="fa fa-times" aria-hidden="true"></i>'; // Use 'fa-times' for a better icon
                    removeButton.type = 'button';
                    removeButton.classList.add('btn', 'btn-danger', 'btn-sm');
                    removeButton.style.marginLeft = '5px'; // Space between image and button
                    removeButton.style.padding = '2px 5px'; // Smaller padding
                    removeButton.style.fontSize = '12px'; // Smaller font size
                    removeButton.onclick = function() {
                        previewContainer.removeChild(div);
                        // Update file input to remove the file
                        var dataTransfer = new DataTransfer();
                        files = files.filter(f => f !== file); // Remove the file from the list
                        files.forEach(f => dataTransfer.items.add(f));
                        document.getElementById('product_photos').files = dataTransfer.files;
                    };
                    div.appendChild(removeButton);
                    previewContainer.appendChild(div);
                };
                reader.readAsDataURL(file);
            }
        });
    });

    document.getElementById('product_documents').addEventListener('change', function(event) {
        var documentListContainer = document.getElementById('documentList');
        documentListContainer.innerHTML = ''; // Clear previous document names

        var files = Array.from(event.target.files);
        files.forEach(function(file) {
            var div = document.createElement('div');
            div.classList.add('document-preview');
            div.style.marginBottom = '5px'; // Space between document entries

            var fileName = document.createElement('p');
            fileName.textContent = file.name;
            fileName.style.display = 'inline'; // Keep file name on the same line
            div.appendChild(fileName);

            var removeButton = document.createElement('button');
            removeButton.innerHTML =
                '<i class="fa fa-times" aria-hidden="true"></i>'; // Use 'fa-times' for a better icon
            removeButton.type = 'button';
            removeButton.classList.add('btn', 'btn-danger', 'btn-sm');
            removeButton.style.marginLeft = '10px'; // Space between file name and button
            removeButton.style.padding = '2px 5px'; // Smaller padding
            removeButton.style.fontSize = '12px'; // Smaller font size
            removeButton.onclick = function() {
                documentListContainer.removeChild(div);
                // Update file input to remove the file
                var dataTransfer = new DataTransfer();
                files = files.filter(f => f !== file); // Remove the file from the list
                files.forEach(f => dataTransfer.items.add(f));
                document.getElementById('product_documents').files = dataTransfer.files;
            };
            div.appendChild(removeButton);
            documentListContainer.appendChild(div);
        });
    });
    </script>

    <script>
    $(document).ready(function() {
        let brandIndex = 0; // Initialize brand index
        let supplierIndices = {}; // To keep track of supplier index for each brand

        function initializeSelect2() {
            $('.select2').select2({
                placeholder: function () {
                    return $(this).data('placeholder');
                },
                allowClear: true, // Enables clear button
            });
        }

        // Call Select2 initializer on page load
        initializeSelect2();

        // Use event delegation for dynamically added brand dropdowns
        $(document).on('change', '.brand', function () {
            let brandId = $(this).val();
            // let packSizeDropdown = $(this).closest('.form-row').find('.pack-size');
            let packSizeDropdown = $(`#product_variant_id_${brandIndex}`);

            // Clear the existing options
            packSizeDropdown.empty();
            packSizeDropdown.append('<option value="">Select Pack Size</option>');

            if (brandId) {
                // Make an AJAX request to get the pack sizes
                $.ajax({
                    url: `/get-pack-sizes/${brandId}`,
                    type: 'GET',
                    success: function (response) {
                        // Populate the pack size dropdown
                        $.each(response, function (key, value) {
                            packSizeDropdown.append(
                                `<option value="${value.id}">${value.name}</option>`
                            );
                        });
                    },
                    error: function (error) {
                        console.error('Error fetching pack sizes:', error);
                    }
                });
            }
        });
        
        // Add More Brand Detail
        $('.add-more-brand').click(function() {
            brandIndex++;
            supplierIndices[brandIndex] = 0; // Initialize supplier index for this brand

            let newBrandDetail = `
                <div class="brand-detail brand-detail-${brandIndex}">
                    <div class="border border-dark rounded p-3 mt-3">
                    <!-- New Brand Detail -->
                       <div class="form-row">
                        <div class="col-md-12 text-right">
                            <!-- Remove Button -->
                            <button type="button" class="btn btn-danger remove-brand-detail" data-brand-index="${brandIndex}">
                                <i class="fa fa-minus"></i> Remove Brand
                            </button>
                        </div>

                        @if($type === true)
                        @if($inquire->is_brand_name === 1)
                        <div class="form-group col-md-3">
                            <label for="brand_id_${brandIndex}">Brand Name</label>
                            <select name="quotation[${brandIndex}][brand_id]" id="brand_id_${brandIndex}" class="form-control select2 brand @error('brand_id_${brandIndex}') is-invalid @enderror">
                                <option value="">Select Brand</option>
                                @foreach($brands as $brand)
                                    @if($brand->status != 0)
                                        <option value="{{ $brand->id }}" {{ old('brand_id_${brandIndex}') == $brand->id ? 'selected' : '' }}>
                                            {{ $brand->name }}
                                        </option>
                                    @endif
                                @endforeach
                            </select>
                            @error('brand_id_${brandIndex}')
                            <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>
                        @endif
                        @else
                        @if($inquire->is_generic_name === 1)
                        <div class="form-group col-md-3">
                            <label for="generic_id_${brandIndex}">Generic Name</label>
                            <select name="quotation[${brandIndex}][generic_id]" id="generic_id_${brandIndex}" class="form-control select2 @error('generic_id_${brandIndex}') is-invalid @enderror">
                                <option value="">Select Generic</option>
                                @foreach($generics as $generic)
                                <option value="{{ $generic->id }}" {{ old('generic_id_${brandIndex}') == $generic->id ? 'selected' : '' }}>
                                    {{ $generic->name }}
                                </option>
                                @endforeach
                            </select>
                            @error('generic_id_${brandIndex}')
                            <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>
                        @endif
                        @endif

                        @if($inquire->is_pack_size === 1)
                        <div class="form-group col-md-3">
                            <label for="product_variant_id_${brandIndex}">Pack Size<span class="text-danger">*</span></label>
                            <select name="quotation[${brandIndex}][product_variant_id]" id="product_variant_id_${brandIndex}" class="form-control select2 @error('product_variant_id_${brandIndex}') is-invalid @enderror">
                                <option value="">Select Pack Size</option>
                                 @if($type !== true)
                                    @foreach($productVariants as $variant)
                                    <option value="{{ $variant->id }}" {{ old('product_variant_id_${brandIndex}') == $variant->id ? 'selected' : '' }}>
                                        {{ $variant->name }}
                                    </option>
                                    @endforeach
                                @endif
                            </select>
                            @error('product_variant_id_${brandIndex}')
                            <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>
                        @endif

                        @if($inquire->is_manufacturer_name === 1)
                        <!-- Manufacturer Dropdown -->
                        <div class="form-group col-md-3">
                            <label for="manufacturer_id_${brandIndex}">Manufacturer Name</label>
                            <select name="quotation[${brandIndex}][manufacturer_id]" id="manufacturer_id_${brandIndex}" class="form-control select2 @error('manufacturer_id_${brandIndex}') is-invalid @enderror">
                                <option value="">Select Manufacturer</option>
                                @foreach($manufacturers as $manufacturer)
                                <option value="{{ $manufacturer->id }}" {{ old('manufacturer_id_${brandIndex}') == $manufacturer->id ? 'selected' : '' }}>
                                    {{ $manufacturer->name }}
                                </option>
                                @endforeach
                            </select>
                            @error('manufacturer_id_${brandIndex}')
                            <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>
                        @endif

                        @if($inquire->is_gst === 1)
                        <div class="form-group col-md-3">
                            <label for="gst_${brandIndex}">Gst</label>
                            <input type="text" name="quotation[${brandIndex}][gst]" id="gst_${brandIndex}" value="{{ old('gst_${brandIndex}') }}" class="form-control @error('gst_${brandIndex}') is-invalid @enderror" placeholder="Enter Gst">
                            @error('gst_${brandIndex}')
                            <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>  
                        @endif

                        @if($inquire->is_storage_condition === 1)
                        <div class="form-group col-md-3">
                            <label for="storage_condition[]">Storage Condition</label>
                            <input type="text" name="quotation[${brandIndex}][storage_condition]" id="storage_condition_${brandIndex}" value="{{ old('storage_condition_${brandIndex}') }}" class="form-control @error('storage_condition_${brandIndex}') is-invalid @enderror" placeholder="Enter Storage Condition">
                            @error('storage_condition_${brandIndex}')
                            <div class="text-danger">{{ $message }}</div>
                            @enderror
                        </div>
                        @endif

                        @if($inquire->is_product_photo === 1)
                        <!-- Product Photos Field -->
                        <div class="form-group col-md-3">
                            <label for="product_photos[]">Product Photos</label>
                            <input type="file" name="quotation[${brandIndex}][product_photos][]" id="product_photos_${brandIndex}" class="form-control-file @error('product_photos_${brandIndex}.*') is-invalid @enderror" accept="image/*" multiple onchange="handlePhotoPreviews(${brandIndex})">
                            @error('product_photos_${brandIndex}.*')
                            <div class="text-danger">{{ $message }}</div>
                            @enderror
                            <div id="photoPreviews_${brandIndex}" class="mt-2"></div> 
                        </div>
                        @endif

                        @if($inquire->is_product_doc === 1)
                        <!-- Product Documents Field -->
                        <div class="form-group col-md-3">
                            <label for="product_documents[]">Product Documents</label>
                            <input type="file" name="quotation[${brandIndex}][product_documents][]" id="product_documents_${brandIndex}" class="form-control-file @error('product_documents_${brandIndex}.*') is-invalid @enderror" accept=".pdf,.doc,.docx" multiple onchange="handleDocumentPreviews(${brandIndex})">
                            @error('product_documents_${brandIndex}.*')
                            <div class="text-danger">{{ $message }}</div>
                            @enderror
                            <div id="documentList_${brandIndex}" class="mt-2"></div> 
                        </div>
                        @endif
                        </div>
                        <hr class="border-dark">
                        <div class="supplier-sections">
                            <h5>Supplier Details</h5>
                            <div class="form-group mb-0">
                                <div class="d-flex justify-content-end">
                                    <button type="button" class="btn btn-success-rgba add-supplier-details" data-brand-index="${brandIndex}">
                                        <i class="fa fa-plus"></i> Supplier
                                    </button>
                                </div>
                            </div>
                            <div id="supplier-details-container-${brandIndex}">
                                <!-- Supplier detail rows will be added here -->
                            </div>
                        </div>
                    </div>
                    </div>
                </div>
            `;
            $('.brand-details').append(newBrandDetail);

            // Reinitialize Select2 for the newly added elements
            initializeSelect2();
        });

        // Add More Supplier Details
        $(document).on('click', '.add-supplier-details', function() {
            let brandIndex = $(this).data('brand-index');
            supplierIndices[brandIndex]++; // Increment supplier index for this brand

            let supplierIndex = supplierIndices[
                brandIndex]; // Get the current supplier index for this brand
            let newSupplierDetail = `
                <div class="supplier-detail-row row mb-2">
                    @if($inquire->is_vendor_name)
                    <div class="col-md-2">
                        <div class="form-group">
                            <label for="vender_id_${brandIndex}_${supplierIndex}">Vendor</label>
                            <select name="quotation[${brandIndex}][supplier][${supplierIndex}][vender_id]" id="vender_id_${brandIndex}_${supplierIndex}" class="form-control select2">
                                <option value="">Select Vendor</option>
                                @foreach($venders as $vender)
                                <option value="{{ $vender->id }}">{{ $vender->name }}</option>
                                @endforeach
                            </select>
                        </div>
                    </div>
                    @endif

                    @if($inquire->is_price_per_pack)
                    <div class="col-md-2">
                        <div class="form-group">
                            <label for="price_per_pack_${brandIndex}_${supplierIndex}">Price Per Pack<span class="text-danger">*</span></label>
                            <input type="text" name="quotation[${brandIndex}][supplier][${supplierIndex}][price_per_pack]" id="price_per_pack_${brandIndex}_${supplierIndex}" class="form-control" placeholder="Enter Price Per Pack">
                        </div>
                    </div>
                    @endif

                    @if($inquire->is_expiry)
                    <div class="col-md-2">
                        <div class="form-group mb-0">
                            <label for="expiry_date_${brandIndex}_${supplierIndex}">Expiry Date (Month and Year)<span class="text-danger">*</span></label>
                            <input type="month" name="quotation[${brandIndex}][supplier][${supplierIndex}][expiry_date]" id="expiry_date_${brandIndex}_${supplierIndex}" class="form-control">
                        </div>
                    </div>
                    @endif

                    @if($inquire->is_lead_time)
                    <div class="col-md-2">
                        <div class="form-group mb-0">
                            <label for="lead_time_${brandIndex}_${supplierIndex}">Lead Time(Days)<span class="text-danger">*</span></label>
                            <input type="text" name="quotation[${brandIndex}][supplier][${supplierIndex}][lead_time]" id="lead_time_${brandIndex}_${supplierIndex}" class="form-control" placeholder="Enter Lead Time(Days)">
                        </div>
                    </div>
                    @endif

                    <div class="col-md-2">
                        <div class="form-group mb-0">
                            <button type="button" class="btn btn-danger remove-supplier-detail">
                                <i class="fa fa-minus" aria-hidden="true"></i>
                            </button>
                        </div>
                    </div>
                </div>
            `;
            $(`#supplier-details-container-${brandIndex}`).append(newSupplierDetail);

             // Reinitialize Select2 for the newly added elements
                initializeSelect2();
        });

        // Remove Supplier Details
        $(document).on('click', '.remove-supplier-detail', function() {
            $(this).closest('.supplier-detail-row').remove();
        });

        // Remove Brand Details
        $(document).on('click', '.remove-brand-detail', function() {
            let brandIndex = $(this).data('brand-index');
            $(`.brand-detail-${brandIndex}`).remove(); // Remove the entire brand detail section
        });

        $(document).on('click', '.remove-brand-detail-old', function () {
            $(this).closest('.quotation-row').remove();
        });

        $(document).on('click', '.remove-supplier-detail-old', function() {
            $(this).closest('.row.mb-2').remove(); // Remove the old supplier row
        });
    });
    </script>

    <script>
    function handlePhotoPreviews(brandIndex) {
        const input = document.getElementById(`product_photos_${brandIndex}`);
        const previewContainer = document.getElementById(`photoPreviews_${brandIndex}`);

        // Clear previous previews
        previewContainer.innerHTML = '';

        // Iterate over the selected files
        Array.from(input.files).forEach((file, index) => {
            const reader = new FileReader();

            reader.onload = function(e) {
                var div = document.createElement('div');
                div.classList.add('photo-preview');
                div.style.display = 'inline-block';
                div.style.marginRight = '10px'; // Adjust spacing as needed

                var img = document.createElement('img');
                img.classList.add('img-thumbnail');
                img.style.width = '50px'; // Adjust size as needed
                img.style.height = '50px'; // Adjust size as needed
                img.style.objectFit = 'cover'; // Ensure image fits well in the box
                img.src = e.target.result;
                div.appendChild(img);

                var removeButton = document.createElement('button');
                removeButton.innerHTML =
                    '<i class="fa fa-times" aria-hidden="true"></i>'; // Use 'fa-times' for a better icon
                removeButton.type = 'button';
                removeButton.classList.add('btn', 'btn-danger', 'btn-sm');
                removeButton.style.marginLeft = '5px'; // Space between image and button
                removeButton.style.padding = '2px 5px'; // Smaller padding
                removeButton.style.fontSize = '12px'; // Smaller font size
                removeButton.onclick = function() {
                    previewContainer.removeChild(div);
                    // Update file input to remove the file
                    var dataTransfer = new DataTransfer();
                    files = files.filter(f => f !== file); // Remove the file from the list
                    files.forEach(f => dataTransfer.items.add(f));
                    document.getElementById('product_photos').files = dataTransfer.files;
                };
                div.appendChild(removeButton);
                previewContainer.appendChild(div);
            };

            reader.readAsDataURL(file);
        });
    }

    function removePhoto(brandIndex, index) {
        const input = document.getElementById(`product_photos_${brandIndex}`);
        const previewContainer = document.getElementById(`photoPreviews_${brandIndex}`);

        // Remove file from the input's FileList (by re-creating it without the removed file)
        const dt = new DataTransfer();
        Array.from(input.files).forEach((file, fileIndex) => {
            if (fileIndex !== index) {
                dt.items.add(file); // Only add files that are not removed
            }
        });
        input.files = dt.files;

        // Re-render the preview
        handlePhotoPreviews(brandIndex);
    }
    </script>

    <script>
    function handleDocumentPreviews(brandIndex) {
        const input = document.getElementById(`product_documents_${brandIndex}`);
        const previewContainer = document.getElementById(`documentList_${brandIndex}`);

        // Clear previous previews
        previewContainer.innerHTML = '';

        // Iterate over the selected files
        Array.from(input.files).forEach((file, index) => {
            const docWrapper = document.createElement('div');
            docWrapper.classList.add('document-preview');

            const docLink = document.createElement('span');
            docLink.innerHTML = file.name;

            // Create a remove button for each document
            const removeBtn = document.createElement('button');
            removeBtn.type = 'button';
            removeBtn.innerHTML = '<i class="fa fa-times" aria-hidden="true"></i>';
            removeBtn.classList.add('btn', 'btn-danger', 'btn-sm');
            removeBtn.style.marginLeft = '10px'; // Space between file name and button
            removeBtn.style.padding = '2px 3px'; // Smaller padding
            removeBtn.style.fontSize = '12px'; // Smaller font size
            removeBtn.onclick = function() {
                removeDocument(brandIndex, index); // Remove document handler
            };

            docWrapper.appendChild(docLink);
            docWrapper.appendChild(removeBtn);

            previewContainer.appendChild(docWrapper);
        });
    }

    function removeDocument(brandIndex, index) {
        const input = document.getElementById(`product_documents_${brandIndex}`);
        const previewContainer = document.getElementById(`documentList_${brandIndex}`);

        // Remove file from the input's FileList (by re-creating it without the removed file)
        const dt = new DataTransfer();
        Array.from(input.files).forEach((file, fileIndex) => {
            if (fileIndex !== index) {
                dt.items.add(file); // Only add files that are not removed
            }
        });
        input.files = dt.files;

        // Re-render the preview
        handleDocumentPreviews(brandIndex);
    }
    </script>
    <script>
    $(document).ready(function () {
        $('.brand').change(function () {
            let brandId = $(this).val();
            let packSizeDropdown = $('#product_variant_id');

            // Clear the existing options
            packSizeDropdown.empty();
            packSizeDropdown.append('<option value="">Select Pack Size</option>');

            if (brandId) {
                // Make an AJAX request to get the pack sizes
                $.ajax({
                    url: `/get-pack-sizes/${brandId}`,
                    type: 'GET',
                    success: function (response) {
                        // Populate the pack size dropdown
                        $.each(response, function (key, value) {
                            packSizeDropdown.append(
                                `<option value="${value.id}">${value.name}</option>`
                            );
                        });
                    },
                    error: function (error) {
                        console.error('Error fetching pack sizes:', error);
                    }
                });
            }
        });
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
    <script>
        $(document).ready(function () {
            // Function to handle photo previews
            $(document).on('change', '.product-photos-input', function (event) {
                let input = this;
                let previewContainerId = $(this).data('preview-container');
                let previewContainer = $("#" + previewContainerId);
                previewContainer.html('');

                let dt = new DataTransfer(); // To store remaining files after removal

                Array.from(input.files).forEach((file, index) => {
                    if (file.type.startsWith('image/')) {
                        let reader = new FileReader();
                        reader.onload = function (e) {
                            let div = document.createElement('div');
                            div.classList.add('photo-preview');
                            div.style.display = 'inline-block';
                            div.style.marginRight = '10px';

                            let img = document.createElement('img');
                            img.classList.add('img-thumbnail');
                            img.style.width = '50px';
                            img.style.height = '50px';
                            img.style.objectFit = 'cover';
                            img.src = e.target.result;
                            div.appendChild(img);

                            // Remove button
                            let removeButton = document.createElement('button');
                            removeButton.innerHTML = '<i class="fa fa-times" aria-hidden="true"></i>';
                            removeButton.type = 'button';
                            removeButton.classList.add('btn', 'btn-danger', 'btn-sm');
                            removeButton.style.marginLeft = '5px'; // Space between image and button
                            removeButton.style.padding = '2px 5px'; // Smaller padding
                            removeButton.style.fontSize = '12px'; // Smaller font size
                            removeButton.onclick = function () {
                                div.remove(); // Remove the preview UI
                                dt.items.remove(index); // Remove from the DataTransfer list
                                input.files = dt.files; // Update the input file list
                            };

                            div.appendChild(removeButton);
                            previewContainer.append(div);

                            dt.items.add(file); // Add files to DataTransfer
                        };
                        reader.readAsDataURL(file);
                    }
                });

                input.files = dt.files; // Update the file input with new list
            });


            // Function to handle document previews
            $(document).on('change', '.product-documents-input', function (event) {
                let input = this;
                let previewContainerId = $(this).data('preview-container');
                let previewContainer = $("#" + previewContainerId);
                previewContainer.html('');

                let dt = new DataTransfer(); // To store remaining files after removal

                Array.from(input.files).forEach((file, index) => {
                    let div = document.createElement('div');
                    div.classList.add('document-preview');
                    div.style.marginBottom = '5px';

                    let fileName = document.createElement('p');
                    fileName.textContent = file.name;
                    fileName.style.display = 'inline';

                    // Remove button
                    let removeButton = document.createElement('button');
                    removeButton.innerHTML = '<i class="fa fa-times" aria-hidden="true"></i>';
                    removeButton.type = 'button';
                    removeButton.classList.add('btn', 'btn-danger', 'btn-sm');
                    removeButton.style.marginLeft = '10px'; // Space between file name and button
                    removeButton.style.padding = '2px 3px'; // Smaller padding
                    removeButton.style.fontSize = '12px'; // Smaller font size
                    removeButton.onclick = function () {
                        div.remove(); // Remove from UI
                        dt.items.remove(index); // Remove from DataTransfer
                        input.files = dt.files; // Update the input
                    };

                    div.appendChild(fileName);
                    div.appendChild(removeButton);
                    previewContainer.append(div);

                    dt.items.add(file); // Add file to DataTransfer
                });

                input.files = dt.files; // Update input files
            });

        });
    </script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Use event delegation on the `document` (or a parent container) 
            // to catch clicks on *any* .add-supplier-detail button
            document.addEventListener('click', function(e) {
                if (e.target && e.target.classList.contains('add-supplier-detail')) {
                    e.preventDefault();
                    
                    // Find the nearest supplier-section wrapper
                    let supplierSection = e.target.closest('.supplier-section');
                    
                    // Within that section, find the .supplier-details-container
                    let container = supplierSection.querySelector('.supplier-details-container');
                    if (!container) return; // Safety check

                    // Count how many .supplier-detail-row we already have
                    let newSupplierIndex = container.querySelectorAll('.supplier-detail-row').length;

                    // If you need brand index from data attribute
                    let brandIndex = container.getAttribute('data-brand-index');

                    // Build a new row. Use brandIndex & newSupplierIndex in name attributes:
                    let newRow = document.createElement('div');
                    newRow.classList.add('row', 'mb-2', 'supplier-detail-row');

                    // Example fields (adjust as needed):
                    newRow.innerHTML = `
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Vendor</label>
                                <select name="quotation[${brandIndex}][supplier][${newSupplierIndex}][vender_id]" 
                                        class="form-control select2">
                                    <option value="">Select Vendor</option>
                                    @foreach($venders as $vender)
                                        <option value="{{ $vender->id }}">{{ $vender->name }}</option>
                                    @endforeach
                                </select>
                            </div>
                        </div>

                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Price Per Pack</label>
                                <input type="text" 
                                    name="quotation[${brandIndex}][supplier][${newSupplierIndex}][price_per_pack]"
                                    class="form-control" 
                                    placeholder="Enter Price Per Pack" />
                            </div>
                        </div>

                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Expiry Date (Month/Year)</label>
                                <input type="month"
                                    name="quotation[${brandIndex}][supplier][${newSupplierIndex}][expiry_date]"
                                    class="form-control" />
                            </div>
                        </div>

                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Lead Time(Days)</label>
                                <input type="text"
                                    name="quotation[${brandIndex}][supplier][${newSupplierIndex}][lead_time]"
                                    class="form-control" 
                                    placeholder="Enter Lead Time(Days)" />
                            </div>
                        </div>

                        <!-- Remove button -->
                        <div class="col-md-2">
                            <div class="form-group">
                                <button type="button" class="btn btn-danger remove-supplier-detail">
                                    <i class="fa fa-minus" aria-hidden="true"></i>
                                </button>
                            </div>
                        </div>
                    `;

                    // Append the new row
                    container.appendChild(newRow);

                    // Re-initialize Select2 for newly added elements
                    initializeSelect2();
                }
            });


            // Also handle removing a supplier row by delegation
            document.addEventListener('click', function(e) {
                if (e.target && e.target.closest('.remove-supplier-detail')) {
                    e.preventDefault();
                    let row = e.target.closest('.supplier-detail-row');
                    if (row) {
                        row.remove();
                    }
                }
            });

            // Initialize Select2 on page load
            initializeSelect2();

            function initializeSelect2() {
                // You might need to target all .select2 that are not initialized yet
                // or reinitialize forcibly
                $('.select2').select2({
                    placeholder: function() {
                        return $(this).data('placeholder');
                    },
                    allowClear: true
                });
            }
        });
    </script>

    @endsection