<table class="table table-bordered">
<tr>
    <th class="font-weight-bold">SR NO</th>
    <th class="font-weight-bold">
            Bank Name
        <i class="fa fa-sort float-right sort-link" data-sort-by="name"></i>
    </th>
    <th class="font-weight-bold">
            Account Name
        <i class="fa fa-sort float-right sort-link" data-sort-by="account_name"></i>
    </th>
    <th class="font-weight-bold">
            Account Number
        <i class="fa fa-sort float-right sort-link" data-sort-by="account_no"></i>
    </th>
    <th class="font-weight-bold">
            Swift Code No
        <i class="fa fa-sort float-right sort-link" data-sort-by="swift_code_no"></i>
    </th>
    <th class="font-weight-bold">
            IFSC Code
        <i class="fa fa-sort float-right sort-link" data-sort-by="ifsc_code"></i>
    </th>
    <th class="font-weight-bold">
            Branch
        <i class="fa fa-sort float-right sort-link" data-sort-by="branch"></i>
    </th>
    <th class="font-weight-bold">
            Created At
        <i class="fa fa-sort float-right sort-link" data-sort-by="created_at"></i>
    </th>
    <th class="font-weight-bold">Action</th>
</tr>
<tbody>
    @php
        $sno = $banks->firstItem();
    @endphp
    @foreach($banks as $bank)
        <tr>
            <td class="font-weight-normal">{{ $sno;  }}</td>
            <td class="font-weight-normal">{{ $bank->name  }}</td>
            <td class="font-weight-normal">{{ $bank->account_name }}</td>
            <td class="font-weight-normal">{{ $bank->account_no }}</td>
            <td class="font-weight-normal">{{ $bank->swift_code_no }}</td>
            <td class="font-weight-normal">{{ $bank->ifsc_code }}</td>
            <td class="font-weight-normal">{{ $bank->branch }}</td>
            <td class="font-weight-normal">{{ \Carbon\Carbon::parse($bank->created_at)->setTimezone('Asia/Kolkata')->format('d/m/Y') }}</td>
            <td>
                @can('bank-edit')
                    <a href="{{ route('banks.edit', ['bank' => $bank->id, 'redirect' => urlencode(url()->full())]) }}" class="btn btn-success-rgba"><i class="feather icon-edit-2"></i></a>
                    @endcan
                    @can('bank-delete')
                    <button type="button" data-bank-id="{{ $bank->id }}" class="btn btn-danger-rgba deleteBank"><i class="feather icon-trash"></i></button>
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
        <div class="mb-0">Showing {{ $banks->firstItem() }} to {{ $banks->lastItem() }} of
            {{ $banks->total() }} entries
        </div>
    </div>
    
    <!-- Pagination Links with Fixed Previous and Next Buttons -->
    <div class="pagination-links mt-4">
        @if ($banks->lastPage() > 1)
            <ul class="pagination">
                <!-- Previous Button -->
                <li class="page-item {{ ($banks->currentPage() == 1) ? 'disabled' : '' }}">
                    <a class="page-link" href="{{ $banks->previousPageUrl() }}">Previous</a>
                </li>

                <!-- Pagination Links -->
                @foreach(range(1, $banks->lastPage()) as $page)
                    <li class="page-item {{ ($banks->currentPage() == $page) ? 'active' : '' }}">
                        <a class="page-link" href="{{ $banks->url($page) }}">{{ $page }}</a>
                    </li>
                @endforeach

                <!-- Next Button -->
                <li class="page-item {{ ($banks->currentPage() == $banks->lastPage()) ? 'disabled' : '' }}">
                    <a class="page-link" href="{{ $banks->nextPageUrl() }}">Next</a>
                </li>
            </ul>
        @endif
    </div>
</div>