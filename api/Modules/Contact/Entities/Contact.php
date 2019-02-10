<?php

namespace Modules\Contact\Entities;

use Illuminate\Database\Eloquent\Model;
use App\User;
use App\VendorUser;

class Contact extends Model
{
    protected $fillable = [
		'vendor_id',
		'user_id',
		'email',
		'type',
		'status'
	];
	
	public function getUserData() {
        return $this->belongsTo(User::class,'user_id');
    }
	
	public function getVendorData() {
        return $this->belongsTo(VendorUser::class,'user_id');
    }
}