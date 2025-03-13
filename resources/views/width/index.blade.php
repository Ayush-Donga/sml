@section('title')
Weight
@endsection
@extends('layouts.main')
@section('style')
<!-- Sweet Alert css -->
<link href="{{ asset('assets/plugins/sweet-alert2/sweetalert2.min.css') }}" rel="stylesheet" type="text/css" />
<!-- DataTables css -->
<link href="{{ asset('assets/plugins/datatables/dataTables.bootstrap4.min.css') }}" rel="stylesheet" type="text/css" />
<link href="{{ asset('assets/plugins/datatables/buttons.bootstrap4.min.css') }}" rel="stylesheet" type="text/css" />
<!-- Responsive Datatable css -->
<link href="{{ asset('assets/plugins/datatables/responsive.bootstrap4.min.css') }}" rel="stylesheet" type="text/css" />
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
                    <li class="breadcrumb-item active" aria-current="page">@yield('title')</li>
                </ol>
            </div>
        </div>
        <div class="col-md-4 col-lg-4">
            <div class="widgetbar">
                @can('weight-create')
                    <a href="{{ route('width.create') }}" class="btn btn-primary-rgba"><i class="feather icon-plus mr-2"></i>Add New Weight</a>
                @endcan
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
<!-- Start Contentbar -->
<div class="contentbar">
    <!-- Start row -->
    <div class="row">


        <!-- Start col -->
        <div class="col-lg-12">
            <div class="card m-b-30">
                <div class="card-header">
                    <div class="row align-items-center">

                        <div class="col-6">
                            <h5 class="card-title mb-0">All Weights</h5>
                        </div>
                    </div>
                </div>
                <div class="card-body">

                    <div class="table-responsive">
                        {!! $dataTable->table(['class' => 'display table table-striped table-bordered']) !!}
                    </div>
                </div>
            </div>
        </div>
        <!-- End col -->
    </div>
    <!-- End row -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Are You Sure to Delete Weight</h5>
            </div>
            <div class="modal-body">
                Are you sure want to delete <strong><span class="item-name"></span></strong>?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-primary" onclick="closeModal()">Close</button>
                <button type="button" class="btn btn-outline-danger confirm-delete" onclick="deleteCategory()">Delete</button>
            </div>
        </div>
    </div>
</div>
</div>
<!-- End Contentbar -->
@endsection
@section('script')
<script src="{{ asset('vendor/datatables/buttons.server-side.js') }}"></script>
{{$dataTable->scripts()}}
<script>
    let id;
    let itemName;

    function closeModal() {
        $('#deleteModal').modal('hide');
    }

    function deleteCategory() {
        var token = $('input[name="_token"]').val();
        $.ajax({
            url: "width/" + id,
            method: 'DELETE',
            data: {
                "id": id,
                "_token": token,
            },
            success: function(res) {
                window.location.reload(true);
            }
        })
    }

    $(document).on('click', '.delete-width', function(e) {
        id = $(this).attr('data-id');
        itemName = $(this).attr('data-name');
        $('.item-name').html(itemName);
        $('#deleteModal').modal('show');
    })
</script>

<!-- Datatable js -->
<script src="{{ asset('assets/plugins/datatables/jquery.dataTables.min.js') }}"></script>
<script src="{{ asset('assets/plugins/datatables/dataTables.bootstrap4.min.js') }}"></script>

@endsection
