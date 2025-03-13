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
        Schema::create('customers', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('parent_id')->nullable();
            $table->string('client_code', 255)->unique();
            $table->string('company_name', 255);
            $table->string('email', 100)->unique();
            $table->string('phone_no', 15);
            $table->string('registration_no', 255)->nullable();
            $table->text('address');
            $table->string('zip_code', 10);
         
            $table->foreign('parent_id')->references('id')->on('customers')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('customer');
    }
};
