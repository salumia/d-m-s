<?php

Route::group(['middleware' => 'api', 'prefix' => 'api', 'namespace' => 'Modules\User\Http\Controllers'], function()
{
    Route::resource('users', 'UserController');
    Route::post('users/change-password/{user}', 'UserController@changePassword');
    Route::post('users/logout-user/{user}', 'UserController@logoutUser')->middleware('auth:api');
    Route::post('users/disable-user/{user}', 'UserController@disableUser');
    Route::post('users/enable-user/{user}', 'UserController@enableUser');
	Route::post('users/checkUsername', 'UserController@checkIfUsernameExist');
	Route::post('users/checkEmail', 'UserController@checkIfEmailExist');
});
