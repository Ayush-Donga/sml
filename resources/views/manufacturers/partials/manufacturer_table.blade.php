<table class="table table-bordered">
<tr>
    <th class="font-weight-bold">SR NO</th>
    <th class="font-weight-bold">
        Name
        <i class="fa fa-sort float-right sort-link" data-sort-by="name"></i>
    </th>
    <th class="font-weight-bold">
        Created At
        <i class="fa fa-sort float-right sort-link" data-sort-by="created_at"></i>
    </th>
    <th class="font-weight-bold">Action</th>
</tr>
<tbody>
    @php
        $sno = $manufacturers->firstItem();
    @endphp
    @foreach($manufacturers as $manufacturer)
        <tr>
            <td class="font-weight-normal">{{ $sno;  }}</td>
            <td class="font-weight-normal">{{ $manufacturer->name  }}</td>
            <td class="font-weight-normal">{{ \Carbon\Carbon::parse($manufacturer->created_at)->setTimezone('Asia/Kolkata')->format('d/m/Y') }}</td>
            <td>
                @can('manufacturer-edit')
                    <a href="{{ route('manufacturers.edit', ['manufacturer' => $manufacturer->id, 'redirect' => urlencode(url()->full())]) }}" class="btn btn-success-rgba"><i class="feather icon-edit-2"></i></a>
                    @endcan
                    @can('manufacturer-delete')
                    <button type="button" data-manufacturer-id="{{ $manufacturer->id }}" class="btn btn-danger-rgba deleteManufacturer"><i class="feather icon-trash"></i></button>
                    @endcan
            </td>
        </tr>
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
        <div class="mb-0">Showing {{ $manufacturers->firstItem() }} to {{ $manufacturers->lastItem() }} of
            {{ $manufacturers->total() }} entries
        </div>
    </div>
    
    <!-- Pagination Links with Fixed Previous and Next Buttons -->
    <div class="pagination-links mt-4">
        @if ($manufacturers->lastPage() > 1)
            <ul class="pagination">
                <!-- Previous Button -->
                <li class="page-item {{ ($manufacturers->currentPage() == 1) ? 'disabled' : '' }}">
                    <a class="page-link" href="{{ $manufacturers->previousPageUrl() }}">Previous</a>
                </li>

                <!-- Pagination Links -->
                @foreach(range(1, $manufacturers->lastPage()) as $page)
                    <li class="page-item {{ ($manufacturers->currentPage() == $page) ? 'active' : '' }}">
                        <a class="page-link" href="{{ $manufacturers->url($page) }}">{{ $page }}</a>
                    </li>
                @endforeach

                <!-- Next Button -->
                <li class="page-item {{ ($manufacturers->currentPage() == $manufacturers->lastPage()) ? 'disabled' : '' }}">
                    <a class="page-link" href="{{ $manufacturers->nextPageUrl() }}">Next</a>
                </li>
            </ul>
        @endif
    </div>
</div>