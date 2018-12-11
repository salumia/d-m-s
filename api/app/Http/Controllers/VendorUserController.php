<?php

namespace App\Http\Controllers;
use App\VendorUser;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class VendorUserController extends Controller{
   
   /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index(){
        return VendorUser::get();
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return Response
     */
    public function create()
    {
        return 'create';
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @return Response
     */
    public function store(Request $request)
    {
        $data = $request->post();
		$data['password'] = Hash::make($data['password']);
        $user = VendorUser::create($data);

        return new Response([
            'message' => 'User created successfully',
            'user' => $user
        ]);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return Response
     */
    public function show($id)
    {
       return  VendorUser::find($id);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return Response
     */
    public function edit($id)
    {
        return 'edit';
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  int  $id
     * @return Response
     */
    public function update(VendorUser $user, Request $request)
    {
        // Load new data
        $data = $request->post();
        // Massage data
        unset($data['api_token_expires']);
        $data['name'] = $data['first_name'] . ' ' . $data['last_name'];

        // Update data
        $user->update($data);

        return new Response([
            'message' => 'User updated successfully',
            'user' => $user
        ]);
    }

	 /**
     * Disable any user in the system
     *
     * @param User $user
     * @return Response
     */
    public function disableUser(VendorUser $user) {
        // Disable user
        $user->api_token = '';
        $user->role = 'disabled';
        $user->save();

        return new Response([
            'message' => 'User Disabled',
            'user' => $user
        ]);
    }

    /**
     * Enables any user in the system
     *
     * @param User $user
     * @return Response
     */
    public function enableUser(VendorUser $user) {
        // Disable user
        $user->api_token = '';
        $user->role = 'vendor';
        $user->save();

        return new Response([
            'message' => 'User Enabled',
            'user' => $user
        ]);
    }
	
	public function changePassword(VendorUser $user, Request $request)
    {
        $data = $request->post();
		$user->password = Hash::make($data['new_password']);
		$user->save();
		return new Response([
			'message' => 'Password updated successfully',
			'user' => $user,
			'error' => false
		]);
    }
	
    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return Response
     */
    public function destroy($id)
    {
        //
    }

}    
   
