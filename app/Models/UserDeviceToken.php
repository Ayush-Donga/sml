<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserDeviceToken extends Model
{
    use HasFactory;

    protected $table = 'user_device_token';

    protected $fillable = [
        'user_id',
        'player_id',
        'created_by',
    ];
}
