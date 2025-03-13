<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Products extends Model
{
    use HasFactory;

    protected $table = 'products';
    protected $guarded = [];

    public function orderProducts()
    {
        return $this->hasMany(OrderProduct::class, 'product_id');
    }

    public function productVariants()
    {
        return $this->hasMany(ProductVariants::class, 'product_id');
    }

    protected function name(): Attribute
    {
        return Attribute::make(
            set: function ($value) {
                return $value ? strtoupper($value) : null;
            }
        );
    }

    protected function heading(): Attribute
    {
        return Attribute::make(
            set: function ($value) {
                return $value ? strtoupper($value) : null;
            }
        );
    }

    protected function genericName(): Attribute
    {
        return Attribute::make(
            set: function ($value) {
                return $value ? strtoupper($value) : null;
            }
        );
    }

    protected function manufacturedBy(): Attribute
    {
        return Attribute::make(
            set: function ($value) {
                return $value ? strtoupper($value) : null;
            }
        );
    }

    protected function hsnCode(): Attribute
    {
        return Attribute::make(
            set: function ($value) {
                return $value ? strtoupper($value) : null;
            }
        );
    }

}
