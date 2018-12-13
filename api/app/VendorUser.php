<?php

namespace App;

use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Modules\User\Entities\EmployeeFiles as EmployeeFiles;
use Modules\User\Entities\Leave as Leave;
use Modules\Claim\Entities\Claim as Claim;

class VendorUser extends Authenticatable
{
    use Notifiable;
    protected $table = 'vendor_profiles';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'shop_name', 'email', 'phone', 'gender', 'fax', 'address','city', 'zip', 'api_token', 'api_token_expires','password'
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
	
}
