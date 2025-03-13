<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductDocument extends Model
{
    use HasFactory;

    protected $table = 'product_documents';

    protected $fillable = [
        'quotation_id',
        'document',
        'created_by',
        'updated_by',
    ];

    public function quotation()
    {
        return $this->belongsTo(Quotation::class);
    }
}
