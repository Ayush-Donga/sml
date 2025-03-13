<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSuppliersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('suppliers', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('quotation_id')->nullable();
            $table->unsignedBigInteger('vender_id')->nullable();
            $table->decimal('price_per_pack', 10, 2)->nullable();
            $table->string('expiry_date', 255)->nullable();
            $table->string('lead_time', 255)->nullable();
            $table->unsignedBigInteger('created_by')->nullable();
            $table->timestamp('created_at')->useCurrent();
            $table->unsignedBigInteger('updated_by')->nullable();
            $table->timestamp('updated_at')->useCurrent()->useCurrentOnUpdate();

            $table->foreign('quotation_id')->references('id')->on('quotations')->onDelete('cascade');
            $table->foreign('vender_id')->references('id')->on('venders')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('suppliers');
    }
}
