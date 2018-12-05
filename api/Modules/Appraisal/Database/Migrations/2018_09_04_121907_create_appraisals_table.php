<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateAppraisalsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('appraisals', function (Blueprint $table) {
            $table->increments('id');			
			$table->date('from_date')->nullable();
            $table->date('to_date')->nullable();			
			$table->string('status',20);			
			$table->integer('user_id');
			$table->integer('reviewer_id')->nullable();
			$table->string('staff_comments',500);
			$table->string('reviewer_comments',500);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('appraisals');
    }
}
