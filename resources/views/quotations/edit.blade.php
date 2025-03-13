@extends('layouts.main')

@section('title', 'Edit Quotation')

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
                <!-- End Inquire Details -->
                @php
                    $type = $inquire->type === 'generic';
                @endphp
                <div class="card-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="card-title">Edit Quotation</h5>
                        @if($type === true)
                            <button type="button" name="add" id="addMore" class="btn btn-success-rgba add-more-brand">
                                <i class="fa fa-plus"></i> Add More Brand
                            </button>
                        @endif
                    </div>
                </div>
                <div class="card-body">
                <form method="POST" action="{{ route('quotations.update', $inquire->id) }}" enctype="multipart/form-data">
                        @csrf
                        @method('PUT')
                        <input type="hidden" name="redirect" value="{{ urlencode($redirectUrl) }}">
                        <input type="hidden" name="inquire_id" value="{{ $inquire->id }}">

                        <!-- ==================================== -->
                        <!--  A) EXISTING QUOTATIONS (edit mode)  -->
                        <!-- ==================================== -->
                        @foreach($inquire->quotations as $quoteIndex => $quotation)
                            <div class="border border-dark rounded p-3 mt-3">
                                <!-- Remove Brand Button -->
                                @if($inquire->type !== 'brand')
                                <div class="text-right mb-2">
                                    <button type="button"
                                            class="btn btn-danger delete-brand-detail"
                                            data-quotationid="{{ $quotation->id }}">
                                        <i class="fa fa-minus"></i> Remove Brand
                                    </button>
                                </div>
                                @endif

                                <div class="form-row">
                                    @if($type)
                                        @if($inquire->is_brand_name)
                                        <div class="form-group col-md-3">
                                            <label for="brand_id_{{ $quoteIndex }}">Brand Name</label>
                                            <select name="existing[{{ $quotation->id }}][brand_id]"
                                                    id="brand_id_{{ $quoteIndex }}"
                                                    class="form-control select2 brand">
                                                <option value="">Select Brand</option>
                                                @foreach($brands as $brand)
                                                    @if($brand->status != 0 || $brand->id == $quotation->brand_id)
                                                        <option value="{{ $brand->id }}"
                                                          {{ $brand->id == $quotation->brand_id ? 'selected' : '' }}>
                                                            {{ $brand->name }}
                                                        </option>
                                                    @endif
                                                @endforeach
                                            </select>
                                        </div>
                                        @endif
                                    @else
                                        @if($inquire->is_generic_name)
                                        <div class="form-group col-md-3">
                                            <label for="generic_id_{{ $quoteIndex }}">Generic Name</label>
                                            <select name="existing[{{ $quotation->id }}][generic_id]"
                                                    id="generic_id_{{ $quoteIndex }}"
                                                    class="form-control select2">
                                                <option value="">Select Generic</option>
                                                @foreach($generics as $generic)
                                                    <option value="{{ $generic->id }}"
                                                      {{ $generic->id == $quotation->generic_id ? 'selected' : '' }}>
                                                        {{ $generic->name }}
                                                    </option>
                                                @endforeach
                                            </select>
                                        </div>
                                        @endif
                                    @endif

                                    @if($inquire->is_pack_size)
                                    <div class="form-group col-md-3">
                                        <label for="product_variant_id_{{ $quoteIndex }}">Pack Size<span class="text-danger">*</span></label>
                                        <select name="existing[{{ $quotation->id }}][product_variant_id]"
                                                id="product_variant_id_{{ $quoteIndex }}"
                                                class="form-control select2">
                                            <option value="">Select Pack Size</option>
                                            @foreach($productVariants as $variant)
                                                @if($variant->status != 0 || $variant->id == $quotation->product_variant_id)
                                                    <option value="{{ $variant->id }}"
                                                      {{ $variant->id == $quotation->product_variant_id ? 'selected' : '' }}>
                                                        {{ $variant->name }}
                                                    </option>
                                                @endif
                                            @endforeach
                                        </select>
                                        @error("existing.{$quotation->id}.product_variant_id")
                                            <span class="text-danger">{{ $message }}</span>
                                        @enderror
                                    </div>
                                    @endif

                                    @if($inquire->is_manufacturer_name)
                                    <div class="form-group col-md-3">
                                        <label for="manufacturer_id_{{ $quoteIndex }}">Manufacturer</label>
                                        <select name="existing[{{ $quotation->id }}][manufacturer_id]"
                                                id="manufacturer_id_{{ $quoteIndex }}"
                                                class="form-control select2">
                                            <option value="">Select Manufacturer</option>
                                            @foreach($manufacturers as $manufacturer)
                                                <option value="{{ $manufacturer->id }}"
                                                    {{ $manufacturer->id == $quotation->manufacturer_id ? 'selected' : '' }}>
                                                    {{ $manufacturer->name }}
                                                </option>
                                            @endforeach
                                        </select>
                                    </div>
                                    @endif

                                    @if($inquire->is_gst)
                                    <div class="form-group col-md-3">
                                        <label for="gst_{{ $quoteIndex }}">Gst</label>
                                        <input type="text"
                                               name="existing[{{ $quotation->id }}][gst]"
                                               value="{{ $quotation->gst }}"
                                               id="gst_{{ $quoteIndex }}"
                                               class="form-control"
                                               placeholder="Enter Gst">
                                            @error("existing.{$quotation->id}.gst")
                                                <span class="text-danger">{{ $message }}</span>
                                            @enderror
                                    </div>
                                    @endif

                                    @if($inquire->is_storage_condition)
                                    <div class="form-group col-md-3">
                                        <label for="storage_condition_{{ $quoteIndex }}">Storage Condition</label>
                                        <input type="text"
                                               name="existing[{{ $quotation->id }}][storage_condition]"
                                               value="{{ $quotation->storage_condition }}"
                                               id="storage_condition_{{ $quoteIndex }}"
                                               class="form-control"
                                               placeholder="Enter Storage Condition">
                                        @error("existing.{$quotation->id}.storage_condition")
                                            <span class="text-danger">{{ $message }}</span>
                                        @enderror
                                    </div>
                                    @endif

                                    @if($inquire->is_product_photo)
                                    <div class="form-group col-md-3">
                                        <label>Product Photos</label>
                                        <input type="file"
                                               name="existing[{{ $quotation->id }}][product_photos][]"
                                               class="form-control-file"
                                               id="product_photos"
                                               accept="image/*"
                                               multiple>

                                        <!-- Show existing photos with a delete button -->
                                        <hr>
                                        @foreach($quotation->productPhotos as $photo)
                                            <a href="{{ asset('productPhotos/' . $photo->photo) }}" target="_blank">
                                                <img src="{{ asset('productPhotos/' . $photo->photo) }}"
                                                     alt="Photo"
                                                     style="width:40px;height:40px;margin-right:5px;">
                                            </a>
                                            <button type="button"
                                                    data-photo-id="{{ $photo->id }}"
                                                    class="btn btn-danger-rgba deletePhoto">
                                                <i class="feather icon-trash"></i>
                                            </button>
                                        @endforeach
                                        <div id="photoPreviews" class="mt-2"></div> 
                                    </div>
                                    @endif

                                    @if($inquire->is_product_doc)
                                    <div class="form-group col-md-3">
                                        <label>Product Documents</label>
                                        <input type="file"
                                               name="existing[{{ $quotation->id }}][product_documents][]"
                                               class="form-control-file"
                                               id="product_documents"
                                               accept="application/pdf"
                                               multiple>
                                        <!-- Show existing documents with a delete button -->
                                        <hr>
                                        @foreach($quotation->productDocuments as $document)
                                            @php
                                                $filename = pathinfo($document->document, PATHINFO_FILENAME);
                                                $parts = explode('_', $filename);
                                                $displayName = end($parts) . '.' . pathinfo($document->document, PATHINFO_EXTENSION);
                                            @endphp
                                            <a href="{{ asset('productDocuments/' . $document->document) }}"
                                               target="_blank">
                                                <i class="feather icon-file-text"></i> {{ $displayName }}
                                            </a>
                                            <button type="button"
                                                    data-document-id="{{ $document->id }}"
                                                    class="btn btn-danger-rgba deleteDocument">
                                                <i class="feather icon-trash"></i>
                                            </button>
                                        @endforeach
                                        <div id="documentList" class="mt-2"></div> 
                                    </div>
                                    @endif
                                </div> <!-- end form-row -->

                                <hr class="border-dark">
                                <!-- SUPPLIERS FOR THIS QUOTATION -->
                                <div class="supplier-section" data-quote-index="{{ $quoteIndex }}">
                                    <h5>Supplier Details</h5>
                                    <div class="form-group mb-0 d-flex justify-content-end">
                                        <button type="button"
                                                class="btn btn-success-rgba add-existing-supplier"
                                                data-quotation-id="{{ $quotation->id }}"
                                                data-quote-index="{{ $quoteIndex }}">
                                            <i class="fa fa-plus"></i> Add Supplier
                                        </button>
                                    </div>

                                    <!-- Container for suppliers (existing in DB + newly added after validation) -->
                                    <div id="supplier-details-container-{{ $quoteIndex }}">
                                        @php
                                            // OLD supplier data for this existing quotation:
                                            $oldSuppliers = old("existing.$quotation->id.supplier", []);
                                        @endphp

                                        <!-- A) SHOW DB SUPPLIERS (override with old() if any) -->
                                        @foreach($quotation->suppliers as $dbSupplier)
                                            <div class="row supplier-detail mt-2">
                                                <input type="hidden"
                                                       name="existing[{{ $quotation->id }}][supplier][{{ $dbSupplier->id }}][id]"
                                                       value="{{ $dbSupplier->id }}">
                                                @if($inquire->is_vendor_name)
                                                    <div class="col-md-2">
                                                        <div class="form-group">
                                                            <label>Vendor</label>
                                                            <select name="existing[{{ $quotation->id }}][supplier][{{ $dbSupplier->id }}][vender_id]"
                                                                    class="form-control select2">
                                                                <option value="">Select Vendor</option>
                                                                @foreach($venders as $v)
                                                                    <option value="{{ $v->id }}"
                                                                        {{ old("existing.$quotation->id.supplier.{$dbSupplier->id}.vender_id", $dbSupplier->vender_id) == $v->id ? 'selected' : '' }}>
                                                                        {{ $v->name }}
                                                                    </option>
                                                                @endforeach
                                                            </select>
                                                        </div>
                                                    </div>
                                                @endif
                                                @if($inquire->is_price_per_pack)
                                                    <div class="col-md-2">
                                                        <div class="form-group">
                                                            <label>Price Per Pack <span class="text-danger">*</span></label>
                                                            <input type="text"
                                                                   name="existing[{{ $quotation->id }}][supplier][{{ $dbSupplier->id }}][price_per_pack]"
                                                                   class="form-control" placeholder="Enter Price Per Pack"
                                                                   value="{{ old("existing.$quotation->id.supplier.{$dbSupplier->id}.price_per_pack", $dbSupplier->price_per_pack) }}">
                                                        </div>
                                                        @error("existing.$quotation->id.supplier.{$dbSupplier->id}.price_per_pack")
                                                            <div class="text-danger">{{ $message }}</div>
                                                        @enderror
                                                    </div>
                                                @endif
                                                @if($inquire->is_expiry)
                                                    <div class="col-md-2">
                                                        <div class="form-group">
                                                            <label>Expiry Date <span class="text-danger">*</span></label>
                                                            <input type="month"
                                                                   name="existing[{{ $quotation->id }}][supplier][{{ $dbSupplier->id }}][expiry_date]"
                                                                   class="form-control"
                                                                   value="{{ old("existing.$quotation->id.supplier.{$dbSupplier->id}.expiry_date", $dbSupplier->expiry_date) }}">
                                                        </div>
                                                        @error("existing.$quotation->id.supplier.{$dbSupplier->id}.expiry_date")
                                                            <div class="text-danger">{{ $message }}</div>
                                                        @enderror
                                                    </div>
                                                @endif
                                                @if($inquire->is_lead_time)
                                                    <div class="col-md-2">
                                                        <div class="form-group">
                                                            <label>Lead Time(Days) <span class="text-danger">*</span></label>
                                                            <input type="text"
                                                                   name="existing[{{ $quotation->id }}][supplier][{{ $dbSupplier->id }}][lead_time]"
                                                                   class="form-control" placeholder="Enter Lead Time(Days)"
                                                                   value="{{ old("existing.$quotation->id.supplier.{$dbSupplier->id}.lead_time", $dbSupplier->lead_time) }}">
                                                        </div>
                                                        @error("existing.$quotation->id.supplier.{$dbSupplier->id}.lead_time")
                                                            <div class="text-danger">{{ $message }}</div>
                                                        @enderror
                                                    </div>
                                                @endif

                                                <!-- Delete existing DB supplier -->
                                                <div class="col-md-2" style="margin-top:30px;">
                                                    <button type="button"
                                                            data-supplier-id="{{ $dbSupplier->id }}"
                                                            class="btn btn-danger-rgba deleteSupplier">
                                                        <i class="feather icon-trash"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        @endforeach

                                        <!-- B) SHOW ANY *NEWLY* ADDED SUPPLIERS (after validation fail) 
                                             i.e. old data that doesn't match an existing DB supplier ID 
                                        -->
                                        @foreach($oldSuppliers as $supKey => $supData)
                                            @if(empty($supData['id']))
                                                <!-- This means it’s a newly added supplier row that wasn’t saved yet -->
                                                <div class="row supplier-detail mt-2">
                                                    <input type="hidden"
                                                           name="existing[{{ $quotation->id }}][supplier][{{ $supKey }}][id]"
                                                           value="">
                                                    @if($inquire->is_vendor_name)
                                                        <div class="col-md-2">
                                                            <div class="form-group">
                                                                <label>Vendor</label>
                                                                <select name="existing[{{ $quotation->id }}][supplier][{{ $supKey }}][vender_id]"
                                                                        class="form-control select2">
                                                                    <option value="">Select Vendor</option>
                                                                    @foreach($venders as $v)
                                                                        <option value="{{ $v->id }}"
                                                                            {{ old("existing.$quotation->id.supplier.$supKey.vender_id") == $v->id ? 'selected' : '' }}>
                                                                            {{ $v->name }}
                                                                        </option>
                                                                    @endforeach
                                                                </select>
                                                            </div>
                                                        </div>
                                                    @endif
                                                    @if($inquire->is_price_per_pack)
                                                        <div class="col-md-2">
                                                            <div class="form-group">
                                                                <label>Price Per Pack <span class="text-danger">*</span></label>
                                                                <input type="text"
                                                                       name="existing[{{ $quotation->id }}][supplier][{{ $supKey }}][price_per_pack]"
                                                                       class="form-control"
                                                                       value="{{ old("existing.$quotation->id.supplier.$supKey.price_per_pack") }}"
                                                                       placeholder="Enter Price Per Pack">
                                                                @error("existing.$quotation->id.supplier.$supKey.price_per_pack")
                                                                    <div class="text-danger">{{ $message }}</div>
                                                                @enderror
                                                            </div>
                                                        </div>
                                                    @endif
                                                    @if($inquire->is_expiry)
                                                        <div class="col-md-2">
                                                            <div class="form-group">
                                                                <label>Expiry Date <span class="text-danger">*</span></label>
                                                                <input type="month"
                                                                       name="existing[{{ $quotation->id }}][supplier][{{ $supKey }}][expiry_date]"
                                                                       class="form-control"
                                                                       value="{{ old("existing.$quotation->id.supplier.$supKey.expiry_date") }}">
                                                                @error("existing.$quotation->id.supplier.$supKey.expiry_date")
                                                                    <div class="text-danger">{{ $message }}</div>
                                                                @enderror
                                                            </div>
                                                        </div>
                                                    @endif
                                                    @if($inquire->is_lead_time)
                                                        <div class="col-md-2">
                                                            <div class="form-group">
                                                                <label>Lead Time(Days) <span class="text-danger">*</span></label>
                                                                <input type="text"
                                                                       name="existing[{{ $quotation->id }}][supplier][{{ $supKey }}][lead_time]"
                                                                       class="form-control" placeholder="Enter Lead Time(Days)"
                                                                       value="{{ old("existing.$quotation->id.supplier.$supKey.lead_time") }}">
                                                                @error("existing.$quotation->id.supplier.$supKey.lead_time")
                                                                    <div class="text-danger">{{ $message }}</div>
                                                                @enderror
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
                                            @endif
                                        @endforeach
                                    </div><!-- /#supplier-details-container-$quoteIndex -->
                                </div> <!-- /.supplier-section -->
                            </div>
                        @endforeach
                        <!-- END EXISTING QUOTATIONS -->
                        <!-- ============================================ -->
                        <!-- B) RE-RENDER "NEW" QUOTATIONS AFTER VALIDATION -->
                        <!-- ============================================ -->
                        
                        <!-- 2) RE-RENDER “NEW” QUOTATIONS AFTER VALIDATION (old('new')) -->
                        @if(old('new'))
                            @foreach(old('new') as $newIndex => $newData)
                                <div class="brand-detail border border-dark rounded p-3 mt-3">
                                    <div class="text-right mb-2">
                                        <button type="button"
                                                class="btn btn-danger remove-brand-detail"
                                                data-brand-index="{{ $newIndex }}">
                                            <i class="fa fa-minus"></i> Remove Brand
                                        </button>
                                    </div>

                                    <div class="form-row">
                                        @if($inquire->is_brand_name)
                                            <div class="form-group col-md-3">
                                                <label>Brand Name</label>
                                                <select name="new[{{ $newIndex }}][brand_id]"
                                                        class="form-control select2">
                                                    <option value="">Select Brand</option>
                                                    @foreach($brands as $brand)
                                                        @if($brand->status != 0)
                                                            <option value="{{ $brand->id }}"
                                                                {{ old("new.$newIndex.brand_id") == $brand->id ? 'selected' : '' }}>
                                                                {{ $brand->name }}
                                                            </option>
                                                        @endif
                                                    @endforeach
                                                </select>
                                                @error("new.$newIndex.brand_id")
                                                    <div class="text-danger">{{ $message }}</div>
                                                @enderror
                                            </div>
                                        @endif

                                        @if($inquire->is_generic_name)
                                            <div class="form-group col-md-3">
                                                <label>Generic Name</label>
                                                <select name="new[{{ $newIndex }}][generic_id]"
                                                        class="form-control select2">
                                                    <option value="">Select Generic</option>
                                                    @foreach($generics as $generic)
                                                        <option value="{{ $generic->id }}"
                                                            {{ old("new.$newIndex.generic_id") == $generic->id ? 'selected' : '' }}>
                                                            {{ $generic->name }}
                                                        </option>
                                                    @endforeach
                                                </select>
                                                @error("new.$newIndex.generic_id")
                                                    <div class="text-danger">{{ $message }}</div>
                                                @enderror
                                            </div>
                                        @endif

                                        @if($inquire->is_pack_size)
                                            <div class="form-group col-md-3">
                                                <label>Pack Size <span class="text-danger">*</span></label>
                                                <select name="new[{{ $newIndex }}][product_variant_id]"
                                                        class="form-control select2">
                                                    <option value="">Select Pack Size</option>
                                                    @foreach($productVariants as $variant)
                                                        @if($variant->status != 0)
                                                            <option value="{{ $variant->id }}"
                                                                {{ old("new.$newIndex.product_variant_id") == $variant->id ? 'selected' : '' }}>
                                                                {{ $variant->name }}
                                                            </option>
                                                        @endif
                                                    @endforeach
                                                </select>
                                                @error("new.$newIndex.product_variant_id")
                                                    <div class="text-danger">{{ $message }}</div>
                                                @enderror
                                            </div>
                                        @endif

                                        @if($inquire->is_manufacturer_name)
                                            <div class="form-group col-md-3">
                                                <label>Manufacturer</label>
                                                <select name="new[{{ $newIndex }}][manufacturer_id]"
                                                        class="form-control select2">
                                                    <option value="">Select Manufacturer</option>
                                                    @foreach($manufacturers as $manufacturer)
                                                        <option value="{{ $manufacturer->id }}"
                                                            {{ old("new.$newIndex.manufacturer_id") == $manufacturer->id ? 'selected' : '' }}>
                                                            {{ $manufacturer->name }}
                                                        </option>
                                                    @endforeach
                                                </select>
                                            </div>
                                        @endif

                                        @if($inquire->is_gst)
                                            <div class="form-group col-md-3">
                                                <label>Gst</label>
                                                <input type="text"
                                                    name="new[{{ $newIndex }}][gst]"
                                                    value="{{ old("new.$newIndex.gst") }}"
                                                    class="form-control"
                                                    placeholder="Enter Gst">
                                                    @error("new.$newIndex.gst")
                                                        <span class="text-danger">{{ $message }}</span>
                                                    @enderror
                                            </div>
                                        @endif

                                        @if($inquire->is_storage_condition)
                                            <div class="form-group col-md-3">
                                                <label>Storage Condition</label>
                                                <input type="text"
                                                    name="new[{{ $newIndex }}][storage_condition]"
                                                    value="{{ old("new.$newIndex.storage_condition") }}"
                                                    class="form-control"
                                                    placeholder="Enter Storage Condition">
                                                @error("new.$newIndex.gst")
                                                    <span class="text-danger">{{ $message }}</span>
                                                @enderror
                                            </div>
                                        @endif

                                        @if($inquire->is_product_photo)
                                            <div class="form-group col-md-3">
                                                <label>Product Photos</label>
                                                <input type="file"
                                                    name="new[{{ $newIndex }}][product_photos][]"
                                                    class="form-control-file"
                                                    id="product_photos"
                                                    accept="image/*"
                                                    multiple>
                                                <div id="photoPreviews" class="mt-2"></div> 
                                            </div>
                                        @endif

                                        @if($inquire->is_product_doc)
                                            <div class="form-group col-md-3">
                                                <label>Product Documents</label>
                                                <input type="file"
                                                    name="new[{{ $newIndex }}][product_documents][]"
                                                    class="form-control-file"
                                                    id="product_documents"
                                                    accept="application/pdf"
                                                    multiple>
                                                <div id="documentList" class="mt-2"></div> 
                                        </div>
                                        @endif
                                    </div>

                                    <hr class="border-dark">
                                    <!-- Supplier sub-array for this brand -->
                                    <h5>Supplier Details</h5>
                                    <div class="form-group mb-0 d-flex justify-content-end">
                                        <button type="button"
                                                class="btn btn-success-rgba add-new-supplier"
                                                data-brand-index="{{ $newIndex }}">
                                            <i class="fa fa-plus"></i> Supplier
                                        </button>
                                    </div>
                                    <div id="new-supplier-details-container-{{ $newIndex }}" class="mt-2">
                                        @if(isset($newData['supplier']) && is_array($newData['supplier']))
                                            @foreach($newData['supplier'] as $sIndex => $supplierData)
                                                <div class="row supplier-detail mt-2">
                                                    @if($inquire->is_vendor_name)
                                                        <div class="col-md-2">
                                                            <div class="form-group">
                                                                <label>Vendor</label>
                                                                <select name="new[{{ $newIndex }}][supplier][{{ $sIndex }}][vender_id]"
                                                                        class="form-control select2">
                                                                    <option value="">Select Vendor</option>
                                                                    @foreach($venders as $v)
                                                                        <option value="{{ $v->id }}"
                                                                            {{ old("new.$newIndex.supplier.$sIndex.vender_id") == $v->id ? 'selected' : '' }}>
                                                                            {{ $v->name }}
                                                                        </option>
                                                                    @endforeach
                                                                </select>
                                                            </div>
                                                        </div>
                                                    @endif
                                                    @if($inquire->is_price_per_pack)
                                                        <div class="col-md-2">
                                                            <div class="form-group">
                                                                <label>Price Per Pack <span class="text-danger">*</span></label>
                                                                <input type="text"
                                                                       name="new[{{ $newIndex }}][supplier][{{ $sIndex }}][price_per_pack]"
                                                                       class="form-control"
                                                                       value="{{ old("new.$newIndex.supplier.$sIndex.price_per_pack") }}">
                                                                @error("new.$newIndex.supplier.$sIndex.price_per_pack")
                                                                    <div class="text-danger">{{ $message }}</div>
                                                                @enderror
                                                            </div>
                                                        </div>
                                                    @endif

                                                    @if($inquire->is_expiry)
                                                        <div class="col-md-2">
                                                            <div class="form-group">
                                                                <label>Expiry Date<span class="text-danger">*</span></label>
                                                                <input type="month" name="new[{{ $newIndex }}][supplier][{{ $sIndex }}][expiry_date]" 
                                                                    class="form-control"
                                                                    value="{{ old("new.$newIndex.supplier.$sIndex.expiry_date") }}">
                                                                    @error("new.$newIndex.supplier.$sIndex.expiry_date")
                                                                        <div class="text-danger">{{ $message }}</div>
                                                                    @enderror
                                                            </div>
                                                        </div>
                                                    @endif

                                                    @if($inquire->is_lead_time)
                                                        <div class="col-md-2">
                                                            <div class="form-group">
                                                                <label>Lead Time (Days)<span class="text-danger">*</span></label>
                                                                <input type="text" name="new[{{ $newIndex }}][supplier][{{ $sIndex }}][lead_time]"
                                                                    class="form-control"
                                                                    placeholder="Enter Lead Time (Days)"
                                                                    value="{{ old("new.$newIndex.supplier.$sIndex.lead_time") }}">
                                                                @error("new.$newIndex.supplier.$sIndex.lead_time")
                                                                    <div class="text-danger">{{ $message }}</div>
                                                                @enderror
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
                                            @endforeach
                                        @endif
                                    </div>
                                </div>
                            @endforeach
                        @endif
                        <!-- END “NEW” QUOTATIONS BLOCK -->
                        <!-- ======================================= -->
                        <!--  B) "Add More Brand" (New Quotations)  -->
                        <!-- ======================================= -->
                        <!-- Container that will hold newly added brand blocks -->
                        <div class="brand-container mt-4">
                            <div class="brand-details">
                                <!-- New brand blocks will be appended here by JS -->
                            </div>
                        </div>

                        <!-- Submit and Cancel Buttons -->
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
    </div>

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
                         <!-- History -->
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
                        <!-- <div class="d-flex justify-content-between align-items-center"> -->
                            <!-- Pagination Text -->
                            <!-- <div>
                                <p class="mb-0">Showing {{ $inquires->firstItem() }} to {{ $inquires->lastItem() }}
                                    of
                                    {{ $inquires->total() }}
                                    entries
                                </p>
                            </div> -->
                            <!-- Pagination Links -->
                            <!-- <div class="pagination-links mt-4"> -->
                                <!-- {{ $inquires->links() }} -->
                            <!-- </div> -->
                        <!-- </div> -->
                    </div>
                </div>
            </div>
            <!-- End col -->
        </div>
    </div>
