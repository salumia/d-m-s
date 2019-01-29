<?php

namespace Modules\Contract\Entities;

use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    protected $fillable = [
		'name',
		'status'
	];
}
