<?php

namespace Modules\Set\Entities;

use Illuminate\Database\Eloquent\Model;
use Modules\Contract\Entities\Part;
use Modules\Contract\Entities\Industry;

class SetPart extends Model
{
	protected $fillable = [
		'part_id',
		'set_id'
	];
	
	public function getPartData() {
        return $this->belongsTo(Part::class,'part_id');
    }
	
	public function getIndustryData() {
        return $this->belongsTo(Industry::class,'industry_id');
    }
}
