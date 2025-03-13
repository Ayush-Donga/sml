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
            $table->string('payment_terms', 255)->nullable()->after('ship_to_zip_code');
            $table->string('delivery_by', 255)->nullable()->after('payment_terms');
            $table->string('delivery_time', 255)->nullable()->after('delivery_by');
            $table->string('delivery_terms', 255)->nullable()->after('delivery_time');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('orders', function (Blueprint $table) {
            $table->dropColumn('payment_terms');
            $table->dropColumn('delivery_by');
            $table->dropColumn('delivery_time');
            $table->dropColumn('delivery_terms');
        });
    }
};
