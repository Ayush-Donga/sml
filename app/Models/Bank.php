<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Bank extends Model
{
    use HasFactory;

    protected $table = 'banks';

    protected $fillable = [
        'name',
        'account_name',
        'account_no',
        'swift_code_no',
        'ifsc_code',
        'branch',
    ];

      // Mutators to set the fields to uppercase if not null
      public function setNameAttribute($value)
      {
          $this->attributes['name'] = $value !== null ? strtoupper($value) : null;
      }
  
      public function setAccountNameAttribute($value)
      {
          $this->attributes['account_name'] = $value !== null ? strtoupper($value) : null;
      }

      public function setAccountNoAttribute($value)
      {
          $this->attributes['account_no'] = $value !== null ? strtoupper($value) : null;
      }
  
      public function setSwiftCodeNoAttribute($value)
      {
          $this->attributes['swift_code_no'] = $value !== null ? strtoupper($value) : null;
      }
  
      public function setIfscCodeAttribute($value)
      {
          $this->attributes['ifsc_code'] = $value !== null ? strtoupper($value) : null;
      }
  
      public function setBranchAttribute($value)
      {
          $this->attributes['branch'] = $value !== null ? strtoupper($value) : null;
      }
}
