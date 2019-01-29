<?php

namespace Modules\Contract\Entities;

use Illuminate\Database\Eloquent\Model;
use Modules\Contract\Entities\Industry;

class ContractPart extends Model
{
    protected $fillable = [
		'title',
		'internal_title',
		'body',
		'special',
		'type',
		'industry_id',
		'status'
	];
	
	public function getIndustryData() {
        return $this->belongsTo(Industry::class,'industry_id');
    }
}
