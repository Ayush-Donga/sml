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
        Schema::table('orders', function (Blueprint $table) {
            $table->unsignedBigInteger('bill_to_customer_id')->nullable();
            $table->string('bill_to_client_code', 255)->unique()->nullable();
            $table->string('bill_to_company_name', 255)->nullable();
            $table->string('bill_to_email', 100)->unique()->nullable();
            $table->string('bill_to_phone_no', 15)->nullable();
            $table->string('bill_to_registration_no', 255)->nullable()->nullable();
            $table->text('bill_to_address')->nullable();
            $table->string('bill_to_zip_code', 10)->nullable();
            $table->unsignedBigInteger('ship_to_customer_id')->nullable();
            $table->string('ship_to_client_code', 255)->unique()->nullable();
            $table->string('ship_to_company_name', 255)->nullable();
            $table->string('ship_to_email', 100)->unique()->nullable();
            $table->string('ship_to_phone_no', 15)->nullable();
            $table->string('ship_to_registration_no', 255)->nullable();
            $table->text('ship_to_address')->nullable();
            $table->string('ship_to_zip_code', 10)->nullable();

            $table->foreign('bill_to_customer_id')->references('id')->on('customers')->onDelete('cascade');
            $table->foreign('ship_to_customer_id')->references('id')->on('customers')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('orders', function (Blueprint $table) {
            //
        });
    }
};
