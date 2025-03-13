<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class UpdateZipCodeLengthInOrdersTable extends Migration
{
    public function up()
    {
        Schema::table('orders', function (Blueprint $table) {
            $table->string('bill_to_zip_code', 25)->nullable()->change();
            $table->string('ship_to_zip_code', 25)->nullable()->change();
        });
    }

    public function down()
    {
        Schema::table('orders', function (Blueprint $table) {
            $table->string('bill_to_zip_code', 10)->nullable()->change();
            $table->string('ship_to_zip_code', 10)->nullable()->change();
        });
    }
}
