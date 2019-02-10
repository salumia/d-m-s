<?php

namespace Modules\Contract\Entities;

use Illuminate\Database\Eloquent\Model;

class ContractType extends Model
{
    protected $fillable = [
		'name',
		'status'
	];
}
