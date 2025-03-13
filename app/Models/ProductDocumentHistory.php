<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductDocumentHistory extends Model
{
    use HasFactory;

    // Table name
    protected $table = 'product_documents_histories';

    // Fillable attributes
    protected $fillable = [
        'quotation_history_id',
        'document',
        'created_by'
    ];

    // Define relationships
    public function quotationHistory()
    {
        return $this->belongsTo(QuotationHistory::class, 'quotation_history_id');
    }
    
    public function createdBy()
    {
        return $this->belongsTo(User::class, 'created_by');
    }
}