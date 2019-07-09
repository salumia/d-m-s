<?php

Route::group(['middleware' => 'api', 'prefix' => 'api', 'namespace' => 'Modules\Admin\Http\Controllers'], function()
{
	Route::resource('admin', 'AdminController');
});

