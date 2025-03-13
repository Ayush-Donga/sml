<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('inquery_status_history', function (Blueprint $table) {
            $table->id();
            $table->foreignId('inquiry_id')->nullable()->constrained('inquires');
            $table->enum('status', ['open', 'close', 'reopen'])->nullable()->default(null);
            $table->text('remarks')->nullable();
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
        Schema::dropIfExists('inquery_status_history');
    }
};