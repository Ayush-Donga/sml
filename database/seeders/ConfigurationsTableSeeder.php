<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ConfigurationsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Check if AUTO_GENERATED_INVOICE_NO exists, if not insert it
        if (DB::table('configurations')->where('code', 'AUTO_GENERATED_INVOICE_NO')->count() == 0) {
            DB::table('configurations')->insert([
                'name' => 'SMPL',
                'value' => 0,
                'description' => 'Auto generated invoice number',
                'code' => 'AUTO_GENERATED_INVOICE_NO',
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }

        // Check if AUTO_GENERATED_PROFORMA_INVOICE_NO exists, if not insert it
        if (DB::table('configurations')->where('code', 'AUTO_GENERATED_PROFORMA_INVOICE_NO')->count() == 0) {
            DB::table('configurations')->insert([
                'name' => 'SMLPI',
                'value' => 0,
                'description' => 'Auto generated proforma invoice number',
                'code' => 'AUTO_GENERATED_PROFORMA_INVOICE_NO',
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }

        // Check if AUTO_GENERATED_QUOTE_NO exists, if not insert it
        if (DB::table('configurations')->where('code', 'AUTO_GENERATED_QUOTE_NO')->count() == 0) {
            DB::table('configurations')->insert([
                'name' => 'SMLQ',
                'value' => 0,
                'description' => 'Auto generated quote number',
                'code' => 'AUTO_GENERATED_QUOTE_NO',
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }

        // Check if ROLE_TYPE exists, if not insert it
        if (DB::table('configurations')->where('code', 'ROLE_TYPE')->count() == 0) {
            DB::table('configurations')->insert([
                'name' => 'Role Type',
                'value' => json_encode([
                    ["label" => "ADMIN", "value" => "ADMIN"],
                    ["label" => "BD", "value" => "BD"],
                    ["label" => "PURCHASE", "value" => "PURCHASE"],
                    ["label" => "WAREHOUSE", "value" => "WAREHOUSE"],
                    ["label" => "BILLING", "value" => "BILLING"],
                    ["label" => "WAREHOUSE PACKING", "value" => "WAREHOUSE_PACKING"],
                    ["label" => "LOGISTIC", "value" => "LOGISTIC"],
                ]),
                'description' => 'Role types',
                'code' => 'ROLE_TYPE',
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }
}
