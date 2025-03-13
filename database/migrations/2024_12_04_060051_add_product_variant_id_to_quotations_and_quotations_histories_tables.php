<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddProductVariantIdToQuotationsAndQuotationsHistoriesTables extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('quotations', function (Blueprint $table) {
            $table->foreignId('product_variant_id')
                ->nullable()
                ->constrained('product_variants')
                ->after('manufacturer_id');
        });

        Schema::table('quotations_histories', function (Blueprint $table) {
            $table->foreignId('product_variant_id')
                ->nullable()
                ->constrained('product_variants')
                ->after('manufacturer_id');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('quotations', function (Blueprint $table) {
            $table->dropForeign(['product_variant_id']);
            $table->dropColumn('product_variant_id');
        });

        Schema::table('quotations_histories', function (Blueprint $table) {
            $table->dropForeign(['product_variant_id']);
            $table->dropColumn('product_variant_id');
        });
    }
}
