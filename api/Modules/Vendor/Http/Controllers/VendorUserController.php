<?php

namespace Modules\Vendor\Http\Controllers;
use App\VendorUser;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Modules\Contact\Entities\Contact;
use Modules\Contract\Entities\Contract;
use Illuminate\Support\Facades\Mail;

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
	
	public function sendWelcomeMail($vendor, $subject= 'Welcome to Clerk MyBackpocket',$template = 'vendor_welcome') {
		$from_name = 'No Reply';
		$from_email = 'no_reply@mybackpocket.io';
		$data = array(
			"name" => $vendor->shop_name
		);
		Mail::send($template, $data, function($message) use ($vendor, $subject, $from_name, $from_email) {
			$message->to($vendor->email, $vendor->shop_name)
					->subject($subject);
			$message->from($from_email,$from_name);
		});
		return true;
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
		
		/********** Send Welcome Mail ***************/
		$this->sendWelcomeMail($user);		
		/************** END ***********/
		
		if(Contact::whereEmail($data['email'])->count() > 0 ){
			Contact::whereEmail($data['email'])->update(array('user_id' => $user->id, 'type' => 'vendor'));
		}
		
		if(Contract::whereEmail($data['email'])->count() > 0 ){
			Contract::whereEmail($data['email'])->update(array('receiver_id' => $user->id, 'receiver_role' => 'vendor'));
		}
		
        return new Response([
            'message' => 'Vendor created successfully',
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
    public function update($user, Request $request)
    {
        // Load new data
        $data = $request->post();
        // Massage data
        unset($data['api_token_expires']);
        // Update data
		$user = VendorUser::find($user);
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
    public function destroy($user)
    {
		$user = VendorUser::find($user);
		// Delete the user
		try {				
			$user->delete();
		}
		catch(\Exception $e) {
			$response = new Response([
				'message' => $e->getMessage(),
				'user' => $user
			]);
			$response->setStatusCode(Response::HTTP_INTERNAL_SERVER_ERROR);
			return $response;
		}

		return new Response([
			'message' => 'Vendor deleted successfully',
			'user' => $user
		]);
    }

}    
   
