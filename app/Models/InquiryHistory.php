<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class InquiryHistory extends Model
{
    use HasFactory;

    // Table name
    protected $table = 'inquiries_histories';

    // Fillable attributes
    protected $fillable = [
        'inquiry_id',
        'type',
        'brand_id',
        'generic_id',
        'quantity',
        'quote_number',
        'assigned_user_id',
        'status',
        'no_of_supplier',
        'no_of_brand',
        'is_generic_name',
        'is_brand_name',
        'is_manufacturer_name',
        'is_price_per_pack',
        'is_gst',
        'is_expiry',
        'is_storage_condition',
        'is_lead_time',
        'is_product_photo',
        'is_product_doc',
        'is_pack_size',
        'is_vendor_name',
        'created_by',
        'created_at',
    ];

    public $timestamps = false;

    // Cast attributes to specific types
    protected $casts = [
        'is_generic_name' => 'boolean',
        'is_brand_name' => 'boolean',
        'is_manufacturer_name' => 'boolean',
        'is_price_per_pack' => 'boolean',
        'is_gst' => 'boolean',
        'is_expiry' => 'boolean',
        'is_storage_condition' => 'boolean',
        'is_lead_time' => 'boolean',
        'is_product_photo' => 'boolean',
        'is_product_doc' => 'boolean',
    ];

    // Define relationships
    public function inquiry()
    {
        return $this->belongsTo(Inquire::class, 'inquiry_id');
    }

    public function brand()
    {
        return $this->belongsTo(Products::class, 'brand_id');
    }

    public function generic()
    {
        return $this->belongsTo(Generic::class, 'generic_id');
    }

    public function assignedUser()
    {
        return $this->belongsTo(User::class, 'assigned_user_id');
    }
    
    public function createdBy()
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function quotationHistory()
    {
        return $this->hasMany(QuotationHistory::class, 'inquiry_history_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'assigned_user_id');
    }
}