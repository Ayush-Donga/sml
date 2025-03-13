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
        Schema::table('order_packages', function (Blueprint $table) {
            $table->string('box_no')->nullable()->change();
            $table->string('dimension')->nullable()->change();
            $table->decimal('gross_weight', 10, 2)->nullable()->change();
            $table->decimal('net_weight', 10, 2)->nullable()->change();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {

        
        Schema::table('order_packages', function (Blueprint $table) {
            $table->string('box_no')->nullable(false)->change();
            $table->string('dimension')->nullable(false)->change();
            $table->decimal('gross_weight', 10, 2)->nullable(false)->change();
            $table->decimal('net_weight', 10, 2)->nullable(false)->change();
        });
    }
};
