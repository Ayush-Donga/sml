<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        // Rename column 'is_gest' to 'is_gst' for MariaDB compatibility
        DB::statement('ALTER TABLE inquiries_histories CHANGE is_gest is_gst TINYINT(1) DEFAULT 0');
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        // Revert back to original column name
        DB::statement('ALTER TABLE inquiries_histories CHANGE is_gst is_gest TINYINT(1) DEFAULT 0');
    }
};
