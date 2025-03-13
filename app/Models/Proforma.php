<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Proforma extends Model
{
    use HasFactory;

    protected $table = 'proformas';

    protected $fillable = [
        'order_id',
        'country',
        'order_date',
        'serve_date',
        'invoice_no',
        'invoice_date',
        'currency',
        'shipping',
        'soft_boxes',
        'data_logger',
        'clearance',
        'payment_terms',
        'delivery_by',
        'delivery_time',
        'delivery_terms',
        'status',
        'bill_to_customer_id',
        'bill_to_client_code',
        'bill_to_company_name',
        'bill_to_email',
        'bill_to_phone_no',
        'bill_to_registration_no',
        'bill_to_address',
        'bill_to_zip_code',
        'ship_to_customer_id',
        'ship_to_client_code',
        'ship_to_company_name',
        'ship_to_email',
        'ship_to_phone_no',
        'ship_to_registration_no',
        'ship_to_address',
        'ship_to_zip_code',
        'created_by',
        'updated_by'
    ];

    public function proformaProducts()
    {
        return $this->hasMany(ProformaProduct::class, 'proforma_id');
    }

    public function order()
    {
        return $this->belongsTo(Order::class, 'order_id');
    }

    public function billToCustomer()
    {
        return $this->belongsTo(Customers::class, 'bill_to_customer_id');
    }

    public function shipToCustomer()
    {
        return $this->belongsTo(Customers::class, 'ship_to_customer_id');
    }

    public function setClientCodeAttribute($value)
    {
        $this->attributes['clientCode'] = $value !== null ? strtoupper($value) : null;
    }

    public function setCountryAttribute($value)
    {
        $this->attributes['country'] = $value !== null ? strtoupper($value) : null;
    }

    public function setPaymentTermsAttribute($value)
    {
        $this->attributes['payment_terms'] = $value !== null ? strtoupper($value) : null;
    }

    public function setDeliveryByAttribute($value)
    {
        $this->attributes['delivery_by'] = $value !== null ? strtoupper($value) : null;
    }

    public function setDeliveryTimeAttribute($value)
    {
        $this->attributes['delivery_time'] = $value !== null ? strtoupper($value) : null;
    }

    public function setdeliveryTermsAttribute($value)
    {
        $this->attributes['delivery_terms'] = $value !== null ? strtoupper($value) : null;
    }
}
