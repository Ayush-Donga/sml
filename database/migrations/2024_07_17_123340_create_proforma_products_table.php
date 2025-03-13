<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateProformaProductsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('proforma_products', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('proforma_id')->nullable();
            $table->unsignedBigInteger('product_id')->nullable();
            $table->unsignedBigInteger('product_variant_id')->nullable();
            $table->integer('quantity')->nullable();
            $table->decimal('price_per_set', 10, 2)->nullable();
            $table->decimal('total', 10, 2)->nullable();
            $table->timestamps();

            $table->foreign('proforma_id')->references('id')->on('proformas')->onDelete('cascade');
            $table->foreign('product_id')->references('id')->on('products')->onDelete('cascade');
            $table->foreign('product_variant_id')->references('id')->on('product_variants')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('proforma_products');
    }
}
