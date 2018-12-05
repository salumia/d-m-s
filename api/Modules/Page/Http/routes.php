<?php

Route::group(['middleware' => 'api', 'prefix' => 'api', 'namespace' => 'Modules\Page\Http\Controllers'], function()
{
	Route::post('upload', 'PageController@uploadDocuments');
	Route::post('updatepagedocs', 'PageController@updatedocuments')->middleware('auth:api');
	Route::post('deletefile', 'PageController@deleteDocument')->middleware('auth:api');
	Route::post('deletecoverimage', 'PageController@deleteCover')->middleware('auth:api');
    Route::resource('pages', 'PageController');//->middleware('auth:api');
});
