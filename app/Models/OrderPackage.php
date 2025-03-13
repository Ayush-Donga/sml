<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OrderPackage extends Model
{
    use HasFactory;

    protected $table = 'order_packages';
    protected $guarded = [];

    public function order()
    {
        return $this->belongsTo(Order::class, 'order_id');
    }
    public function orderPackageProducts()
    {
        return $this->hasMany(OrderPackageProduct::class, 'order_package_id');
    }


    protected function boxNo(): Attribute
    {
        return Attribute::make(
            set: function ($value) {
                return $value ? strtoupper($value) : null;
            }
        );
    }

    protected function dimension(): Attribute
    {
        return Attribute::make(
            set: function ($value) {
                return $value ? strtoupper($value) : null;
            }
        );
    }

}

