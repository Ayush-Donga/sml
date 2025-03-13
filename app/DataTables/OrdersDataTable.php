<?php

namespace App\DataTables;

use App\Models\Order;
use Yajra\DataTables\Html\Button;
use Yajra\DataTables\Html\Column;
use Yajra\DataTables\Html\Editor\Editor;
use Yajra\DataTables\Html\Editor\Fields;
use Yajra\DataTables\Services\DataTable;

class OrdersDataTable extends DataTable
{
    /**
     * Build DataTable class.
     *
     * @param mixed $query Results from query() method.
     * @return \Yajra\DataTables\DataTableAbstract
     */
    public function dataTable($query)
    {
        return datatables()
            ->eloquent($query)
            ->editColumn('created_at', function ($request) {
                return $request->created_at->format('d/m/Y');
            })
            ->addColumn('brand_name', function ($request) {
                return $request->orderProducts->isNotEmpty() ? $request->orderProducts->first()->brand_name : 'N/A';
            })
            ->rawColumns(['brand_name'], true);
    }


    /**
     * Get query source of dataTable.
     *
     * @param \App\Models\Order $model
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function query(Order $model)
    {
        return $model->newQuery()->with(['orderProducts']); // Corrected to 'orderProducts'
    }

    /**
     * Optional method if you want to use html builder.
     *
     * @return \Yajra\DataTables\Html\Builder
     */
    public function html()
    {
        return $this->builder()
                    ->parameters([
                        'lengthMenu' => [[10, 20, 50, 100, 200, 500], [10, 20, 50, 100, 200, 500]],
                        'searchDelay' => 1000,
                    ])
                    ->setTableId('orders-table')
                    ->columns($this->getColumns())
                    ->minifiedAjax()
                    ->dom('Blfrtip')
                    ->orderBy(0,'desc')
                    ->buttons(
                        Button::make('create'),
                        Button::make('export'),
                        Button::make('print'),
                        Button::make('reset'),
                        Button::make('reload')
                    );
    }

    /**
     * Get columns.
     *
     * @return array
     */
    protected function getColumns()
    {
        return [
            Column::make('id'),
            Column::make('brand_name'),
            Column::make('created_at'),
        ];
    }

    /**
     * Get filename for export.
     *
     * @return string
     */
    protected function filename():string
    {
        return 'Orders_' . date('YmdHis');
    }
}
