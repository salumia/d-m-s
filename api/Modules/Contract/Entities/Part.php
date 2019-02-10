<?php

namespace Modules\Contract\Entities;

use Illuminate\Database\Eloquent\Model;
use Modules\Contract\Entities\Industry;

class Part extends Model
{
    protected $fillable = [
		'title',
		'internal_title',
		'body',
		'special',
		'type',
		'user_id',
		'industry_id',
		'status'
	];
	
	public function getIndustryData() {
        return $this->belongsTo(Industry::class,'industry_id');
    }
}
