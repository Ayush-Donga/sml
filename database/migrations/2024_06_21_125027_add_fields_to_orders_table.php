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
            $table->string('currency', 10)->nullable()->after('is_shipment_close');
            $table->string('pi_number')->nullable()->after('currency');
            $table->decimal('shipping', 10, 2)->nullable()->after('pi_number');
            $table->decimal('soft_boxes', 10, 2)->nullable()->after('shipping');
            $table->decimal('data_logger', 10, 2)->nullable()->after('soft_boxes');
            $table->decimal('clearance', 10, 2)->nullable()->after('data_logger');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('orders', function (Blueprint $table) {
            //
        });
    }
};
