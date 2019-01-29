<?php

Route::group(['middleware' => 'api', 'prefix' => 'api', 'namespace' => 'Modules\Contract\Http\Controllers'], function()
{
	Route::resource('contract', 'ContractController')->middleware('auth:api');
	
	Route::resource('category', 'CategoriesController');
	Route::post('category/disable-category/{category}', 'CategoriesController@disableCategory');
    Route::post('category/enable-category/{category}', 'CategoriesController@enableCategory');
	
	Route::resource('industry', 'IndustriesController');
	Route::post('industry/disable-industry/{industry}', 'IndustriesController@disableIndustry');
    Route::post('industry/enable-industry/{industry}', 'IndustriesController@enableIndustry');
    Route::get('industry-list', 'IndustriesController@getIndustryArray');//->middleware('auth:api');
	
	Route::resource('contract-type', 'ContractTypesController');
	Route::post('contract-type/disable/{type}', 'ContractTypesController@disableContractType');
    Route::post('contract-type/enable/{type}', 'ContractTypesController@enableContractType');
	
	Route::get('contract-part/global', 'ContractPartsController@globalParts');
	Route::resource('contract-part', 'ContractPartsController');	
	Route::post('part/disable-part/{part}', 'ContractPartsController@disablePart');
    Route::post('part/enable-part/{part}', 'ContractPartsController@enablePart');
});