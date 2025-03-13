<table class="table table-bordered">
<tr>
    <th class="font-weight-bold text-nowrap">SR NO</th>
    <th class="font-weight-bold text-nowrap">Quote Number</th>
    <th class="font-weight-bold text-nowrap">Type</th>
    <th class="font-weight-bold text-nowrap">Brand Name</th>
    <th class="font-weight-bold text-nowrap">Generic Name</th>
    <th class="font-weight-bold text-nowrap">No Of Brand</th>
    <th class="font-weight-bold text-nowrap">Status</th>
    <th class="font-weight-bold text-nowrap">Quantity</th>
    <th class="font-weight-bold text-nowrap">No Of Supplier</th>
    <th class="font-weight-bold text-nowrap">Required Field</th>
    <th class="font-weight-bold text-nowrap">Assined User</th>
    <th class="font-weight-bold">Created At</th>
    <th class="font-weight-bold text-nowrap">Action</th>
</tr>
<tbody>
    @php
        $sno = $inquires->firstItem();
    @endphp
    @foreach($inquires as $inquire)
    @if($inquire->status !== 'close')
        <tr>
            <td class="font-weight-normal text-nowrap">{{ $sno;  }}</td>
            <td class="font-weight-normal text-nowrap">{{ $inquire->quote_number  }}</td>
            <td class="font-weight-normal text-nowrap">{{ $inquire->type  }}</td>
            <td class="font-weight-normal text-nowrap">
                @php
                    $brandName = $brands->firstWhere('id', $inquire->brand_id)->name ?? '';
                    $shortBrandName = Str::limit($brandName, 60);
                @endphp
                <span data-toggle="tooltip" title="{{ $brandName }}">
                    {{ $shortBrandName }}
                </span>
            </td>
            <td class="font-weight-normal text-nowrap">
                @php
                    $genericName = $generics->firstWhere('id', $inquire->generic_id)->name ?? '';
                    $shortGenericName = Str::limit($genericName, 60);
                @endphp
                <span data-toggle="tooltip" title="{{ $genericName }}">
                    {{ $shortGenericName }}
                </span>
            </td>
            <td class="font-weight-normal text-nowrap">{{ $inquire->no_of_brand  }}</td>
            <td class="font-weight-normal text-nowrap">{{ $inquire->status  }}</td>
            <td class="font-weight-normal text-nowrap">{{ $inquire->quantity  }}</td>
            <td class="font-weight-normal text-nowrap">{{ $inquire->no_of_supplier  }}</td>
            <td class="font-weight-normal text-nowrap">
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
                        'is_expiry' => 'Expiry',
                        'is_lead_time' => 'Lead Time',
                    ];

                    $fields = [];
                    foreach ($fieldMap as $field => $name) {
                        if ($inquire->$field) {
                            $fields[] = $name;
                        }
                    }

                    $tooltipText = implode(', ', $fields);
                    $shortText = Str::limit($tooltipText, 60);
                @endphp

                <span data-toggle="tooltip" title="{{ $tooltipText }}">
                    {{ $shortText }}
                </span>
            </td>
            <td class="font-weight-normal text-nowrap">
                @foreach($users as $user)
                    @if($user->id === $inquire->assigned_user_id)
                        {{ $user->name }}
                    @endif
                @endforeach
            </td>
            <td class="font-weight-normal text-nowrap">{{ \Carbon\Carbon::parse($inquire->created_at)->setTimezone('Asia/Kolkata')->format('d/m/Y') }}</td>
            <td class="font-weight-normal text-nowrap">
                @can('inquire-edit')
                    <a href="{{ route('inquires.edit', ['inquire' => $inquire->id, 'redirect' => urlencode(url()->full())]) }}" class="btn btn-success-rgba"><i class="feather icon-edit-2"></i></a>
                    @endcan
                    @can('inquire-delete')
                    <button type="button" data-inquire-id="{{ $inquire->id }}" class="btn btn-danger-rgba deleteInquire"><i class="feather icon-trash"></i></button>
                    @endcan
                    @can('quotation-create')
                    @if($inquire->assigned_user_id === null)
                        <button type="button" data-assign-inquire-id="{{ $inquire->id }}" class="btn btn-primary-rgba assignInquire">Assign Me</button>
                    @endif
                @endcan
                @can('quotation-create')
                    @if($inquire->assigned_user_id !== null)
                        <a href="{{ route('quotations.create', ['id' => $inquire->id, 'redirect' => urlencode(url()->full())]) }}" class="btn btn-primary-rgba "><i class="feather icon-eye"></i></a>
                    @endif
                @endcan                                 
            </td>
        </tr>
        @endif
        @php
            $sno++;
        @endphp
    @endforeach
</tbody>
</table>
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