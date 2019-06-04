<?php

namespace App;

use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;

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
        'name', 'email', 'phone', 'gender', 'fax', 'address','city', 'zip', 'api_token', 'api_token_expires','password','username','contact_added_by'
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
