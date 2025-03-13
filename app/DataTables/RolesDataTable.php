<?php

namespace App\DataTables;

use Spatie\Permission\Models\Role;
use Illuminate\Database\Eloquent\Builder as QueryBuilder;
use Yajra\DataTables\EloquentDataTable;
use Yajra\DataTables\Html\Builder as HtmlBuilder;
use Yajra\DataTables\Html\Button;
use Yajra\DataTables\Html\Column;
use Yajra\DataTables\Services\DataTable;

class RolesDataTable extends DataTable
{
    public function dataTable(QueryBuilder $query): EloquentDataTable
    {
        return (new EloquentDataTable($query))
            ->addIndexColumn()
            ->editColumn('name', function ($role) {
                $name = $role->name;
                $truncatedName = strlen($name) > 100 ? substr($name, 0, 100) . '...' : $name;

                return strlen($name) > 100
                    ? '<span title="' . e($name) . '">' . e($truncatedName) . '</span>'
                    : e($name);
            })
            ->editColumn('created_at', function ($role) {
                return $role->created_at->format('d/m/Y');
            })
            ->addColumn('action', function ($role) {
                return '<div class="button-list">
                            <a href="' . route('roles.show', $role->id) . '" class="btn btn-primary-rgba"><i class="feather icon-eye"></i></a>'
                            . (auth()->user()->can('role-edit') 
                                ? '<a href="' . route('roles.edit', ['role' => $role->id, 'redirect' => urlencode(url()->full())]) . '" class="btn btn-success-rgba"><i class="feather icon-edit-2"></i></a>' 
                                : '')
                            . (auth()->user()->can('role-delete') 
                                ? '<button type="button" class="btn btn-danger-rgba delete-role" data-id="' . $role->id . '" data-name="' . $role->name . '"><i class="feather icon-trash"></i></button>' 
                                : '')
                        . '</div>';
            })
            ->filterColumn('created_at', function ($query, $keyword) {
                $query->whereRaw("DATE_FORMAT(created_at, '%d/%m/%Y') like ?", ["%{$keyword}%"]);
            })
            ->setRowId('id')
            ->rawColumns(['name', 'action']);
    }

    public function query(Role $model): QueryBuilder
    {
        // Remove the forced orderBy to let DataTables handle sorting
        return $model->newQuery();
    }

    public function html(): HtmlBuilder
    {
        return $this->builder()
            ->setTableId('roles-table')
            ->columns($this->getColumns())
            ->minifiedAjax()
            ->dom('Blfrtip')
            // This means "default sort by the second column (index=1), ascending"
            // If you want 'created_at' descending by default, do ->orderBy(3, 'desc').
            ->orderBy(1)
            ->buttons(
                Button::make('create'),
                Button::make('export'),
                Button::make('print'),
                Button::make('reset'),
                Button::make('reload')
            )
            ->parameters([
                'processing' => true,    // <-- make sure these are here
                'serverSide' => true,
                'stateSave' => true, 
                'stateDuration' => -1,
            ]);
    }

    public function getColumns(): array
    {
        return [
            Column::computed('DT_RowIndex')
                ->title('SR NO')
                ->searchable(false)
                ->orderable(false)
                ->width(50),
            Column::make('name'),
            // If you have 'type' in your DB table, keep it; otherwise remove/comment out
            Column::make('type'),
            Column::make('created_at')->title('Created At'),
            Column::computed('action')
                ->exportable(false)
                ->printable(false)
                ->width(180)
                ->addClass('text-center'),
        ];
    }

    protected function filename(): string
    {
        return 'Roles_' . date('YmdHis');
    }
}
