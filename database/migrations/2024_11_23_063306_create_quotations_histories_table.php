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
        Schema::create('quotations_histories', function (Blueprint $table) {
            $table->id();
            $table->foreignId('inquiry_history_id')->nullable()->constrained('inquiries_histories');
            $table->foreignId('brand_id')->nullable()->constrained('products');
            $table->foreignId('generic_id')->nullable()->constrained('generics');
            $table->foreignId('manufacturer_id')->nullable()->constrained('manufacturers');
            $table->string('gst', 100)->nullable();
            $table->string('storage_condition', 255)->nullable();
            $table->unsignedBigInteger('created_by')->nullable();
            $table->timestamps();
        });
    }
    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('quotations_histories');
    }
};