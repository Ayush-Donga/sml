<?php

namespace App\DataTables;

use App\Models\User;
use Illuminate\Database\Eloquent\Builder as QueryBuilder;
use Yajra\DataTables\EloquentDataTable;
use Yajra\DataTables\Html\Builder as HtmlBuilder;
use Yajra\DataTables\Html\Button;
use Yajra\DataTables\Html\Column;
use Yajra\DataTables\Services\DataTable;

class UsersDataTable extends DataTable
{
    public function dataTable(QueryBuilder $query): EloquentDataTable
    {
        return (new EloquentDataTable($query))
            ->addIndexColumn() // Add this to generate the 'DT_RowIndex'
            ->addColumn('roles', function ($user) {
                return implode(', ', $user->roles->pluck('name')->toArray());
            })
            ->addColumn('parent_name', function ($user) {
                return $user->parent ? $user->parent->name : '';
            })
            ->editColumn('created_at', function ($user) {
                return $user->created_at->format('d/m/Y');
            })
            ->editColumn('status', function ($user) {
                return $user->status == 1 ? '<span class="text-success" style="font-weight:500;">Active</span>' : '<span class="text-danger" style="font-weight:500;">Deactive</span>';
            })
            ->addColumn('action', function ($user) {
                return '<div class="button-list">
                            <a href="' . route('users.show', $user->id) . '" class="btn btn-primary-rgba"><i class="feather icon-eye"></i></a>' .
                    (auth()->user()->can('user-edit') ? '<a href="' . route('users.edit', ['user' => $user->id, 'redirect' => urlencode(url()->full())]) . '" class="btn btn-success-rgba"><i class="feather icon-edit-2"></i></a>' : '') .
                    (auth()->user()->can('user-delete') ? '<button class="btn btn-danger-rgba delete-user" data-id="' . $user->id . '" data-name="' . $user->name . '"><i class="feather icon-trash"></i></button>' : '') .
                    (auth()->user()->can('user-reset-password') ? '<a href="' . route('users.resetPassword', $user->id) . '" class="btn btn-warning-rgba"><i class="feather icon-lock"></i></a>' : '') .
                    '</div>';
            })
            // Filtering logic remains the same:
            ->filterColumn('roles', function ($query, $keyword) {
                $query->whereHas('roles', function ($q) use ($keyword) {
                    $q->where('name', 'like', "%{$keyword}%");
                });
            })
            ->filterColumn('parent_name', function ($query, $keyword) {
                $query->whereHas('parent', function ($q) use ($keyword) {
                    $q->where('name', 'like', "%{$keyword}%");
                });
            })
            ->filterColumn('created_at', function ($query, $keyword) {
                $query->whereRaw("DATE_FORMAT(created_at, '%d/%m/%Y') like ?", ["%{$keyword}%"]);
            })
            ->filterColumn('status', function ($query, $keyword) {
                if (strtolower($keyword) == 'active') {
                    $query->where('status', 1);
                } elseif (strtolower($keyword) == 'deactive') {
                    $query->where('status', 0);
                }
            })
              // Custom order for 'roles' (sub-select approach)
            ->orderColumn('roles', function ($query, $direction) {
                $query->orderBy(
                    \DB::raw("(
                        SELECT GROUP_CONCAT(r.name SEPARATOR ', ')
                        FROM model_has_roles m
                        JOIN roles r ON r.id = m.role_id
                        WHERE m.model_id = users.id
                        GROUP BY m.model_id
                    )"),
                    $direction
                );
            })

            // Custom order for 'parent_name' (sub-select approach)
            ->orderColumn('parent_name', function ($query, $direction) {
                // Assuming 'parent_id' is the foreign key.
                // We can do a sub-select of the user's parent's name:
                $query->orderBy(
                    \DB::raw("(
                        SELECT u.name
                        FROM users u
                        WHERE u.id = users.parent_id
                    )"),
                    $direction
                );
            })
            ->setRowId('id')
            ->rawColumns(['status', 'action']);
    }

    public function html(): HtmlBuilder
    {
        return $this->builder()
            ->setTableId('users-table')
            ->columns($this->getColumns())
            ->minifiedAjax()
            ->orderBy(1) // Update the default order
            //  ->orderBy(5, 'asc')
            ->buttons([
                Button::make('pageLength'),
                Button::make('create'),
                Button::make('export'),
                Button::make('print'),
                Button::make('reset'),
                Button::make('reload'),
            ])
            ->parameters([
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
            Column::make('email'),
            Column::make('roles')->orderable(true),
            Column::make('parent_name')->title('Parent Name')->orderable(true),
            Column::make('created_at')->title('Created At'),
            Column::computed('status')
                ->exportable(false)
                ->printable(false)
                ->width(80)
                ->addClass('text-center'),
            Column::computed('action')
                ->exportable(false)
                ->printable(false)
                ->width(100)
                ->addClass('text-center'),
        ];
    }

    public function query(User $model): QueryBuilder
    {
        return $model->newQuery()->with(['roles', 'parent']);
        // ->orderBy('created_at', 'asc')
    }

    protected function filename(): string
    {
        return 'Users_' . date('YmdHis');
    }
}
