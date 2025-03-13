<?php

namespace App\Helpers;

use Illuminate\Support\Facades\File;

class ImageHelper
{
    public static function convertToBase64($path)
    {
        if (!File::exists($path)) {
            throw new \Exception("File does not exist at path {$path}");
        }

        $image = File::get($path);
        $type = pathinfo($path, PATHINFO_EXTENSION);
        $base64 = 'data:image/' . $type . ';base64,' . base64_encode($image);
        return $base64;
    }
}
