<table class="table table-bordered">
    <thead>
        <tr>
            <th class="font-weight-bold">
                SR NO
            </th>
            <th class="font-weight-bold">
                Client Code
                <i class="fa fa-sort float-right sort-link" data-sort-by="client_code"></i>
            </th>
            <th class="font-weight-bold">
                Company / Patient Name
                <i class="fa fa-sort float-right sort-link" data-sort-by="company_name"></i>
            </th>
            <th class="font-weight-bold">
                Ship To
                <i class="fa fa-sort float-right sort-link" data-sort-by="ship_to_name"></i>
            </th>
            <th class="font-weight-bold">
                    Created At
                <i class="fa fa-sort float-right sort-link" data-sort-by="created_at"></i>
            </th>
            <th class="font-weight-bold">Action</th>
        </tr>
    </thead>
    <tbody>
        @php
            $sno = $customers->firstItem();
        @endphp
        @forelse($customers as $customer)
            <tr>
                <td>{{ $sno; }}</td>
                <td>{{ $customer->client_code }}</td>
                <td>{{ $customer->company_name }}</td>
                <td>
                    @foreach ($parents as $parent)
                        @if ($customer->id === $parent->parent_id)
                            {{ $parent->company_name }}
                            @break
                        @endif
                    @endforeach
                </td>
                <td class="font-weight-normal">{{ \Carbon\Carbon::parse($customer->created_at)->setTimezone('Asia/Kolkata')->format('d/m/Y') }}</td>
                <td>
                    @can('customer-edit')
                        <a href="{{ route('customers.edit', ['customer' => $customer->id, 'redirect' => urlencode(url()->full())]) }}" class="btn btn-success-rgba"><i class="feather icon-edit-2"></i></a>
                    @endcan
                    @can('customer-delete')
                        <button type="button" data-customer-id="{{ $customer->id }}" class="btn btn-danger-rgba deleteCustomer"><i class="feather icon-trash"></i></button>
                    @endcan
                </td>
            </tr>
            @php
                $sno++;
            @endphp
        @empty
            <tr>
                <td colspan="5" class="text-center">No customers found.</td>
            </tr>
        @endforelse
    </tbody>
</table>

<!-- Pagination Links -->
<div class="d-flex justify-content-between align-items-center">
    <!-- Pagination Text -->
    <div>
        <div class="mb-0">Showing {{ $customers->firstItem() }} to {{ $customers->lastItem() }} of
            {{ $customers->total() }} entries
        </div>
    </div>
    
    <!-- Pagination Links with Fixed Previous and Next Buttons -->
    <div class="pagination-links mt-4">
        @if ($customers->lastPage() > 1)
            <ul class="pagination">
                <!-- Previous Button -->
                <li class="page-item {{ ($customers->currentPage() == 1) ? 'disabled' : '' }}">
                    <a class="page-link" href="{{ $customers->previousPageUrl() }}">Previous</a>
                </li>

                <!-- Page Numbers -->
                @foreach(range(1, $customers->lastPage()) as $page)
                    <li class="page-item {{ ($customers->currentPage() == $page) ? 'active' : '' }}">
                        <a class="page-link" href="{{ $customers->url($page) }}">{{ $page }}</a>
                    </li>
                @endforeach

                <!-- Next Button -->
                <li class="page-item {{ ($customers->currentPage() == $customers->lastPage()) ? 'disabled' : '' }}">
                    <a class="page-link" href="{{ $customers->nextPageUrl() }}">Next</a>
                </li>
            </ul>
        @endif
    </div>
</div>
