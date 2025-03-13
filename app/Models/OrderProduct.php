<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OrderProduct extends Model
{
    use HasFactory;

    protected $table = 'order_products'; 
    protected $guarded = []; 

    public function order()
    {
        return $this->belongsTo(Order::class, 'order_id');
    }

    public function orderProductStocks()
    {
        return $this->hasMany(OrderProductStock::class, 'order_product_id');
    }

    public function products()
    {
        return $this->belongsTo(Products::class, 'product_id');
    }

    public function productVariants()
    {
        return $this->belongsTo(ProductVariants::class, 'product_variant_id');
    }
    
    protected function note(): Attribute
    {
        return Attribute::make(
            set: function ($value) {
                return $value !== null ? strtoupper($value) : null;
            }
        );
    }

    public function product()
    {
        return $this->belongsTo(Products::class);
    }
}
