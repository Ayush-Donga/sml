<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('inquires', function (Blueprint $table) {
            $table->boolean('is_vendor_name')->default(false)->nullable()->after('is_pack_size');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('inquires', function (Blueprint $table) {
            $table->dropColumn('is_vendor_name');
        });
    }
};