</div>

    <!-- product photo delete model -->
    <div class="modal fade" id="deletePhotoModal" tabindex="-1" aria-labelledby="deletePhotoModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Photo delete confirmation</h5>
                </div>
                <div class="modal-body">
                    <span>Are you sure you want to delete?</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal">No</button>
                    <button type="button" class="btn btn-outline-danger confirm-photo-delete">yes</button>
                </div>
            </div>
        </div>
    </div>
    <!-- end product photo delete model  -->

    <!-- product document delete model -->
    <div class="modal fade" id="deleteDocumentModal" tabindex="-1" aria-labelledby="deleteDocumentModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Document delete confirmation</h5>
                </div>
                <div class="modal-body">
                    <span>Are you sure you want to delete?</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal">No</button>
                    <button type="button" class="btn btn-outline-danger confirm-document-delete">yes</button>
                </div>
            </div>
        </div>
    </div>
    <!-- end product document delete model -->

    <!-- Supplier delete modal -->
    <div class="modal fade" id="deleteSupplierModal" tabindex="-1" aria-labelledby="deleteSupplierModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteSupplierModalLabel">Supplier Delete Confirmation</h5>
                </div>
                <div class="modal-body">
                    <span>Are you sure you want to delete?</span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">No</button>
                    <button type="button" class="btn btn-outline-danger confirm-supplier-delete">Yes</button>
                </div>
            </div>
        </div>
    </div>
    <!-- End supplier delete modal -->
    <!-- Quotation delete modal -->
    <div class="modal fade" id="quotationDeleteModal" tabindex="-1" aria-labelledby="quotationDeleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Brand delete confirmation</h5>
                </div>
                <div class="modal-body">
                    Are you sure you want to delete?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-primary" data-dismiss="modal">No</button>
                    <button type="button" class="btn btn-outline-danger confirm-delete-brand">yes</button>
                </div>
            </div>
        </div>
    </div>
    <!-- End quotation delete modal -->
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
    /**
     * Re-initialize select2 for any newly added elements.
     */
        function initializeSelect2() {
        // Grab all elements with .select2
        $('.select2').each(function() {
        let placeholderText = $(this).data('placeholder');
        $(this).select2({
            placeholder: placeholderText,
            allowClear: true
        });
        });
    }

    $(document).ready(function() {
        // ============================
        // 0. INIT SELECT2 ON PAGE LOAD
        // ============================
        initializeSelect2();

        // ===================================================
        // 1. DELETE PHOTO / DOCUMENT / SUPPLIER AJAX HANDLERS
        // ===================================================
        // Delete Photo
        $('.deletePhoto').click(function() {
            var photoId = $(this).data('photo-id');
            $('#deletePhotoModal').modal('show');

            $('.confirm-photo-delete').off('click').on('click', function() {
                $.ajax({
                    url: '/productPhoto/' + photoId,
                    type: 'DELETE',
                    data: { _token: '{{ csrf_token() }}' },
                    success: function(result) {
                        if (result.error) {
                            $('#message').html(`
                                <div class="alert alert-danger alert-dismissible fade show mt-3" role="alert">
                                    ${result.error}
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            `);
                        } else if (result.message) {
                            $('#message').html(`
                                <div class="alert alert-success alert-dismissible fade show mt-3" role="alert">
                                    ${result.message}
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            `);
                        }
                        setTimeout(function() {
                            window.location.reload();
                        }, 1500);
                    },
                    error: function(xhr) {
                        console.error(xhr.responseText);
                        alert('Error deleting photo.');
                    }
                });
                $('#deletePhotoModal').modal('hide');
            });
        });

        // Delete Document
        $('.deleteDocument').click(function() {
            var documentId = $(this).data('document-id');
            $('#deleteDocumentModal').modal('show');

            $('.confirm-document-delete').off('click').on('click', function() {
                $.ajax({
                    url: '/productDocument/' + documentId,
                    type: 'DELETE',
                    data: { _token: '{{ csrf_token() }}' },
                    success: function(result) {
                        if (result.error) {
                            $('#message').html(`
                                <div class="alert alert-danger alert-dismissible fade show mt-3" role="alert">
                                    ${result.error}
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            `);
                        } else if (result.message) {
                            $('#message').html(`
                                <div class="alert alert-success alert-dismissible fade show mt-3" role="alert">
                                    ${result.message}
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            `);
                        }
                        setTimeout(function() {
                            window.location.reload();
                        }, 1500);
                    },
                    error: function(xhr) {
                        console.error(xhr.responseText);
                        alert('Error deleting document.');
                    }
                });
                $('#deleteDocumentModal').modal('hide');
            });
        });

        // Delete Supplier
        $('.deleteSupplier').click(function() {
            var supplierId = $(this).data('supplier-id');
            $('#deleteSupplierModal').modal('show');

            $('.confirm-supplier-delete').off('click').on('click', function() {
                $.ajax({
                    url: '/supplier/' + supplierId,
                    type: 'DELETE',
                    data: { _token: '{{ csrf_token() }}' },
                    success: function(result) {
                        if (result.error) {
                            $('#message').html(`
                                <div class="alert alert-danger alert-dismissible fade show mt-3" role="alert">
                                    ${result.error}
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            `);
                        } else if (result.message) {
                            $('#message').html(`
                                <div class="alert alert-success alert-dismissible fade show mt-3" role="alert">
                                    ${result.message}
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            `);
                        }
                        setTimeout(function() {
                            window.location.reload();
                        }, 1500);
                    },
                    error: function(xhr) {
                        console.error(xhr.responseText);
                        alert('Error deleting supplier.');
                    }
                });
                $('#deleteSupplierModal').modal('hide');
            });
        });

        // Delete Quotation
        $('.delete-brand-detail').click(function() { 
            var quotationId = $(this).data('quotationid'); // Fix attribute retrieval
            console.log('Quotation ID:', quotationId); // Debugging log

            $('#quotationDeleteModal').modal('show');
            
            // Ensure the event handler is bound only once
            $('.confirm-delete-brand').off('click').on('click', function() {
                if (!quotationId) {
                    console.error('Quotation ID is undefined!');
                    return;
                }

                $.ajax({
                    url: '/quotations/' + quotationId,
                    type: 'DELETE',
                    data: {
                        _token: $('meta[name="csrf-token"]').attr('content') // Fetch CSRF token dynamically
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
                        setTimeout(function() {
                            window.location.reload();
                        }, 2500);
                    },
                    error: function(xhr, status, error) {
                        console.error('Error:', error); // Debugging log
                        $('#message').html(
                            '<div class="alert alert-danger alert-dismissible fade show m-0 mt-3" role="alert">' +
                                'Error deleting quotation: ' + error +
                                '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                                    '<span aria-hidden="true">&times;</span>' +
                                '</button>' +
                            '</div>'
                        );
                    }
                });

                $('#quotationDeleteModal').modal('hide');
            });
        });

        // =============================================
        // 2. ADD SUPPLIER TO EXISTING QUOTATION (EDIT)
        // =============================================
        // We'll track how many new suppliers we add per existing quotation index
        $(document).on('click', '.add-existing-supplier', function () {
            let quoteIndex = $(this).data('quote-index'); // Quotation index
            let quotationId = $(this).data('quotation-id'); // Quotation ID
            let container = $(`#supplier-details-container-${quoteIndex}`);
            let supplierIndex = container.find('.supplier-detail').length; // Count existing suppliers

            let newSupplierRow = `
                <div class="row supplier-detail mt-2">
                    <input type="hidden" name="existing[${quotationId}][supplier][${supplierIndex}][id]" value="">

                    @if($inquire->is_vendor_name)
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Vendor</label>
                            <select name="existing[${quotationId}][supplier][${supplierIndex}][vender_id]" class="form-control select2">
                                <option value="">Select Vendor</option>
                                @foreach($venders as $v)
                                <option value="{{ $v->id }}">{{ $v->name }}</option>
                                @endforeach
                            </select>
                        </div>
                    </div>
                    @endif

                    @if($inquire->is_price_per_pack)
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Price Per Pack<span class="text-danger">*</span></label>
                            <input type="text" name="existing[${quotationId}][supplier][${supplierIndex}][price_per_pack]" class="form-control" placeholder="Enter Price Per Pack">
                        </div>
                    </div>
                    @endif

                    @if($inquire->is_expiry)
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Expiry Date<span class="text-danger">*</span></label>
                            <input type="month" name="existing[${quotationId}][supplier][${supplierIndex}][expiry_date]" class="form-control">
                        </div>
                    </div>
                    @endif

                    @if($inquire->is_lead_time)
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Lead Time (Days)<span class="text-danger">*</span></label>
                            <input type="text" name="existing[${quotationId}][supplier][${supplierIndex}][lead_time]" class="form-control" placeholder="Enter Lead Time">
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

            container.append(newSupplierRow);
            initializeSelect2(); // Reinitialize select2
        });

        // Remove newly added supplier row
        $(document).on('click', '.remove-supplier-detail', function() {
            $(this).closest('.supplier-detail').remove();
        });

        $(document).on('click', '.add-new-supplier', function() {
            let bIndex = $(this).data('brand-index');

            // Initialize the supplier counter if not present
            if (typeof supplierIndices[bIndex] === 'undefined') {
                supplierIndices[bIndex] = 0;
            }

            // Increment supplier index for this brand
            supplierIndices[bIndex]++;

            let sIndex = supplierIndices[bIndex];

            // Build the new supplier row
            // (Replicate your existing logic from .add-supplier-details)
            let newSupplierRow = `
                <div class="row supplier-detail mt-2">
                    <!-- Hidden input for ID if needed (usually empty for new) -->
                    <input type="hidden" name="new[${bIndex}][supplier][${sIndex}][id]" value="">

                    @if($inquire->is_vendor_name)
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Vendor</label>
                            <select name="new[${bIndex}][supplier][${sIndex}][vender_id]" class="form-control select2">
                                <option value="">Select Vendor</option>
                                @foreach($venders as $v)
                                    <option value="{{ $v->id }}">{{ $v->name }}</option>
                                @endforeach
                            </select>
                        </div>
                    </div>
                    @endif

                    @if($inquire->is_price_per_pack)
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Price Per Pack <span class="text-danger">*</span></label>
                            <input type="text"
                                name="new[${bIndex}][supplier][${sIndex}][price_per_pack]"
                                class="form-control"
                                placeholder="Enter Price Per Pack">
                        </div>
                    </div>
                    @endif

                    @if($inquire->is_expiry)
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Expiry Date <span class="text-danger">*</span></label>
                            <input type="month"
                                name="new[${bIndex}][supplier][${sIndex}][expiry_date]"
                                class="form-control">
                        </div>
                    </div>
                    @endif

                    @if($inquire->is_lead_time)
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Lead Time(Days) <span class="text-danger">*</span></label>
                            <input type="text"
                                name="new[${bIndex}][supplier][${sIndex}][lead_time]"
                                class="form-control"
                                placeholder="Enter Lead Time(Days)">
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

            // Append the row into the correct container
            $(`#new-supplier-details-container-${bIndex}`).append(newSupplierRow);

            // Re-initialize select2 for the newly added elements
            initializeSelect2();
        });

        // =============================================
        // 3. ADD MORE BRAND (FOR "GENERIC" INQUIRY ONLY)
        // =============================================
        let brandIndex = 0;
        let supplierIndices = {}; // track suppliers for each new brand

        // When user clicks the "Add More Brand" button
        $(document).on('click', '.add-more-brand', function() {
            brandIndex++;

            // Initialize supplier index for this brand
            supplierIndices[brandIndex] = 0;

            let newBrandHtml = `
            <div class="brand-detail brand-detail-${brandIndex} border border-dark rounded p-3 mt-3">
                <!-- Remove Brand Button -->
                <div class="text-right mb-2">
                    <button type="button"
                            class="btn btn-danger remove-brand-detail"
                            data-brand-index="${brandIndex}">
                        <i class="fa fa-minus"></i> Remove Brand
                    </button>
                </div>

                <div class="form-row">
                    @if($inquire->is_brand_name)
                    <div class="form-group col-md-3">
                        <label>Brand Name</label>
                        <select name="new[${brandIndex}][brand_id]"
                                class="form-control select2 brand">
                            <option value="">Select Brand</option>
                            @foreach($brands as $brand)
                                @if($brand->status != 0)
                                <option value="{{ $brand->id }}">{{ $brand->name }}</option>
                                @endif
                            @endforeach
                        </select>
                    </div>
                    @endif

                    @if($inquire->is_generic_name)
                    <div class="form-group col-md-3">
                        <label>Generic Name</label>
                        <select name="new[${brandIndex}][generic_id]"
                                class="form-control select2">
                            <option value="">Select Generic</option>
                            @foreach($generics as $generic)
                                <option value="{{ $generic->id }}">{{ $generic->name }}</option>
                            @endforeach
                        </select>
                    </div>
                    @endif

                    @if($inquire->is_pack_size)
                    <div class="form-group col-md-3">
                        <label>Pack Size<span class="text-danger">*</span></label>
                        <select name="new[${brandIndex}][product_variant_id]"
                                class="form-control select2">
                            <option value="">Select Pack Size</option>
                            @foreach($productVariants as $variant)
                                @if($variant->status != 0)
                                <option value="{{ $variant->id }}">{{ $variant->name }}</option>
                                @endif
                            @endforeach
                        </select>
                    </div>
                    @endif

                    @if($inquire->is_manufacturer_name)
                    <div class="form-group col-md-3">
                        <label>Manufacturer</label>
                        <select name="new[${brandIndex}][manufacturer_id]"
                                class="form-control select2">
                            <option value="">Select Manufacturer</option>
                            @foreach($manufacturers as $manufacturer)
                            <option value="{{ $manufacturer->id }}">{{ $manufacturer->name }}</option>
                            @endforeach
                        </select>
                    </div>
                    @endif

                    @if($inquire->is_gst)
                    <div class="form-group col-md-3">
                        <label>Gst</label>
                        <input type="text"
                            name="new[${brandIndex}][gst]"
                            class="form-control"
                            placeholder="Enter Gst">
                    </div>
                    @endif

                    @if($inquire->is_storage_condition)
                    <div class="form-group col-md-3">
                        <label>Storage Condition</label>
                        <input type="text"
                            name="new[${brandIndex}][storage_condition]"
                            class="form-control"
                            placeholder="Enter Storage Condition">
                    </div>
                    @endif

                    @if($inquire->is_product_photo)
                    <div class="form-group col-md-3">
                        <label>Product Photos</label>
                        <input 
                            type="file" 
                            name="new[${brandIndex}][product_photos][]" 
                            class="form-control-file" 
                            multiple 
                            accept="image/*"
                            id="product_photos_${brandIndex}"
                            onchange="handlePhotoPreviews(${brandIndex})"
                        >
                        <div id="photoPreviews_${brandIndex}" class="mt-2"></div> 
                    </div>
                    @endif

                    @if($inquire->is_product_doc)
                        <div class="form-group col-md-3">
                            <label>Product Documents</label>
                            <input 
                                type="file" 
                                name="new[${brandIndex}][product_documents][]" 
                                class="form-control-file" 
                                multiple 
                                accept=".pdf,.doc,.docx"
                                id="product_documents_${brandIndex}"
                                onchange="handleDocumentPreviews(${brandIndex})"
                            >
                            <div id="documentList_${brandIndex}" class="mt-2"></div> 
                        </div>
                    @endif
                </div>

                <hr class="border-dark">

                <!-- Supplier Section for this new brand -->
                <h5>Supplier Details</h5>
                <div class="form-group mb-0 d-flex justify-content-end">
                    <button type="button"
                            class="btn btn-success-rgba add-supplier-details"
                            data-brand-index="${brandIndex}">
                        <i class="fa fa-plus"></i> Supplier
                    </button>
                </div>

                <div id="new-supplier-details-container-${brandIndex}" class="mt-2">
                    <!-- Suppliers for this brand will go here -->
                </div>
            </div>
            `;
            $('.brand-details').append(newBrandHtml);

            // Reinitialize select2 on newly added elements
            initializeSelect2();
        });

        // Remove entire brand block
        $(document).on('click', '.remove-brand-detail', function() {
            let bIndex = $(this).data('brand-index');
            $(`.brand-detail-${bIndex}`).remove();
        });

        // ===============================================
        // 4. ADD SUPPLIERS INSIDE THE NEW BRAND BLOCK(S)
        // ===============================================
        $(document).on('click', '.add-supplier-details', function() {
            let bIndex = $(this).data('brand-index');
            if (typeof supplierIndices[bIndex] === 'undefined') {
                supplierIndices[bIndex] = 0;
            }
            supplierIndices[bIndex]++;

            let sIndex = supplierIndices[bIndex];

            // Build new supplier row
            let newSupplierRow = `
                <div class="row supplier-detail mt-2">
                    <input type="hidden" name="new[${bIndex}][supplier][${sIndex}][id]" value="">
                    @if($inquire->is_vendor_name)
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Vendor</label>
                            <select name="new[${bIndex}][supplier][${sIndex}][vender_id]"
                                    class="form-control select2">
                                <option value="">Select Vendor</option>
                                @foreach($venders as $v)
                                <option value="{{ $v->id }}">{{ $v->name }}</option>
                                @endforeach
                            </select>
                        </div>
                    </div>
                    @endif

                    @if($inquire->is_price_per_pack)
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Price Per Pack<span class="text-danger">*</span></label>
                            <input type="text"
                                name="new[${bIndex}][supplier][${sIndex}][price_per_pack]"
                                class="form-control"
                                placeholder="Enter Price Per Pack">
                        </div>
                    </div>
                    @endif

                    @if($inquire->is_expiry)
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Expiry Date<span class="text-danger">*</span></label>
                            <input type="month"
                                name="new[${bIndex}][supplier][${sIndex}][expiry_date]"
                                class="form-control">
                        </div>
                    </div>
                    @endif

                    @if($inquire->is_lead_time)
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Lead Time(Days)<span class="text-danger">*</span></label>
                            <input type="text"
                                name="new[${bIndex}][supplier][${sIndex}][lead_time]"
                                class="form-control"
                                placeholder="Enter Lead Time(Days)">
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

            $(`#new-supplier-details-container-${bIndex}`).append(newSupplierRow);
            initializeSelect2();
        });

        // Remove newly added supplier row (from new brand)
        $(document).on('click', '.remove-supplier-detail', function() {
            $(this).closest('.supplier-detail').remove();
        });

        // ====================================================
        // 5. OPTIONAL: BRAND -> PACK SIZE (Ajax) If required
        // ====================================================
        // If your logic requires dynamic fetching of pack sizes based on brand_id,
        // uncomment the code below, adjusting the element selectors as needed.
        //
        $(document).on('change', '.brand', function() {
            let brandId = $(this).val();
            let $packSizeDropdown = $(this).closest('.form-row').find('[name*="[product_variant_id]"]');
            $packSizeDropdown.empty().append('<option value="">Select Pack Size</option>');
            if (brandId) {
                $.ajax({
                    url: `/get-pack-sizes/${brandId}`,
                    type: 'GET',
                    success: function(response) {
                        $.each(response, function(idx, item) {
                            $packSizeDropdown.append(`<option value="${item.id}">${item.name}</option>`);
                        });
                    },
                    error: function(err) {
                        console.log('Error fetching pack sizes', err);
                    }
                });
            }
        });
    });
    </script>
    <script>
    document.addEventListener('DOMContentLoaded', function() {
        // Handle Product Photos
        var photoInput = document.getElementById('product_photos');
        if (photoInput) {
            photoInput.addEventListener('change', function(event) {
                var previewContainer = document.getElementById('photoPreviews');
                if (!previewContainer) return;

                previewContainer.innerHTML = ''; // Clear previous previews

                var files = Array.from(event.target.files);
                files.forEach(function(file) {
                    if (file.type.startsWith('image/')) {
                        var reader = new FileReader();
                        reader.onload = function(e) {
                            // Create a small container for each image + remove button
                            var div = document.createElement('div');
                            div.classList.add('photo-preview');
                            div.style.display = 'inline-block';
                            div.style.marginRight = '10px';

                            var img = document.createElement('img');
                            img.classList.add('img-thumbnail');
                            img.style.width = '50px';
                            img.style.height = '50px';
                            img.style.objectFit = 'cover';
                            img.src = e.target.result;
                            div.appendChild(img);

                            var removeButton = document.createElement('button');
                            removeButton.innerHTML = '<i class="feather icon-x" aria-hidden="true"></i>';
                            removeButton.type = 'button';
                            removeButton.classList.add('btn', 'btn-danger', 'btn-sm');
                            removeButton.style.marginLeft = '5px';
                            removeButton.style.padding = '2px 5px';
                            removeButton.style.fontSize = '12px';
                            removeButton.onclick = function() {
                                previewContainer.removeChild(div);
                                // Update the FileList in the input to remove this file
                                var dataTransfer = new DataTransfer();
                                files = files.filter(f => f !== file);
                                files.forEach(f => dataTransfer.items.add(f));
                                photoInput.files = dataTransfer.files;
                            };
                            div.appendChild(removeButton);

                            previewContainer.appendChild(div);
                        };
                        reader.readAsDataURL(file);
                    }
                });
            });
        }

        // Handle Product Documents
        var docInput = document.getElementById('product_documents');
        if (docInput) {
            docInput.addEventListener('change', function(event) {
                var documentListContainer = document.getElementById('documentList');
                if (!documentListContainer) return;

                documentListContainer.innerHTML = ''; // Clear previous document names

                var files = Array.from(event.target.files);
                files.forEach(function(file) {
                    var div = document.createElement('div');
                    div.classList.add('document-preview');
                    div.style.marginBottom = '5px';

                    var fileName = document.createElement('span');
                    fileName.textContent = file.name;
                    fileName.style.marginRight = '10px';
                    div.appendChild(fileName);

                    var removeButton = document.createElement('button');
                    removeButton.innerHTML = '<i class="feather icon-x" aria-hidden="true"></i>';
                    removeButton.type = 'button';
                    removeButton.classList.add('btn', 'btn-danger', 'btn-sm');
                    removeButton.style.padding = '2px 5px';
                    removeButton.style.fontSize = '12px';
                    removeButton.onclick = function() {
                        documentListContainer.removeChild(div);
                        // Update the FileList in the input to remove this file
                        var dataTransfer = new DataTransfer();
                        files = files.filter(f => f !== file);
                        files.forEach(f => dataTransfer.items.add(f));
                        docInput.files = dataTransfer.files;
                    };
                    div.appendChild(removeButton);

                    documentListContainer.appendChild(div);
                });
            });
        }
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
        $('form').on('submit', function(e) {
            $(this).find('button[type="submit"]').prop('disabled', true).text('Saving...');
        });
    </script>
@endsection
