<?php

namespace Modules\Contract\Entities;

use Illuminate\Database\Eloquent\Model;
use Modules\Contract\Entities\Industry;
use Modules\Contract\Entities\ContractLog;

class ContractPart extends Model
{
    protected $fillable = [
		'title',
		'body',
		'user_id',
		'contract_id',
		'is_deleted',
		'is_edited',
		'modified',
		'newly_added',
	];
	
	public function getLogData() {
        $instance = $this->hasMany(ContractLog::class,'part_id');
		$instance->orderBy('id','desc')->take(1);
		return $instance;
    }
	
}
