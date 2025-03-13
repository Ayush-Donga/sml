<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Notification extends Model
{
    use HasFactory;

    // The table associated with the model.
    protected $table = 'notifications';

    protected $fillable = [
        'user_id',
        'heading',
        'content',
        'url',
        'is_read',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
