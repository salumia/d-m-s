<?php

namespace Modules\Contract\Entities;

use Illuminate\Database\Eloquent\Model;

class Contract extends Model
{
    protected $fillable = [
		'industry_id',
		'category_id',
		'sender_id',
		'receiver_id',
		'receiver_email',
		'sender_flag',
		'receiver_flag',
		'status'
	];
}
