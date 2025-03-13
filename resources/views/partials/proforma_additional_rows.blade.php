@if($proforma->shipping > 0)
    <tr>
        <td colspan="11" class="font-weight-normal text-nowrap"></td>
        <td class="font-weight-bold text-nowrap">Shipping</td>
        <td class="font-weight-normal text-nowrap">{{ format_currency($proforma->shipping) }}</td>
        <td colspan="1" class="font-weight-normal text-nowrap"></td>
    </tr>
@endif
@if($proforma->soft_boxes > 0)
    <tr>
        <td colspan="11" class="font-weight-normal text-nowrap"></td>
        <td class="font-weight-bold text-nowrap">Soft Boxes</td>
        <td class="font-weight-normal text-nowrap">{{ format_currency($proforma->soft_boxes) }}</td>
        <td colspan="1" class="font-weight-normal text-nowrap"></td>
    </tr>
@endif
@if($proforma->data_logger > 0)
    <tr>
        <td colspan="11" class="font-weight-normal text-nowrap"></td>
        <td class="font-weight-bold text-nowrap">Data Logger</td>
        <td class="font-weight-normal text-nowrap">{{ format_currency($proforma->data_logger) }}</td>
        <td colspan="1" class="font-weight-normal text-nowrap"></td>
    </tr>
@endif
@if($proforma->clearance > 0)
    <tr>
        <td colspan="11" class="font-weight-normal text-nowrap"></td>
        <td class="font-weight-bold text-nowrap">Clearance</td>
        <td class="font-weight-normal text-nowrap">{{ format_currency($proforma->clearance) }}</td>
        <td colspan="1" class="font-weight-normal text-nowrap"></td>
    </tr>
@endif
@if($totalValue >0)
<tr>
    <td colspan="11" class="font-weight-normal text-nowrap"></td>
    <td class="font-weight-bold text-nowrap">Total</td>
    <td class="font-weight-normal text-nowrap">{{ format_currency($totalValue) }}</td>
    <td colspan="1" class="font-weight-normal text-nowrap"></td>
</tr>
@endif
