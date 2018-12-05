<?php

Route::group(['middleware' => 'api', 'prefix' => 'api', 'namespace' => 'Modules\Appraisal\Http\Controllers'], function()
{
	Route::resource('appraisal', 'AppraisalController')->middleware('auth:api');
	Route::resource('appraisal-points', 'AppraisalPointsController')->middleware('auth:api');
	Route::post('users-list', 'AppraisalController@getUsersArray')->middleware('auth:api');
	Route::post('appraisal/save-feedback', 'AppraisalController@saveFeedback')->middleware('auth:api');
	Route::post('appraisal/update-feedback', 'AppraisalController@updateFeedback')->middleware('auth:api');
	Route::post('appraisal/save-key-responsibilities', 'AppraisalController@saveKeyResponsibilities')->middleware('auth:api');
	Route::post('appraisal/update-key-responsibility', 'AppraisalController@updateKeyResponsibility')->middleware('auth:api');
	Route::post('appraisal/delete-responsibility', 'AppraisalController@deleteResponsibility')->middleware('auth:api');
	Route::post('appraisal/get-active-appraisal', 'AppraisalController@getActiveAppraisal')->middleware('auth:api');
	Route::post('appraisal/get-review-appraisals', 'AppraisalController@getReviewAppraisals')->middleware('auth:api');
	Route::post('appraisal/get-department-appraisals', 'AppraisalController@getDepartmentAppraisals')->middleware('auth:api');
});
