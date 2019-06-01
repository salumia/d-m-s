<?php

Route::group(['middleware' => 'api', 'prefix' => 'api', 'namespace' => 'Modules\Contract\Http\Controllers'], function()
{
	Route::get('contract/get-tos', 'ContractController@getTOS');
	Route::post('contract/tos', 'ContractController@saveTOS');
	Route::post('contract/saveparts/{contract}/{user}', 'ContractController@saveContractParts');
	Route::post('contract/updateparts/{contract}/{user}', 'ContractController@updateContractParts');
	Route::get('contract/token/{token}', 'ContractController@contractByToken');
	Route::resource('contract', 'ContractController');//->middleware('auth:api');
	Route::get('contract/user/{id}/{role}', 'ContractController@userContracts');
	Route::get('contract/part/{id}', 'ContractController@contractPartData');
	Route::post('contract/update-status/{id}', 'ContractController@updateContractStatus');
	Route::post('contract/open/{id}', 'ContractController@openContract'); 
	Route::get('contract/log/{id}', 'ContractController@getContractLog'); 
	Route::get('contract/payment/{id}', 'ContractController@contractPayment'); 	
	Route::get('contract/{id}/save_pdf', 'ContractController@showPdf');
	Route::get('contract/{id}/print', 'ContractController@printContract');
	Route::get('contract/{id}/email/{sender}', 'ContractController@sendContractAttachmentEmail');
		
	Route::resource('category', 'CategoriesController');
	Route::post('category/disable-category/{category}', 'CategoriesController@disableCategory');
    Route::post('category/enable-category/{category}', 'CategoriesController@enableCategory');
	Route::get('category-list', 'CategoriesController@getCategoryArray');//->middleware('auth:api');
Route::get('category-list/{user}', 'CategoriesController@getIndustryCategoryArray');//->middleware('auth:api');
	
	Route::resource('industry', 'IndustriesController');
	Route::post('industry/disable-industry/{industry}', 'IndustriesController@disableIndustry');
    Route::post('industry/enable-industry/{industry}', 'IndustriesController@enableIndustry');
    Route::get('industry-list', 'IndustriesController@getIndustryArray');//->middleware('auth:api');    
		
	Route::resource('contract-type', 'ContractTypesController');
	Route::post('contract-type/disable/{type}', 'ContractTypesController@disableContractType');
    Route::post('contract-type/enable/{type}', 'ContractTypesController@enableContractType');
	Route::get('contract-type-list', 'ContractTypesController@getTypesArray');
	
	Route::get('part/industry/{id}/{userId}/{role}', 'PartsController@industryParts');
	Route::get('part/user/{id}', 'PartsController@userParts');
	Route::get('part/global', 'PartsController@globalParts');
	Route::get('part/available/{user}/{set}', 'PartsController@availableParts');
	Route::resource('part', 'PartsController');	
	Route::post('part/disable-part/{part}', 'PartsController@disablePart');
    Route::post('part/enable-part/{part}', 'PartsController@enablePart');       
});