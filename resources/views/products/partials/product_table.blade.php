<table class="table table-bordered">
    <tr>
        <th class="font-weight-bold">SR NO</th>
        <th class="font-weight-bold">
            Product Name
            <i class="fa fa-sort float-right sort-link" data-sort-by="name"></i>
        </th>
        <th class="font-weight-bold">
            Generic Name
            <i class="fa fa-sort float-right sort-link" data-sort-by="generic_name"></i>
        </th>
        <th class="font-weight-bold">
            Manufactured By
            <i class="fa fa-sort float-right sort-link" data-sort-by="manufactured_by"></i>
        </th>
        <th class="font-weight-bold">
            HSN Code
            <i class="fa fa-sort float-right sort-link" data-sort-by="hsn_code"></i>
        </th>
        <th class="font-weight-bold">Variant Name</th>
        <th class="font-weight-bold">Status</th>
        <th class="font-weight-bold">
                Created At
            <i class="fa fa-sort float-right sort-link" data-sort-by="created_at"></i>
        </th>
        <th class="font-weight-bold">Action</th>
    </tr>
<tbody>
    @php
        $sno = $products->firstItem();
    @endphp
    @foreach($products as $product)
        <tr>
            <td class="font-weight-normal">{{ $sno; }}</td>
            <td class="font-weight-normal">{{ $product->name }}</td>
            <td class="font-weight-normal">{{ $product->generic_name }}</td>
            <td class="font-weight-normal">{{ $product->manufactured_by }}</td>
            <td class="font-weight-normal">{{ $product->hsn_code }}</td>
            <td class="font-weight-normal">
                <!-- Display the first variant name -->
                @if($product->productVariants->isNotEmpty())
                    {{ $product->productVariants->first()->name }}
                    <!-- Button to show more variant names -->
                    @if($product->productVariants->count() > 1)
                        <button type="button" class="btn btn-primary-rgba" onclick="showVariantPopup({{ $product->id }})">More</button>
                    @endif
                @endif
            </td>
            <td>
                <div class="custom-control custom-switch">
                    <input type="checkbox" class="custom-control-input" id="customSwitch{{ $product->id }}" data-product-id="{{ $product->id }}" {{ $product->status ? 'checked' : '' }}>
                    <label class="custom-control-label" for="customSwitch{{ $product->id }}"></label>
                </div>
            </td>
            <td class="font-weight-normal">{{ \Carbon\Carbon::parse($product->created_at)->setTimezone('Asia/Kolkata')->format('d/m/Y') }}</td>
            <td>
                <div class="button-list">
                    @can('product-edit')
                        <a href="{{ route('products.edit', ['product' => $product->id, 'redirect' => urlencode(url()->full())]) }}" class="btn btn-success-rgba"><i class="feather icon-edit-2"></i></a>
                    @endcan
                    @can('product-delete')
                        <button type="button" data-product-id="{{ $product->id }}" class="btn btn-danger-rgba deleteProduct"><i class="feather icon-trash"></i></button>
                    @endcan
                </div>
            </td>
        </tr>
        @php
            $sno++;
        @endphp
    @endforeach
</tbody>
</table>
<div class="d-flex justify-content-between align-items-center">
    <!-- Pagination Text -->
    <div>
        <div class="mb-0">Showing {{ $products->firstItem() }} to {{ $products->lastItem() }} of
            {{ $products->total() }} entries
        </div>
    </div>
    
    <!-- Pagination Links with Fixed Previous and Next Buttons -->
    <div class="pagination-links mt-4">
        @if ($products->lastPage() > 1)
            <ul class="pagination">
                <!-- Previous Button -->
                <li class="page-item {{ ($products->currentPage() == 1) ? 'disabled' : '' }}">
                    <a class="page-link" href="{{ $products->previousPageUrl() }}">Previous</a>
                </li>

                <!-- Pagination Links -->
                @foreach(range(1, $products->lastPage()) as $page)
                    <li class="page-item {{ ($products->currentPage() == $page) ? 'active' : '' }}">
                        <a class="page-link" href="{{ $products->url($page) }}">{{ $page }}</a>
                    </li>
                @endforeach

                <!-- Next Button -->
                <li class="page-item {{ ($products->currentPage() == $products->lastPage()) ? 'disabled' : '' }}">
                    <a class="page-link" href="{{ $products->nextPageUrl() }}">Next</a>
                </li>
            </ul>
        @endif
    </div>
</div>
