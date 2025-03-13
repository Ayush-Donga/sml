<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Supplier extends Model
{
    use HasFactory;

    // The table associated with the model.
    protected $table = 'suppliers';

    // The attributes that are mass assignable.
    protected $fillable = [
        'quotation_id',
        'vender_id',
        'price_per_pack',
        'expiry_date',
        'lead_time',
        'created_by',
        'updated_by',
    ];

    // Define relationships
    public function quotation()
    {
        return $this->belongsTo(Quotation::class);
    }

    public function vendor()
    {
        return $this->belongsTo(Vendor::class);
    }
}
