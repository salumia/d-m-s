<?php

namespace Modules\Appraisal\Entities;

use Illuminate\Database\Eloquent\Model;

class AppraisalFeedback extends Model
{
    protected $fillable = [
		'appraisal_id',
		'point_id',
		'feedback',
		'rating'
	];
}
