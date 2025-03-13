<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddPendingStatusToInqueryStatusHistoryTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        // Drop and recreate the `status` column to include 'pending'
        Schema::table('inquery_status_history', function (Blueprint $table) {
            $table->dropColumn('status');
        });

        Schema::table('inquery_status_history', function (Blueprint $table) {
            $table->enum('status', ['open', 'close', 'reopen', 'pending'])
                  ->nullable()
                  ->default(null)
                  ->after('inquiry_id');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        // Rollback to the original column definition
        Schema::table('inquery_status_history', function (Blueprint $table) {
            $table->dropColumn('status');
        });

        Schema::table('inquery_status_history', function (Blueprint $table) {
            $table->enum('status', ['open', 'close', 'reopen'])
                  ->nullable()
                  ->default(null)
                  ->after('inquiry_id');
        });
    }
}
