<?php

Route::group(['middleware' => 'api', 'prefix' => 'api', 'namespace' => 'Modules\Contact\Http\Controllers'], function()
{
	Route::resource('contact', 'ContactController');
	Route::get('contact-list/{id}', 'ContactController@contactList');
	Route::get('contact/suggestion/{id}/{query}', 'ContactController@suggestionList');
	Route::get('contact/search/{id}/{query}', 'ContactController@searchContactList');
	Route::get('contact/user/{id}', 'ContactController@userContacts');
	Route::post('contact/disable-contact/{contact}', 'ContactController@disableContact');
    Route::post('contact/enable-contact/{contact}', 'ContactController@enableContact');
});