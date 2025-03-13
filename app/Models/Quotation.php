<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Quotation extends Model
{
    use HasFactory;

    // The table associated with the model.
    protected $table = 'quotations';

    // The attributes that are mass assignable.
    protected $fillable = [
        'inquire_id',
        'type',
        'brand_id',
        'generic_id',
        'manufacturer_id',
        'product_variant_id',
        'gst',
        'storage_condition',
        'created_by',
        'updated_by',
    ];

    // Define relationships
    public function productDocuments()
    {
        return $this->hasMany(ProductDocument::class, 'quotation_id');
    }

    public function productPhotos()
    {
        return $this->hasMany(ProductPhoto::class, 'quotation_id');
    }

    public function suppliers()
    {
        return $this->hasMany(Supplier::class, 'quotation_id');
    }
    
    public function inquire()
    {
        return $this->belongsTo(Inquire::class,'inquire_id');
    }

    public function brand()
    {
        return $this->belongsTo(Products::class, 'brand_id');
    }

    public function generic()
    {
        return $this->belongsTo(Generic::class, 'generic_id');
    }

    public function manufacturer()
    {
        return $this->belongsTo(Manufacturer::class, 'manufacturer_id');
    }

    public function productVariants()
    {
        return $this->belongsTo(ProductVariants::class, 'product_variant_id');
    }
}
