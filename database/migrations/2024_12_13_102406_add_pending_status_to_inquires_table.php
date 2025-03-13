<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddPendingStatusToInquiresTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('inquires', function (Blueprint $table) {
            // Drop the existing enum column
            $table->dropColumn('status');
        });

        Schema::table('inquires', function (Blueprint $table) {
            // Recreate the enum column with the new value
            $table->enum('status', ['open', 'close', 'reopen', 'pending'])
                  ->default('open')
                  ->nullable()
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
        Schema::table('inquires', function (Blueprint $table) {
            // Drop the modified column
            $table->dropColumn('status');
        });

        Schema::table('inquires', function (Blueprint $table) {
            // Recreate the original enum column
            $table->enum('status', ['open', 'close', 'reopen'])
                  ->default('open')
                  ->nullable()
                  ->after('assigned_user_id');
        });
    }
}
