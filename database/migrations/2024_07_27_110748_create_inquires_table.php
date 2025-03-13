<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('inquires', function (Blueprint $table) {
            $table->id();
            $table->enum('type', ['brand', 'generic'])->nullable();
            $table->foreignId('brand_id')->nullable()->constrained('products');
            $table->foreignId('generic_id')->nullable()->constrained('generics');
            $table->integer('quantity')->nullable();
            $table->string('quote_number', 255)->nullable();
            $table->foreignId('assigned_user_id')->nullable()->constrained('users');
            $table->enum('status', ['open', 'close', 'reopen'])->default('open')->nullable();
            $table->boolean('is_generic_name')->default(false)->nullable();
            $table->boolean('is_brand_name')->default(false)->nullable();
            $table->boolean('is_manufacturer_name')->default(false)->nullable();
            $table->boolean('is_price_per_pack')->default(false)->nullable();
            $table->boolean('is_gest')->default(false)->nullable();
            $table->boolean('is_expiry')->default(false)->nullable();
            $table->boolean('is_storage_condition')->default(false)->nullable();
            $table->boolean('is_lead_time')->default(false)->nullable();
            $table->boolean('is_product_photo')->default(false)->nullable();
            $table->boolean('is_product_doc')->default(false)->nullable();
            $table->unsignedBigInteger('created_by')->nullable();
            $table->timestamps();
            $table->unsignedBigInteger('updated_by')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('inquires');
    }
};

