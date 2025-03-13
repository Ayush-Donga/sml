<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('products', function (Blueprint $table) {
            $table->string('heading', 100)->nullable()->after('name');
            $table->string('generic_name', 255)->nullable()->after('heading');
            $table->string('manufactured_by', 255)->nullable()->after('generic_name');
            $table->string('hsn_code', 25)->nullable()->after('manufactured_by');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('products', function (Blueprint $table) {
            //
        });
    }
};
