<?php

namespace Modules\Contract\Entities;

use Illuminate\Database\Eloquent\Model;

class Industry extends Model
{
    protected $fillable = [
		'name',
		'status'
	];
}
