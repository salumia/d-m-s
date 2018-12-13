<?php

Route::group(['middleware' => 'api', 'prefix' => 'api', 'namespace' => 'Modules\Vendor\Http\Controllers'], function()
{
	Route::resource('vendors', 'VendorUserController');//->middleware('auth:api');
	Route::post('vendor/change-password/{user}', 'VendorUserController@changePassword');//->middleware('auth:api');
	Route::post('vendor/disable-user/{user}', 'VendorUserController@disableUser');//->middleware('auth:api');
	Route::post('vendor/enable-user/{user}', 'VendorUserController@enableUser');//->middleware('auth:api')
});

