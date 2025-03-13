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
        Schema::table('orders', function (Blueprint $table) {
            $table->dropUnique(['bill_to_client_code']);
            $table->dropUnique(['bill_to_email']);
            $table->dropUnique(['ship_to_client_code']);
            $table->dropUnique(['ship_to_email']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        //
    }
};
