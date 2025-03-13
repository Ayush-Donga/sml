<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateProformasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('proformas', function (Blueprint $table) {
            $table->id(); 
            $table->unsignedBigInteger('order_id')->nullable();
            $table->string('country', 255)->nullable();
            $table->date('order_date')->nullable(); 
            $table->string('serve_date', 255)->nullable();
            $table->string('invoice_no', 255)->unique()->nullable();
            $table->date('invoice_date')->nullable();
            $table->string('currency', 10)->nullable();
            $table->decimal('shipping', 10, 2)->nullable();
            $table->decimal('soft_boxes', 10, 2)->nullable();
            $table->decimal('data_logger', 10, 2)->nullable();
            $table->decimal('clearance', 10, 2)->nullable();
            $table->string('payment_terms', 255)->nullable();
            $table->string('delivery_by', 255)->nullable();
            $table->string('delivery_time', 255)->nullable();
            $table->string('delivery_terms', 255)->nullable();
            $table->enum('status', ['pending', 'completed'])->nullable()->default('pending');
            $table->unsignedBigInteger('bill_to_customer_id')->nullable();
            $table->string('bill_to_client_code', 255)->nullable();
            $table->string('bill_to_company_name', 255)->nullable();
            $table->string('bill_to_email', 100)->nullable();
            $table->string('bill_to_phone_no', 15)->nullable();
            $table->string('bill_to_registration_no', 255)->nullable();
            $table->text('bill_to_address')->nullable();
            $table->string('bill_to_zip_code', 10)->nullable(); 
            $table->unsignedBigInteger('ship_to_customer_id')->nullable(); 
            $table->string('ship_to_client_code', 255)->nullable();
            $table->string('ship_to_company_name', 255)->nullable(); 
            $table->string('ship_to_email', 100)->nullable(); 
            $table->string('ship_to_phone_no', 15)->nullable(); 
            $table->string('ship_to_registration_no', 255)->nullable(); 
            $table->text('ship_to_address')->nullable(); 
            $table->string('ship_to_zip_code', 10)->nullable(); 
            $table->bigInteger('created_by')->nullable(); 
            $table->timestamps(); 
            $table->bigInteger('updated_by')->nullable(); 

            $table->foreign('order_id')->references('id')->on('orders')->onDelete('cascade');
            $table->foreign('bill_to_customer_id')->references('id')->on('customers')->onDelete('cascade');
            $table->foreign('ship_to_customer_id')->references('id')->on('customers')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('proformas');
    }
}

