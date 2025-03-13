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
        Schema::create('user_device_token', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id'); 
            $table->string('player_id'); 
            $table->unsignedBigInteger('created_by')->nullable();
            $table->timestamps();
            // Define the unique constraint
            $table->unique(['user_id', 'player_id']);
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('user_device_token');
    }
};
