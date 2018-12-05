<?php

namespace Modules\Claim\Entities;

use Illuminate\Database\Eloquent\Model;
use App\User as User;

class Claim extends Model
{
    protected $fillable = [
		'from_date',
		'to_date',
		'claim_type',
		'amount',
		'detail',
		'status',
		'user_id'
	];
	
	public function getUserData() {
        return $this->belongsTo(User::class,'user_id');
    }
}
