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
        $sno = $generics->firstItem();
    @endphp
    @foreach($generics as $generic)
        <tr>
            <td class="font-weight-normal">{{ $sno; }}</td>
            <td class="font-weight-normal">{{ $generic->name  }}</td>
            <td class="font-weight-normal">{{ \Carbon\Carbon::parse($generic->created_at)->setTimezone('Asia/Kolkata')->format('d/m/Y') }}</td>
            <td>
                @can('generic-edit')
                    <a href="{{ route('generics.edit', ['generic' => $generic->id, 'redirect' => urlencode(url()->full())]) }}" class="btn btn-success-rgba"><i class="feather icon-edit-2"></i></a>
                    @endcan
                    @can('generic-delete')
                    <button type="button" data-generic-id="{{ $generic->id }}" class="btn btn-danger-rgba deleteGeneric"><i class="feather icon-trash"></i></button>
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
        <div class="mb-0">Showing {{ $generics->firstItem() }} to {{ $generics->lastItem() }} of
            {{ $generics->total() }} entries
        </div>
    </div>
    
    <!-- Pagination Links with Fixed Previous and Next Buttons -->
    <div class="pagination-links mt-4">
        @if ($generics->lastPage() > 1)
            <ul class="pagination">
                <!-- Previous Button -->
                <li class="page-item {{ ($generics->currentPage() == 1) ? 'disabled' : '' }}">
                    <a class="page-link" href="{{ $generics->previousPageUrl() }}">Previous</a>
                </li>

                <!-- Pagination Links -->
                @foreach(range(1, $generics->lastPage()) as $page)
                    <li class="page-item {{ ($generics->currentPage() == $page) ? 'active' : '' }}">
                        <a class="page-link" href="{{ $generics->url($page) }}">{{ $page }}</a>
                    </li>
                @endforeach

                <!-- Next Button -->
                <li class="page-item {{ ($generics->currentPage() == $generics->lastPage()) ? 'disabled' : '' }}">
                    <a class="page-link" href="{{ $generics->nextPageUrl() }}">Next</a>
                </li>
            </ul>
        @endif
    </div>
</div>