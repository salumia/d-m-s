<?php

namespace Modules\Contract\Entities;

use Illuminate\Database\Eloquent\Model;
use Modules\Contract\Entities\Industry;

class Category extends Model
{
    protected $fillable = [
		'name',
		'industry_id',
		'status'
	];
	
	public function getIndustryData() {
        return $this->belongsTo(Industry::class,'industry_id');
    }
}
