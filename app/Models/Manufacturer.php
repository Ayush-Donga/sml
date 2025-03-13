<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Manufacturer extends Model
{
    use HasFactory;

    protected $table = 'manufacturers';

    // Define the attributes that are mass assignable
    protected $fillable = ['name'];

    // Mutators to set the fields to uppercase if not null
    public function setNameAttribute($value)
    {
        $this->attributes['name'] = $value !== null ? strtoupper($value) : null;
    }
}
