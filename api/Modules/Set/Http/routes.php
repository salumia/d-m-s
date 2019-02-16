<?php

Route::group(['middleware' => 'api', 'prefix' => 'api', 'namespace' => 'Modules\Set\Http\Controllers'], function()
{
	Route::resource('terms-set', 'SetController');
	Route::get('terms-set/user/{id}', 'SetController@getUserSets');
	Route::get('terms-set-array/user/{id}', 'SetController@getUserSetsArray');
	Route::get('terms-set/getTerms/{id}', 'SetController@getSetTerms');
	Route::post('terms-set/terms/{id}', 'SetController@saveTerms');
	Route::post('terms-set/disable/{id}', 'SetController@disableSet');
    Route::post('terms-set/enable/{id}', 'SetController@enableSet');
});