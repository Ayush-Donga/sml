<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OrderPackageProduct extends Model
{
    use HasFactory;
    
    protected $table = 'order_package_products'; 
    protected $guarded = []; 
    public function orderPackage()
    {
        return $this->belongsTo(OrderPackage::class, 'order_package_id');
    }
    
}
