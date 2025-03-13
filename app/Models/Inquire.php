<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Inquire extends Model
{
    use HasFactory;

    // Specify the table associated with the model
    protected $table = 'inquires';

    // Define the fillable attributes
    protected $fillable = [
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
        'creation_date',
        'created_by',
        'updated_by',
    ];

    // Define relationships (if applicable)
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

    public function quotations()
    {
        return $this->hasMany(Quotation::class, 'inquire_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'assigned_user_id');
    }
}
