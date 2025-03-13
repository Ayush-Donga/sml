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
        Schema::create('suppliers_histories', function (Blueprint $table) {
            $table->id();
            $table->foreignId('quotation_history_id')->nullable()->constrained('quotations_histories');
            $table->foreignId('vender_id')->nullable()->constrained('venders');
            $table->decimal('price_per_pack', 10, 2)->nullable();
            $table->string('expiry_date', 255)->nullable();
            $table->string('lead_time', 255)->nullable();
            $table->unsignedBigInteger('created_by')->nullable();
            $table->timestamps();
        });
    }
    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('suppliers_histories');
    }
};