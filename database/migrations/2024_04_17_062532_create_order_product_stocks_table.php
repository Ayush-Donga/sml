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
        Schema::create('order_product_stocks', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('order_product_id');
            $table->enum('is_stock_received', ['yes', 'no'])->nullable();
            $table->string('batch_no')->nullable();
            $table->string('mfg_date')->nullable();
            $table->string('exp_date')->nullable();
            $table->integer('quantity')->nullable();
            $table->enum('is_purchase_entry_done', ['yes', 'pending'])->nullable();
            $table->timestamps();

            $table->foreign('order_product_id')->references('id')->on('order_products')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('order_product_stocks');
    }
};
