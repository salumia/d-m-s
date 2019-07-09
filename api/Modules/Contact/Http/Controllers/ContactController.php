<?php
namespace Modules\Contact\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
use Carbon\Carbon;

use Modules\Contact\Entities\Contact;
use App\User as User;
use App\VendorUser as VendorUser;

class ContactController extends Controller
{
	private $user;
	private $query;
    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index()
    {
		return new Response(Contact::all());
    }
	
	public function userContacts($user) {
		$this->user = $user;
		$userContacts = Contact::where('vendor_id',$this->user)->get();
		foreach($userContacts as $item) {			
			if($item->user_id != NULL){
				if($item->type == "vendor"){
					$item->getVendorData;
					$item->get_user_data = $item->getVendorData;
				} else {
					$item->getUserData;
				}
				unset($item->getVendorData);
			}
		}
		return new Response($userContacts);
	}

    /**
     * Store a newly created resource in storage.
     * @param  Request $request
     * @return Response
     */
    public function store(Request $request)
    {
		$data = $request->post();
		if(isset($data['contact'])){
			$data = $data["contact"];
		} else {
			$data = $data["data"];
		}
		if(User::whereEmail($data['email'])->count() > 0 ){
			$user = User::whereEmail($data['email'])->first();
			$data['user_id'] = $user->id;			
			$contact = Contact::create($data);
		} elseif(VendorUser::whereEmail($data['email'])->count() > 0 ){
			$vendor = VendorUser::whereEmail($data['email'])->first();
			$data['user_id'] = $vendor->id;
			$data['type'] = 'vendor';
			$contact = Contact::create($data);
		} else {
			$contact = Contact::create($data);
		}
        return new Response([
            'message' => 'Contact created successfully',
            'contacts' => $contact
        ]);
    }

    /**
     * Show the specified resource.
     * @return Response
     */
    public function show(Contact $contact)
    {
        return new Response($contact);
    }

    /**
     * Update the specified resource in storage.
     * @param  Request $request
     * @return Response
     */
    public function update(Contact $contact, Request $request)
    {		
        // Load new data
        $data = $request->post();
		
		if(User::whereEmail($data['email'])->count() > 0 ){
			$user = User::whereEmail($data['email'])->first();
			$data['user_id'] = $user->id;	
			$data['type'] = 'user';
		} elseif(VendorUser::whereEmail($data['email'])->count() > 0 ){
			$vendor = VendorUser::whereEmail($data['email'])->first();
			$data['user_id'] = $vendor->id;
			$data['type'] = 'vendor';
		}
        // Update data
        $contact->update($data);

        return new Response([
            'message' => 'Contact updated successfully',
			'contacts' => $contact
        ]);
    }

    /**
     * Remove the specified resource from storage.
     * @return Response
     */
    public function destroy(Contact $contact)
    {
        // Delete the Page
        try {
			$contact->delete();
        }
        catch(\Exception $e) {
            $response = new Response([
                'message' => $e->getMessage(),
                'contacts' => $contact
            ]);
            $response->setStatusCode(Response::HTTP_INTERNAL_SERVER_ERROR);
            return $response;
        }

        return new Response([
            'message' => 'Contact deleted successfully',
            'contacts' => $contact
        ]);
    }
	
	public function disableContact(Contact $contact) {
        // Disable Contact
        $contact->status = 0;
        $contact->save();

        return new Response([
            'message' => 'Contact Disabled',
            'Contact' => $contact
        ]);
    }
	    
    public function enableContact(Contact $contact) {
        // Disable Contact
        $contact->status = 1;
        $contact->save();

        return new Response([
            'message' => 'Contact Enabled',
            'Contact' => $contact
        ]);
    } 
		
	public function contactList($user) {
		return new Response(Contact::selectRaw('CONCAT(name, " ( ", email, " )") as label, email as value')->where(['vendor_id'=>$user,'status'=>1])->get());
    }
	
	public function searchContactList($id,$query) {
		$this->user = $id;
		$this->query = $query;
		$contacts = Contact::selectRaw('CONCAT(name, " ( ", company, " )") as label,email as value')->where([['vendor_id', '=', $this->user],['status', '=', 1]])
							->where(function ($query) {
								$query->orWhere('name',"like",'%'.$this->query.'%')
									  ->orWhere('company',"like",'%'.$this->query.'%');
							})->get();
		return new Response($contacts);
		
	}
	
	public function suggestionList($id,$query) {
		$this->user = $id;
		$this->query = $query;
		$users = User::select('email as label', 'email as value')
				->whereNotIn('email',function($query){
					   $query->select('email')->from('contacts')->where('vendor_id',$this->user);
					})
				->where([['email', "like",'%'.$this->query.'%']])
				->get();
		
		$vendors = VendorUser::select('email as label', 'email as value')
					->whereNotIn('email',function($query){
					   $query->select('email')->from('contacts')->where('vendor_id',$this->user);
					})
					->where([['id', '!=', $this->user],['email', "like",'%'.$this->query.'%']])
					->get();
		
		$users = collect($users);
		$vendors = collect($vendors);
		return new Response($users->merge($vendors));
    }
	
}
