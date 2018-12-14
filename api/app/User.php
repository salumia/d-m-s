<?php

namespace App;

use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Modules\User\Entities\EmployeeFiles as EmployeeFiles;
use Modules\User\Entities\Leave as Leave;
use Modules\Claim\Entities\Claim as Claim;

class User extends Authenticatable
{
    use Notifiable;
    protected $table = 'user_profiles';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'email', 'phone', 'gender', 'fax', 'address','city', 'zip', 'api_token', 'api_token_expires','password'
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'remember_token', 'encrypted_password', 'salt'
    ];

    public function generateToken()
    {
        $this->api_token = str_random(60);
        $this->api_token_expires = date('Y-m-d h:i:s', strtotime('+4 hours'));
        $this->save();

        return $this->api_token;
    }
	
	public function getFiles() {
        return $this->hasMany(EmployeeFiles::class,'user_id');
    }	
	
	public function getLeaves() {
        return $this->hasMany(Leave::class,'user_id');
    }
	
	public function getClaims() {
        return $this->hasMany(Claim::class,'user_id');
    }
}
