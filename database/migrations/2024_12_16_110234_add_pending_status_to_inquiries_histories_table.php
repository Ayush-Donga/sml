<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddPendingStatusToInquiriesHistoriesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        // Modify the `status` column to include 'pending' in its enum definition
        Schema::table('inquiries_histories', function (Blueprint $table) {
            $table->dropColumn('status');
        });

        Schema::table('inquiries_histories', function (Blueprint $table) {
            $table->enum('status', ['open', 'close', 'reopen', 'pending'])
                  ->default('open')
                  ->after('assigned_user_id');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        // Revert the `status` column to its original enum definition
        Schema::table('inquiries_histories', function (Blueprint $table) {
            $table->dropColumn('status');
        });

        Schema::table('inquiries_histories', function (Blueprint $table) {
            $table->enum('status', ['open', 'close', 'reopen'])
                  ->default('open')
                  ->after('assigned_user_id');
        });
    }
}
