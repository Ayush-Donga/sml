<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddIsPackSizeToInquiresAndInquiriesHistoriesTables extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('inquires', function (Blueprint $table) {
            $table->boolean('is_pack_size')
                ->default(false)
                ->nullable()
                ->after('is_product_doc');
        });

        Schema::table('inquiries_histories', function (Blueprint $table) {
            $table->boolean('is_pack_size')
                ->default(false)
                ->nullable()
                ->after('is_product_doc');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('inquires', function (Blueprint $table) {
            $table->dropColumn('is_pack_size');
        });

        Schema::table('inquiries_histories', function (Blueprint $table) {
            $table->dropColumn('is_pack_size');
        });
    }
}
