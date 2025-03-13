<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('order_products', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('order_id');
            $table->unsignedBigInteger('product_id');
            $table->unsignedBigInteger('product_variant_id');
            $table->integer('quantity');
            $table->enum('is_order_placed', ['yes', 'no', 'error'])->nullable();
            $table->text('note')->nullable();
            $table->date('expected_delivery_date')->nullable();
            $table->timestamps();

            $table->foreign('order_id')->references('id')->on('orders')->onDelete('cascade');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('order_products');
    }
};