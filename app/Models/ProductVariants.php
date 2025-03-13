<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductVariants extends Model
{
    use HasFactory;

    protected $table = 'product_variants'; 
    protected $guarded = []; 

    public function orderProducts()
    {
        return $this->hasMany(OrderProduct::class, 'product_variant_id');
    }

    
    public function products()
    {
        return $this->belongsTo(Products::class, 'product_id');
    }

    protected function name(): Attribute
    {
        return Attribute::make(
            set: fn (string $value) => strtoupper($value),
        );
    }
}
