<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Customers extends Model
{
    use HasFactory;

    protected $table = 'customers';
    protected $guarded = [];

    public function shipTo()
    {
        return $this->hasOne(Customers::class, 'parent_id');
    }


    protected function companyName(): Attribute
    {
        return Attribute::make(
            set: function ($value) {
                return $value ? strtoupper($value) : null;
            }
        );
    }

    protected function email(): Attribute
    {
        return Attribute::make(
            set: function ($value) {
                return $value ? strtoupper($value) : null;
            }
        );
    }

    protected function registrationNo(): Attribute
    {
        return Attribute::make(
            set: function ($value) {
                return $value ? strtoupper($value) : null;
            }
        );
    }

    protected function address(): Attribute
    {
        return Attribute::make(
            set: function ($value) {
                return $value ? strtoupper($value) : null;
            }
        );
    }

    protected function zipCode(): Attribute
    {
        return Attribute::make(
            set: function ($value) {
                return $value ? strtoupper($value) : null;
            }
        );
    }
}
