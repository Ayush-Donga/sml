<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateProductPhotosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('product_photos', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('quotation_id')->nullable();
            $table->string('photo')->nullable();
            $table->unsignedBigInteger('created_by')->nullable();
            $table->timestamp('created_at')->useCurrent();
            $table->unsignedBigInteger('updated_by')->nullable();
            $table->timestamp('updated_at')->useCurrent()->useCurrentOnUpdate();

            $table->foreign('quotation_id')->references('id')->on('quotations')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('product_photos');
    }
}
