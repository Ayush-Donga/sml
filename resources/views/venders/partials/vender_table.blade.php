<table class="table table-bordered">
<tr>
        <th class="font-weight-bold">SR NO</th>
        <th class="font-weight-bold">
            Name
            <i class="fa fa-sort float-right sort-link" data-sort-by="name"></i>
        </th>
        <th class="font-weight-bold">
            Email
            <i class="fa fa-sort float-right sort-link" data-sort-by="email"></i>
        </th>
        <th class="font-weight-bold">
            Phone Number
            <i class="fa fa-sort float-right sort-link" data-sort-by="phone"></i>
        </th>
        <th class="font-weight-bold">
            Location
            <i class="fa fa-sort float-right sort-link" data-sort-by="location"></i>
        </th>
        <th class="font-weight-bold">
            Created At
            <i class="fa fa-sort float-right sort-link" data-sort-by="created_at"></i>
        </th>
        <th class="font-weight-bold">Action</th>
    </tr>
<tbody>
    @php
        $sno = $venders->firstItem();
    @endphp
    @foreach($venders as $vender)
        <tr>
            <td class="font-weight-normal">{{ $sno; }}</td>
            <td class="font-weight-normal">{{ $vender->name  }}</td>
            <td class="font-weight-normal">{{ $vender->email }}</td>
            <td class="font-weight-normal">{{ $vender->phone }}</td>
            <td class="font-weight-normal">{{ $vender->location }}</td>
            <td class="font-weight-normal">{{ \Carbon\Carbon::parse($vender->created_at)->setTimezone('Asia/Kolkata')->format('d/m/Y') }}</td>
            <td>
                @can('vender-edit')
                    <a href="{{ route('venders.edit', ['vender' => $vender->id, 'redirect' => urlencode(url()->full())]) }}" class="btn btn-success-rgba"><i class="feather icon-edit-2"></i></a>
                    @endcan
                    @can('vender-delete')
                    <button type="button" data-vender-id="{{ $vender->id }}" class="btn btn-danger-rgba deleteVender"><i class="feather icon-trash"></i></button>
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
        <div class="mb-0">Showing {{ $venders->firstItem() }} to {{ $venders->lastItem() }} of
            {{ $venders->total() }} entries
        </div>
    </div>
    
    <!-- Pagination Links with Fixed Previous and Next Buttons -->
    <div class="pagination-links mt-4">
        @if ($venders->lastPage() > 1)
            <ul class="pagination">
                <!-- Previous Button -->
                <li class="page-item {{ ($venders->currentPage() == 1) ? 'disabled' : '' }}">
                    <a class="page-link" href="{{ $venders->previousPageUrl() }}">Previous</a>
                </li>

                <!-- Pagination Links -->
                @foreach(range(1, $venders->lastPage()) as $page)
                    <li class="page-item {{ ($venders->currentPage() == $page) ? 'active' : '' }}">
                        <a class="page-link" href="{{ $venders->url($page) }}">{{ $page }}</a>
                    </li>
                @endforeach

                <!-- Next Button -->
                <li class="page-item {{ ($venders->currentPage() == $venders->lastPage()) ? 'disabled' : '' }}">
                    <a class="page-link" href="{{ $venders->nextPageUrl() }}">Next</a>
                </li>
            </ul>
        @endif
    </div>
</div>