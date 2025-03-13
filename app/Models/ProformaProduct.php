<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProformaProduct extends Model
{
    use HasFactory;

    protected $fillable = [
        'proforma_id',
        'product_id',
        'product_variant_id',
        'quantity',
        'price_per_set',
        'total',
    ];

    /**
     * Get the proforma that owns the proforma product.
     */
    public function proforma()
    {
        return $this->belongsTo(Proforma::class, 'proforma_id');
    }

    /**
     * Get the product that owns the proforma product.
     */
    public function products()
    {
        return $this->belongsTo(Products::class, 'product_id');
    }

    /**
     * Get the product variant that owns the proforma product.
     */
    public function productVariants()
    {
        return $this->belongsTo(ProductVariants::class, 'product_variant_id');
    }
}
