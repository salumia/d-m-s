<?php

Route::group(['middleware' => 'api', 'prefix' => 'api', 'namespace' => 'Modules\Vendor\Http\Controllers'], function()
{
	Route::resource('vendors', 'VendorUserController');
	Route::post('vendor/change-password/{user}', 'VendorUserController@changePassword');
	Route::post('vendor/disable-user/{user}', 'VendorUserController@disableUser');
	Route::post('vendor/enable-user/{user}', 'VendorUserController@enableUser');
});

