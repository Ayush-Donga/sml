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
        Schema::create('order_package_products', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('order_package_id');
            $table->unsignedBigInteger('order_product_id');
            $table->integer('quantity');
            $table->timestamps();

            $table->foreign('order_package_id')->references('id')->on('order_packages')->onDelete('cascade');
            $table->foreign('order_product_id')->references('id')->on('order_products')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('order_package_products');
    }
};
