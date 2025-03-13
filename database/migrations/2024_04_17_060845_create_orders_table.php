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
        Schema::create('orders', function (Blueprint $table) {
            $table->id();
            $table->string('client_code');
            $table->string('country');
            $table->date('order_date')->nullable();
            $table->string('serve_date')->nullable();
            $table->string('bill_to');
            $table->string('ship_to');
            $table->string('invoice_no')->nullable();
            $table->date('invoice_date')->nullable();
            $table->enum('is_shipping_documents_done', ['yes', 'no'])->nullable();
            $table->enum('is_tax_invoice_eway_billP_done', ['yes', 'no'])->nullable();
            $table->enum('is_arrange_pick_up', ['yes', 'no'])->nullable();
            $table->enum('is_shipment_dispatched', ['yes', 'no'])->nullable();
            $table->enum('is_awb_handover', ['yes', 'no'])->nullable();
            $table->enum('is_shipment_close', ['yes', 'no'])->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('orders');
    }
};
