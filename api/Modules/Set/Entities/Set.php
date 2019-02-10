<?php

namespace Modules\Set\Entities;

use Illuminate\Database\Eloquent\Model;
use Modules\Set\Entities\SetPart;

class Set extends Model
{
    protected $fillable = [
		'title',
		'user_id',
		'status'
	];
	
	public function getParts() {
        return $this->hasMany(SetPart::class,'set_id');
    }
}
