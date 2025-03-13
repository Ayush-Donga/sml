<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductPhoto extends Model
{
    use HasFactory;

    protected $table = 'product_photos';

    protected $fillable = [
        'quotation_id',
        'photo',
        'created_by',
        'updated_by',
    ];

    public function quotation()
    {
        return $this->belongsTo(Quotation::class);
    }
}
