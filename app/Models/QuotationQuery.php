<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class QuotationQuery extends Model
{
    use HasFactory;

    // Table name
    protected $table = 'quotation_queries';

    // Fillable attributes
    protected $fillable = [
        'quotation_id',
        'comment',
        'created_by',
    ];

    protected function comment(): Attribute
    {
        return Attribute::make(
            set: function ($value) {
                return $value ? strtoupper($value) : null;
            }
        );
    }

    public function quotation()
    {
        return $this->belongsTo(Quotation::class);
    }
}
