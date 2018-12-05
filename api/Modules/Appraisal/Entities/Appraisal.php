<?php

namespace Modules\Appraisal\Entities;

use Illuminate\Database\Eloquent\Model;
use App\User as User;
use Modules\Appraisal\Entities\AppraisalFeedback;
use Modules\Appraisal\Entities\KeyResponsibility;

class Appraisal extends Model
{
    protected $fillable = [
		'from_date',
		'to_date',
		'user_id',
		'reviewer_id',
		'status',
		'stage',
		'staff_comments',
		'reviewer_comments',
		'department'
	];
	
	public function getUserData() {
        return $this->belongsTo(User::class,'user_id');
    }
	
	public function getReviewerData() {
        return $this->belongsTo(User::class,'reviewer_id');
    }
	
	public function getFeedBackData() {
        return $this->hasMany(AppraisalFeedback::class,'appraisal_id', 'id');
    }
	
	public function getKeyResponsibilityData() {
        return $this->hasMany(KeyResponsibility::class,'appraisal_id', 'id');
    }
}
