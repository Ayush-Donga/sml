<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class InquireStatusHistory extends Model
{
    use HasFactory;

    protected $table = 'inquery_status_history';
    
    protected $fillable = [
        'id',
        'inquiry_id',
        'status',
        'remarks',
        'is_manually',
        'created_by',
        'updated_by',
    ];
}