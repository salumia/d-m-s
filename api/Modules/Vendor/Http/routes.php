<?php

Route::group(['middleware' => 'api', 'prefix' => 'api', 'namespace' => 'Modules\Vendor\Http\Controllers'], function()
{
	 Route::resource('vendors', 'VendorUserController');//->middleware('auth:api');
 //    Route::post('users/change-password/{user}', 'UserController@changePassword')->middleware('auth:api');
 //    Route::post('users/logout-user/{user}', 'UserController@logoutUser')->middleware('auth:api');
 //    Route::post('users/disable-user/{user}', 'UserController@disableUser')->middleware('auth:api');
 //    Route::post('users/enable-user/{user}', 'UserController@enableUser')->middleware('auth:api');
	// Route::post('users/checkEmail', 'UserController@checkIfEmailExist');//->middleware('auth:api');
	// Route::post('users/checkDepartmentHOD', 'UserController@checkIfDepartmentHODExist')->middleware('auth:api');
	
	// Route::post('user/upload', 'UserController@uploadDocuments');
	// Route::post('user/updatepagedocs', 'UserController@updatedocuments')->middleware('auth:api');
	// Route::post('user/deletefile', 'UserController@deleteDocument')->middleware('auth:api');
});

