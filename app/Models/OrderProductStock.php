<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OrderProductStock extends Model
{
    use HasFactory;
    
    protected $table = 'order_product_stocks'; 
    protected $guarded = []; 

    public function orderProduct()
    {
        return $this->belongsTo(OrderProduct::class, 'order_product_id');
    }
    
    protected function batchNo(): Attribute
    {
        return Attribute::make(
            set: function ($value) {
                return $value ? strtoupper($value) : null;
            }
        );
    }
}
