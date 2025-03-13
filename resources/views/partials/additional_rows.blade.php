@if($order->shipping > 0 && $canEdit)
    <tr>
        <td colspan="12" class="font-weight-normal text-nowrap" style="{{ $bd_department_color }}"></td>
        <td class="font-weight-bold text-nowrap" style="{{ $bd_department_color }}">Shipping</td>
        <td data-highlight-order-id="{{ $order->id }}" data-field="Shipping Cost" class="font-weight-normal text-nowrap" style="{{ $bd_department_color }}">{{ format_currency($order->shipping) }}</td>
        <td colspan="25" class="font-weight-normal text-nowrap" style="{{ $bd_department_color }}"></td>
    </tr>
@endif 
@if($order->soft_boxes > 0 && $canEdit)
    <tr>
        <td colspan="12" class="font-weight-normal text-nowrap" style="{{ $bd_department_color }}"></td>
        <td class="font-weight-bold text-nowrap" style="{{ $bd_department_color }}">Soft Boxes</td>
        <td data-highlight-order-id="{{ $order->id }}" data-field="Soft Box Price" class="font-weight-normal text-nowrap" style="{{ $bd_department_color }}">{{ format_currency($order->soft_boxes) }}</td>
        <td colspan="25" class="font-weight-normal text-nowrap" style="{{ $bd_department_color }}"></td>
    </tr>
@endif
@if($order->data_logger > 0 && $canEdit)
    <tr>
        <td colspan="12" class="font-weight-normal text-nowrap" style="{{ $bd_department_color }}"></td>
        <td class="font-weight-bold text-nowrap" style="{{ $bd_department_color }}">Data Logger</td>
        <td data-highlight-order-id="{{ $order->id }}" data-field="Data Logger Price" class="font-weight-normal text-nowrap" style="{{ $bd_department_color }}">{{ format_currency($order->data_logger) }}</td>
        <td colspan="25" class="font-weight-normal text-nowrap" style="{{ $bd_department_color }}"></td>
    </tr>
@endif
@if($order->clearance > 0 && $canEdit)
    <tr>
        <td colspan="12" class="font-weight-normal text-nowrap" style="{{ $bd_department_color }}"></td>
        <td class="font-weight-bold text-nowrap" style="{{ $bd_department_color }}">Clearance</td>
        <td data-highlight-order-id="{{ $order->id }}" data-field="Clearance Cost" class="font-weight-normal text-nowrap" style="{{ $bd_department_color }}">{{ format_currency($order->clearance) }}</td>
        <td colspan="25" class="font-weight-normal text-nowrap" style="{{ $bd_department_color }}"></td>
    </tr>
@endif
@if($totalValue >0 && $canEdit)
<tr>
    <td colspan="12" class="font-weight-normal text-nowrap" style="{{ $bd_department_color }}"></td>
    <td class="font-weight-bold text-nowrap" style="{{ $bd_department_color }}">Total</td>
    <td data-highlight-order-id="{{ $order->id }}" class="font-weight-normal text-nowrap" style="{{ $bd_department_color }}">{{ format_currency($totalValue) }}</td>
    <td colspan="25" class="font-weight-normal text-nowrap" style="{{ $bd_department_color }}"></td>
</tr>
@endif
