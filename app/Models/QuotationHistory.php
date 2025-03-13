<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class QuotationHistory extends Model
{
    use HasFactory;
    // Table name
    protected $table = 'quotations_histories';
    // Fillable attributes
    protected $fillable = [
        'inquiry_history_id',
        'brand_id',
        'generic_id',
        'manufacturer_id',
        'product_variant_id',
        'gst',
        'storage_condition',
        'created_by'
    ];

    public $timestamps = false;

    // Define relationships
    public function inquiryHistory()
    {
        return $this->belongsTo(InquiryHistory::class, 'inquiry_history_id');
    }

    public function brand()
    {
        return $this->belongsTo(Product::class, 'brand_id');
    }

    public function generic()
    {
        return $this->belongsTo(Generic::class, 'generic_id');
    }

    public function manufacturer()
    {
        return $this->belongsTo(Manufacturer::class, 'manufacturer_id');
    }
    
    public function createdBy()
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function productDocumentHistory()
    {
        return $this->hasMany(ProductDocumentHistory::class, 'quotation_history_id');
    }

    public function productPhotoHistory()
    {
        return $this->hasMany(ProductPhotoHistory::class, 'quotation_history_id');
    }

    public function supplierHistory()
    {
        return $this->hasMany(SupplierHistory::class, 'quotation_history_id');
    }

    public function productVariants()
    {
        return $this->belongsTo(ProductVariants::class, 'product_variant_id');
    }
}