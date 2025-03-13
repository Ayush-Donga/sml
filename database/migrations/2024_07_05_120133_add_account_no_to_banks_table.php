<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddAccountNoToBanksTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('banks', function (Blueprint $table) {
            $table->string('account_no', 16)->nullable()->unique()->after('account_name');
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
            $table->dropUnique(['account_no']);
            $table->dropColumn('account_no');
        });
    }
}
