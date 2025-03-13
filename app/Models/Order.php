<?php

namespace App\Models;

// use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    use HasFactory;

    protected $table = 'orders';
    protected $guarded = [];

    public function orderProducts()
    {
        return $this->hasMany(OrderProduct::class, 'order_id');
    }

    public function orderPackages()
    {
        return $this->hasMany(OrderPackage::class, 'order_id');
    }

    public function setClientCodeAttribute($value)
    {
        $this->attributes['clientCode'] = $value !== null ? strtoupper($value) : null;
    }

    public function setBillToAttribute($value)
    {
        $this->attributes['billTo'] = $value !== null ? strtoupper($value) : null;
    }

    public function setShipToAttribute($value)
    {
        $this->attributes['shipTo'] = $value !== null ? strtoupper($value) : null;
    }

    public function setCountryAttribute($value)
    {
        $this->attributes['country'] = $value !== null ? strtoupper($value) : null;
    }

    public function setPiNumberAttribute($value)
    {
        $this->attributes['pi_number'] = $value !== null ? strtoupper($value) : null;
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

    public function setDeliveryTermsAttribute($value)
    {
        $this->attributes['delivery_terms'] = $value !== null ? strtoupper($value) : null;
    }
    public function setPortOfDischarge($value)
    {
        $this->attributes['port_of_discharge'] = $value !== null ? strtoupper($value) : null;
    }
}

