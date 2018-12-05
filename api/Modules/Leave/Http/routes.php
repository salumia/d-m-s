<?php

Route::group(['middleware' => 'api', 'prefix' => 'api', 'namespace' => 'Modules\Leave\Http\Controllers'], function()
{
	Route::resource('leave', 'LeaveController')->middleware('auth:api');
	Route::post('leave/update-status/{leave}', 'LeaveController@updateStatus')->middleware('auth:api');
});
