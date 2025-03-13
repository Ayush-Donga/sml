<?php

namespace App\Helpers;

use NumberToWords\NumberToWords;

class NumberToWordsHelper
{
    public static function convert($number)
    {
        $numberToWords = new NumberToWords();
        $numberTransformer = $numberToWords->getNumberTransformer('en');

        // Check if the number contains a decimal point
        if (strpos($number, '.') !== false) {
            list($whole, $fraction) = explode('.', $number);
            $wordsWhole = $numberTransformer->toWords($whole);
            $wordsFraction = $numberTransformer->toWords($fraction);

            // Combine whole number and fraction parts with "and"
            $words = "{$wordsWhole} AND {$wordsFraction}";
        } else {
            $words = $numberTransformer->toWords($number);
        }

        // Replace hyphens with spaces and convert to uppercase
        $wordsWithoutHyphens = str_replace('-', ' ', $words);
        return strtoupper($wordsWithoutHyphens);
    }
}
