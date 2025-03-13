<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddIsManuallyToInquiryStatusHistoryTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('inquery_status_history', function (Blueprint $table) {
            $table->boolean('is_manually')->default(false)->after('remarks'); 
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('inquery_status_history', function (Blueprint $table) {
            $table->dropColumn('is_manually');
        });
    }
}
