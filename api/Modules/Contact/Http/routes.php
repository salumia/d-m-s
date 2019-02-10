<?php

Route::group(['middleware' => 'api', 'prefix' => 'api', 'namespace' => 'Modules\Contact\Http\Controllers'], function()
{
	Route::resource('contact', 'ContactController');//->middleware('auth:api');
	Route::get('contact-list/{id}', 'ContactController@contactList');
	Route::get('contact/user/{id}', 'ContactController@userContacts');
	Route::post('contact/disable-contact/{contact}', 'ContactController@disableContact');
    Route::post('contact/enable-contact/{contact}', 'ContactController@enableContact');
});