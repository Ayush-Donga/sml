<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Vender extends Model
{
    use HasFactory;

    protected $table = 'venders';

    protected $fillable = [
        'name',
        'email',
        'phone',
        'location',
    ];

     // Mutators to set the fields to uppercase if not null
     public function setNameAttribute($value)
     {
         $this->attributes['name'] = $value !== null ? strtoupper($value) : null;
     }
 
     public function setEmailAttribute($value)
     {
         $this->attributes['email'] = $value !== null ? strtoupper($value) : null;
     }
 
     public function setLocationAttribute($value)
     {
         $this->attributes['location'] = $value !== null ? strtoupper($value) : null;
     }
}
