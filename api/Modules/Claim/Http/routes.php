<?php

Route::group(['middleware' => 'api', 'prefix' => 'api', 'namespace' => 'Modules\Claim\Http\Controllers'], function()
{
	Route::resource('claim', 'ClaimController')->middleware('auth:api');
	Route::post('claim/update-status/{claim}', 'ClaimController@updateStatus')->middleware('auth:api');
});
