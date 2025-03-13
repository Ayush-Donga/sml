<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class ModifyIfscCodeUniqueNullableInBanksTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('banks', function (Blueprint $table) {
            // Ensure the column is nullable
            $table->string('ifsc_code')->nullable()->change();

            // Add unique constraint
            $table->unique('ifsc_code');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('banks', function (Blueprint $table) {
            // Remove unique constraint
            $table->dropUnique(['ifsc_code']);
        });
    }
}
