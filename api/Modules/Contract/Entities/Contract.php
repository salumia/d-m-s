<?php

namespace Modules\Contract\Entities;

use Illuminate\Database\Eloquent\Model;
use Modules\Contract\Entities\Category;
use Modules\Contract\Entities\ContractPart;
use Modules\Contract\Entities\ContractLog;

use App\User;
use App\VendorUser;

class Contract extends Model
{
    protected $fillable = [
		'type',
		'name',
		'description',
		'industry_id',
		'category_id',
		'sender_id',
		'receiver_id',
		'receiver_role',
		'email',
		'sender_flag',
		'receiver_flag',
		'signature',
		'status'
	];
	
	public function getCategoryData() {
        return $this->belongsTo(Category::class,'category_id');
    }
	
	public function getContractParts() {
        return $this->hasMany(ContractPart::class,'contract_id');
    }
	
	public function getReceiverUserData() {
        return $this->belongsTo(User::class,'receiver_id');
    }
	
	public function getReceiverVendorData() {
        return $this->belongsTo(VendorUser::class,'receiver_id');
    }
	
	public function getSenderData() {
        return $this->belongsTo(VendorUser::class,'sender_id');
    }
	
	public function getContractLog() {
        return $this->hasMany(ContractLog::class,'contract_id');
    }
	
}
