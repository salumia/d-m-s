<?php

namespace Modules\Contract\Entities;

use Illuminate\Database\Eloquent\Model;

class ContractLog extends Model
{
    protected $fillable = [
		'title',
		'body',
		'part_id',
		'contract_id'
	];
	
}
