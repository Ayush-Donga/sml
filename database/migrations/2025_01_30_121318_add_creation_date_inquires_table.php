<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up()
    {
        Schema::table('inquires', function (Blueprint $table) {
            $table->timestamp('creation_date')->nullable()->after('is_vendor_name'); // Adjust position if needed
        });
    }

    public function down()
    {
        Schema::table('inquires', function (Blueprint $table) {
            $table->dropColumn('creation_date');
        });
    }
};

