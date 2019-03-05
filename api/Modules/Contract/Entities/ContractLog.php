<?php

namespace Modules\Contract\Entities;

use Illuminate\Database\Eloquent\Model;

class ContractLog extends Model
{
    protected $fillable = [
		'title',
		'body',
		'new_title',
		'new_body',
		'part_id',
		'contract_id',
		'user',
		'iteration',
		'type',
	];
	
}
