<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SupplierHistory extends Model
{
    use HasFactory;

    // Table name
    protected $table = 'suppliers_histories';

    // Fillable attributes
    protected $fillable = [
        'quotation_history_id',
        'vender_id',
        'price_per_pack',
        'expiry_date',
        'lead_time',
        'created_by'
    ];

    // Define relationships
    public function quotationHistory()
    {
        return $this->belongsTo(QuotationHistory::class, 'quotation_history_id');
    }

    public function vender()
    {
        return $this->belongsTo(Vender::class, 'vender_id');
    }
    
    public function createdBy()
    {
        return $this->belongsTo(User::class, 'created_by');
    }
}