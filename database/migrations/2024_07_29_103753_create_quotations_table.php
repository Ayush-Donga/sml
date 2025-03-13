<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateQuotationsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('quotations', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('inquire_id')->nullable();
            $table->unsignedBigInteger('brand_id')->nullable();
            $table->unsignedBigInteger('generic_id')->nullable();
            $table->unsignedBigInteger('manufacturer_id')->nullable();
            $table->string('gst', 100)->nullable();
            $table->string('storage_condition', 255)->nullable();
            $table->bigInteger('created_by')->nullable();
            $table->timestamps();
            $table->bigInteger('updated_by')->nullable();

            $table->foreign('inquire_id')->references('id')->on('inquires')->onDelete('cascade');
            $table->foreign('brand_id')->references('id')->on('products')->onDelete('cascade');
            $table->foreign('generic_id')->references('id')->on('generics')->onDelete('cascade');
            $table->foreign('manufacturer_id')->references('id')->on('manufacturers')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('quotations');
    }
}