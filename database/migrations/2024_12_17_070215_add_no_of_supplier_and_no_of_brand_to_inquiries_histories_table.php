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
        Schema::table('inquiries_histories', function (Blueprint $table) {
            $table->integer('no_of_supplier')->nullable()->after('status');
            $table->integer('no_of_brand')->nullable()->after('no_of_supplier');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('inquiries_histories', function (Blueprint $table) {
            $table->dropColumn(['no_of_supplier', 'no_of_brand']);
        });
    }
};
