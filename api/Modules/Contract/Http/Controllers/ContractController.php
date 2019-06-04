<?php
namespace Modules\Contract\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
use Carbon\Carbon;

use Modules\Contract\Entities\Contract;
use Modules\Contract\Entities\ContractPart;
use Modules\Contract\Entities\ContractLog;
use Modules\Contract\Entities\ContractSetting;
use Modules\Notification\Entities\Notification;
use App\User;
use App\VendorUser;
use PDF;
use Illuminate\Support\Facades\Mail;

class ContractController extends Controller
{
	private $user;
    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index(){
		//return new Response(Contract::all());
		$contracts = Contract::all();
		foreach($contracts as $item) {
			$item->getCategoryData;
			$item->getContractParts;
			$item->getSenderData;
			if($item->receiver_role == "user"){
				$item->get_receiver_data = $item->getReceiverUserData;
				unset($item->getReceiverUserData);
			} else {
				$item->get_receiver_data = $item->getReceiverVendorData;
				unset($item->getReceiverVendorData);
			}
		}
		return new Response($contracts);
    }

    /**
     * Store a newly created resource in storage.
     * @param  Request $request
     * @return Response
     */
    public function store(Request $request){
		$data = $request->post();
		if(!empty($data['email'])){
			$data['status'] = 1;
			$receiverUser = User::where(["email"=>$data['email']])->first();
			$receiverVendor = VendorUser::where(["email"=>$data['email']])->first();
			if(!empty($receiverUser)){
				$data['receiver_id'] = $receiverUser->id;
				$data['receiver_role'] = 'user';
			} elseif(!empty($receiverVendor)){
				$data['receiver_id'] = $receiverVendor->id;
				$data['receiver_role'] = 'vendor';
			}	
			$data['access_token'] = $this->generateRandomString(16);
			$data['token_expiration'] = date('Y-m-d H:i:s', time() + 86400);
			$contract = Contract::create($data);
			$this->sendAppraisalMail($contract);
		} else {
			$contract = Contract::create($data);
		}
		if(!empty($contract->receiver_id)){
			$notification = [];
			$notification['user_id'] = $contract->receiver_id;
			$notification['role'] = $contract->receiver_role;
			$notification['ref_id'] = $contract->id;
			Notification::create($notification);	
		}		
        return new Response([
            'message' => 'Contract created successfully',
            'contracts' => $contract
        ]);
    }

    /**
     * Show the specified resource.
     * @return Response
     */
    public function show(Contract $contract){
		$contract->getCategoryData;
		$contract->getContractParts;
		$contract->getSenderData;
		if($contract->receiver_role == "user"){
			$contract->get_receiver_data = $contract->getReceiverUserData;
			unset($contract->getReceiverUserData);
		} else {
			$contract->get_receiver_data = $contract->getReceiverVendorData;
			unset($contract->getReceiverVendorData);
		}
        return new Response($contract);
    }    
	
	/**
     * Show the specified resource.
     * @return Response
     */
    public function contractByToken($token){
		$contract = Contract::where("access_token","=",$token)->first();
		$contract->getCategoryData;
		$contract->getContractParts;
		$contract->getSenderData;
		if($contract->receiver_role == "user"){
			$contract->get_receiver_data = $contract->getReceiverUserData;
			unset($contract->getReceiverUserData);
		} else {
			$contract->get_receiver_data = $contract->getReceiverVendorData;
			unset($contract->getReceiverVendorData);
		}
        return new Response($contract);
    }

    /**
     * Update the specified resource in storage.
     * @param  Request $request
     * @return Response
     */
    public function update(Contract $contract, Request $request){
        // Load new data
        $data = $request->post();
		
		if(!empty($data['email'])){
			$data['status'] = 1;
			$receiverUser = User::where(["email"=>$data['email']])->first();
			$receiverVendor = VendorUser::where(["email"=>$data['email']])->first();
			if(!empty($receiverUser)){
				$data['receiver_id'] = $receiverUser->id;
			} elseif(!empty($receiverVendor)){
				$data['receiver_id'] = $receiverVendor->id;
			}		
			$data['access_token'] = $this->generateRandomString(16);			
			$data['token_expiration'] = date('Y-m-d H:i:s', time() + 86400);
			$contract->update($data);
			$this->sendAppraisalMail($contract);			
		} else {
			$contract->update($data);
		}        
		if(!empty($contract->receiver_id)){
			$notification = [];
			$notification['user_id'] = $contract->receiver_id;
			$notification['role'] = $contract->receiver_role;
			$notification['ref_id'] = $contract->id;			
		}	
		
        // Update data        

        return new Response([
            'message' => 'Contract updated successfully',
			'contracts' => $contract
        ]);
    }

    /**
     * Remove the specified resource from storage.
     * @return Response
     */
    public function destroy(Contract $contract){
        // Delete the Page
        try {
			ContractPart::where(["contract_id"=>$contract->id])->delete();
			$contract->delete();
        }
        catch(\Exception $e) {
            $response = new Response([
                'message' => $e->getMessage(),
                'contracts' => $contract
            ]);
            $response->setStatusCode(Response::HTTP_INTERNAL_SERVER_ERROR);
            return $response;
        }

        return new Response([
            'message' => 'Contract deleted successfully',
            'contracts' => $contract
        ]);
    }
	
	public function saveContractParts($contract,$user, Request $request){
		ContractPart::where(["contract_id"=>$contract])->delete();
		
         // Load new data
        $data = $request->post();
		$parts = [];
		foreach($data as $part){
			$temp = [];
			$temp['title'] = $part['title'];
			$temp['body'] = $part['body'];
			$temp['contract_id'] = $contract;
			$temp['user_id'] = $user;
			$temp['created_at'] = $temp['updated_at'] = date("Y-m-d H:i:s");
			$parts[] = $temp;
		}
		ContractPart::insert($parts);
        return new Response([
            'message' => 'Contract Created Successfully',
        ]);
    }
	
	public function getContractArray(Request $request){
       return new Response(Contract::select('id as value', 'name as label')->get());
    }
		
	public function contractPartData($contractPart){
		$contractPartData = ContractPart::find($contractPart);
		$contractPartData->getLogData;
		$contractPartData->get_log_data = $contractPartData->getLogData[0];
		unset($contractPartData->getLogData);
		return new Response([
            'message' => 'Contract part data',
            'data' => $contractPartData,
        ]);
	}
	
	public function userContracts($user,$role){
		$this->user = $user;
		if($role == "user"){
			$userContracts = Contract::where('receiver_id',$user)->get();
		} else {
			$userContracts = Contract::where(function($q) {
										$q->where(['receiver_id'=>$this->user,'receiver_role'=>'vendor'])
										  ->orWhere('sender_id', $this->user);
									})->get();
		}		
		foreach($userContracts as $item) {
			$item->getCategoryData;
			$item->getContractParts;
			$item->getSenderData;
			if($item->receiver_role == "user"){
				$item->get_receiver_data = $item->getReceiverUserData;
				unset($item->getReceiverUserData);
			} else {
				$item->get_receiver_data = $item->getReceiverVendorData;
				unset($item->getReceiverVendorData);
			}
		}
		return new Response($userContracts);
    }
	
	public function sendAppraisalMail($contract){
		$sender = VendorUser::find($contract->sender_id);
		if($contract->receiver_role == 'user'){
			$receiver = User::find($contract->receiver_id);
		} else {
			$receiver = VendorUser::find($contract->receiver_id);
		}
		$data = array(
			"receiver_name" => $receiver->name,
			"sender_name" => $sender->shop_name,
			"contract_url" => config('constants.url').'#/access-contract/'.$contract->access_token,
			"contract_pin" => $contract->pin
		);
		$this->sendNotification($sender->shop_name, $sender->email, $contract->email, $receiver->name, "New Contract  Clerk", $data, 'mail.contract_created');
	}
	
	public function openContract($contract, Request $request){
		$contract = Contract::find($contract);
		$contract->status = 1;
		$contract->receiver_flag = 1;
        $contract->save();	
		
		$notification = [];
		$notification['type'] = 'open';
		$notification['user_id'] = $contract->sender_id;
		$notification['role'] = 'vendor';
		$notification['ref_id'] = $contract->id;
		Notification::create($notification);
		
		$notification = [];
		$notification['type'] = 'open';
		$notification['user_id'] = $contract->receiver_id;
		$notification['role'] = $contract->receiver_role;
		$notification['ref_id'] = $contract->id;
		Notification::create($notification);
		
		/******* Save Log *********/
		$iteration = ContractLog::where(["contract_id"=>$contract->id])->max('iteration');
		$logData = [];
		$logData['contract_id'] = $contract->id;		
		$logData['user'] = 'admin';		
		$logData['type'] = 'open';			
		$logData['iteration'] = $iteration + 1;			
		ContractLog::create($logData);
			
		$sender = VendorUser::find($contract->sender_id);
		if($contract->receiver_role == "user"){
			$receiver = User::find($contract->receiver_id);
		} else {
			$receiver = VendorUser::find($contract->receiver_id);
		}
		
		/*** Notify Sender ***/
		
		$data = array(
			"notify" => $sender->name,
			"creator" => $sender->shop_name,
			"receiver" => $receiver->name,
			"contract_url" => config('constants.url').'#/contract/preview/'.$contract->id,
		);
		
		$this->sendNotification("Admin", "admin@clerk.io", $sender->email, $sender->name, "Contract Opened Again", $data, 'mail.contract_reopen');
		
		/*** Notify Receiver ***/
		$data1 = array(
			"notify" => $receiver->name,
			"creator" => $sender->shop_name,
			"receiver" => $receiver->name,
			"contract_url" => config('constants.url').'#/contract/preview/'.$contract->id,
		);
		
		$this->sendNotification("Admin", "admin@clerk.io", $receiver->email, $receiver->name, "Contract Opened Again", $data1, 'mail.contract_reopen');

		
		return new Response([
            'message' => 'Contract status updated',
            'contracts' => $contract
        ]);
	}
	
	public function updateContractStatus($contract, Request $request){
		$data = $request->post();
		
		$contract = Contract::find($contract);
		$contract->status = $data['status'];
		
		if($data['isSender']){
			$notification_receiver =  'receiver';
		} else {
			$notification_receiver =  'sender';
		}	
		
		if($data['status'] == 4){
			$contract->sender_flag = 2;
			$contract->receiver_flag = 2;
		}
		
		if(isset($data['signature']) && !empty($data['signature'])){
			if(isset($data['isSender']) && $data['isSender']){
				$contract->sender_signature = $data['signature'];
			} else {
				$contract->receiver_signature = $data['signature'];
			}			
		}		
        $contract->save();	
		
		$logData = [];
		if(!empty($contract->id)){
			$notification = [];
			$logData['contract_id'] = $contract->id;
			
			if($contract->status == 2 || $contract->status == 4){
				$notification['type'] = 'accept';
				$logData['type'] = 'accept';
			} else {				
				$notification['type'] = 'reject';
				$logData['type'] = 'reject';
			}
			
			if($notification_receiver == 'receiver'){
				$notification['user_id'] = $contract->receiver_id;
				$notification['role'] = $contract->receiver_role;
								
				$logData['user'] = 'sender';
			} else {
				$notification['user_id'] = $contract->sender_id;
				$notification['role'] = 'vendor';
								
				$logData['user'] = 'receiver';
			}
			
			$notification['ref_id'] = $contract->id;
			Notification::create($notification);
			
			$this->sendContractUpdateEmail($contract, $notification_receiver);
			
			/******* Save Log *********/
			$iteration = ContractLog::where(["contract_id"=>$contract->id])->max('iteration');			
			$logData['iteration'] = $iteration + 1;			
			ContractLog::create($logData);
		}

        return new Response([
            'message' => 'Contract status updated',
            'contracts' => $contract
        ]);
	}
	
	public function updateContractParts($contract,$user, Request $request){
		$data = $request->post();
		$role = 'receiver';
		$notification_receiver = 'receiver';
		
		/******* Delete Contract Old Logs *********/
		//ContractLog::where(["contract_id"=>$contract])->delete();
		
		/******* Update Contract Table*********/
		$contract = Contract::find($contract); 
		if($data['sender']){
			$role = 'sender';			
			$contract->sender_flag = 1; 
			$contract->receiver_flag = 2;
			$contract->save();
			
			$notification = [];
			$notification['type'] = 'review';
			$notification['user_id'] = $contract->receiver_id;
			$notification['role'] = $contract->receiver_role;
			$notification['ref_id'] = $contract->id;
			Notification::create($notification);
			
		} else {
			$contract->receiver_flag = 1;
			$contract->sender_flag = 2;
			$contract->save();
			
			$notification_receiver = 'sender';
			
			$notification = [];
			$notification['type'] = 'review';
			$notification['user_id'] = $contract->sender_id;
			$notification['role'] = 'vendor';
			$notification['ref_id'] = $contract->id;
			Notification::create($notification);
			
		}
		
		/******* Update Contract Parts Table*********/
		foreach($data['contract_parts'] as $part){
			if(isset($part['id'])){
				$contractPart = ContractPart::find($part['id']);
				$contractPart->title = $part['title'];
				$contractPart->body = $part['body'];
				$contractPart->newly_added = 0;
				if(isset($part['tmp_deleted'])){
					$contractPart->is_deleted = $part['tmp_deleted'];				
				} else {
					$contractPart->is_deleted = 0;
				}
				
				if(isset($part['tmp_edited'])){
					$contractPart->is_edited = $part['tmp_edited'];
				} elseif(isset($part['tmp_deleted']) && ($part['is_edited'] == 1 )){
					$contractPart->is_deleted = 1;
				}else{
					$contractPart->is_edited = 0;
				}
				
				if(isset($part['tmp_modified'])){
					$contractPart->modified = $part['tmp_modified'];
				} elseif(isset($part['tmp_deleted']) && ($part['modified'] == 1 ) && ($part['is_edited'] == 1 )){
					$contractPart->modified = 0;
				}else {
					$contractPart->modified = 0;
				}	
				
				$contractPart->save();
			} else {
				$part['user_id'] = $user;
				$part['contract_id'] = $contract->id;
				$contractPart = ContractPart::create($part);
				$newlyPartArray = [];				
				$newlyPartArray['title'] = $contractPart->title;
				$newlyPartArray['body'] = $contractPart->body;
				$newlyPartArray['contract_id'] = $contractPart->contract_id;
				$newlyPartArray['part_id'] = $contractPart->id;
				$newlyPartArray['type'] = 'added';
				$data['edited_parts'][] = $newlyPartArray;
			}
		}
		/******* Save latest Log *********/
		$iteration = ContractLog::where(["contract_id"=>$contract->id])->max('iteration');
		if( sizeof($data['edited_parts']) > 0 ){			
			// save log
			foreach($data['edited_parts'] as $edited){
				$edited['iteration'] = $iteration + 1;
				$edited['user'] = $role;
				//$edited['type'] = 'edited';
				ContractLog::create($edited);
			}
		}
		
		$this->sendContractUpdateEmail($contract, $notification_receiver);
		
        return new Response([
            'message' => 'Contract Updated Successfully',
        ]);
    }
	
	public function getContractLog($contract, Request $request){
		$contract = Contract::find($contract);
		$contract->getContractLog;
		$newArray = [];
		foreach($contract->getContractLog as $log){
			$newArray[$log->iteration]["user"] = $log->user;
			$newArray[$log->iteration]["changes"][] = $log->type;
			$newArray[$log->iteration]["created_at"] = $log->created_at->format('H:i:s d M, Y');
		}
		$response = [];
		foreach($newArray as $iteration){
			if(count($iteration["changes"]) > 1){
				$iteration["action"] = 'review';
			} elseif(in_array($iteration["changes"][0],array("accept","reject","open"))){
				$iteration["action"] = $iteration["changes"][0];
			} else{
				$iteration["action"] = 'review';
			}
			$response[] = $iteration;
		}
		unset($contract->getContractLog);
		$contract->get_contract_log = $response;
		return new Response([
            'message' => 'Contract logs',
            'contract' => $contract
        ]);
	}
	
	public function contractPayment($contract, Request $request){
		
		
		$merchant_id = '300206404'; //INSERT MERCHANT ID (must be a 9 digit string)
        $api_key = '04446E9287964AE2981Bd2997e380BA6'; //INSERT API ACCESS PASSCODE
        $api_version = 'v1'; //default
        $platform = 'api'; //default

		//Create Beanstream Gateway
		$beanstream = new \Beanstream\Gateway($merchant_id, $api_key, $platform, $api_version);
		
		
		$result = $beanstream->reporting()->getTransaction(10000032);
		echo "<pre>";
		//display result
		is_null($result)?:print_r($result);
		die;
		
		//Example Card Payment Data
		$payment_data = array(
				'order_number' => 'a1b2c3',
				'amount' => 1.00,
				'payment_method' => 'card',
				'card' => array(
					'name' => 'Mr. Card Testerson',
					'number' => '4030000010001234',
					'expiry_month' => '07',
					'expiry_year' => '22',
					'cvd' => '123'
				)
		);
		$complete = TRUE; //set to FALSE for PA
		//Try to submit a Card Payment
		try {
			$result = $beanstream->payments()->makeCardPayment($payment_data, $complete);
			die(print_r($result));
		} catch (\Beanstream\Exception $e) {
		   die(print_r($e->getMessage()));
		}
	}
	
	public function sendNotification($from_name, $from_email, $to_email, $to_name, $subject= 'Default Subject',$data = [],$template = 'mail.contract_created') {
		Mail::send($template, $data, function($message) use ($to_name, $to_email, $subject, $from_name, $from_email) {
			$message->to($to_email, $to_name)
					->subject($subject);
			$message->from($from_email,$from_name);
		});
		return true;
	}
	
	private function generateRandomString($length = 10) {
		$characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
		$charactersLength = strlen($characters);
		$randomString = '';
		for ($i = 0; $i < $length; $i++) {
			$randomString .= $characters[rand(0, $charactersLength - 1)];
		}
		return $randomString;
	}
	
	public function sendContractUpdateEmail($contract, $notification_receiver){
		
		$sender = VendorUser::find($contract->sender_id);
		if($contract->receiver_role == 'user'){
			$receiver = User::find($contract->receiver_id);
			$receiver->email = $contract->email;
		} else {
			$receiver = VendorUser::find($contract->receiver_id);
			$receiver->email = $contract->email;
		}
		
		if($notification_receiver == "sender"){
			$notify_user = $sender;
			$other = $receiver;
		} else {			
			$notify_user = $receiver;
			$other = $sender;
		}	
		
		if($contract->status == 3){
			$data = array(
				'receiver_name'=>$notify_user->name,
				'other_name'=>$other->name,
				'status'=>'rejected',
				'contract_url'=>config('constants.url').'#/contract/preview'.$contract->id,
			);
			$this->sendNotification($other->name, $other->email, $notify_user->email, $notify_user->name, "Contract Rejected", $data, 'mail.contract_status_update');
		} else if($contract->status == 2){
			
			$data = array(
				'receiver_name'=>$notify_user->name,
				'other_name'=>$other->name,
				'status'=>'accepted',
				'contract_url'=>config('constants.url').'#/contract/preview'.$contract->id,
			);
			$this->sendNotification($other->name, $other->email, $notify_user->email, $notify_user->name, "Contract Accepted", $data, 'mail.contract_status_update');
		} else if($contract->status == 4){
			
			$data = array(
				'notify'=>$sender->shop_name,
				'creator'=>$sender->shop_name,
				'receiver'=>$receiver->name,
				'contract_url'=>config('constants.url').'#/contract/preview'.$contract->id,
			);
			$this->sendNotification("Admin", "admin@clerk.io", $sender->email, $sender->name, "Contract Finalized", $data, 'mail.contract_finalized');
			
			/*** Notify Receiver ***/			
			
			$data = array(
				'notify'=>$receiver->name,
				'creator'=>$sender->shop_name,
				'receiver'=>$receiver->name,
				'contract_url'=>config('constants.url').'#/contract/preview'.$contract->id,
			);
			
			$this->sendNotification("Admin", "admin@clerk.io", $receiver->email, $receiver->name, "Contract Finalized", $data, 'mail.contract_finalized');			
			
		} else {			
			
			$data = array(
				'receiver_name'=>$notify_user->name,
				'other_name'=>$other->name,
				'contract_url'=>config('constants.url').'#/contract/preview'.$contract->id,
			);
			
			$this->sendNotification($other->name, $other->email, $notify_user->email, $notify_user->name, "Review Contract", $data, 'mail.contract_reviewed');
		}
		
	}
	
	private function createTemplate($type){
		
		switch($type){	
			case 'attachment':
				$message = "";
				$message .= "<div style='font-family:Verdana,Tahoma,Helvetica,Arial,sans-serif'>";
				$message .= "Hi %RECEIVER_NAME%<br><br>";
				$message .= "Please find the enclosed contract attachment <br><br>";
				$message .= "Best Regards,<br>";
				$message .= "Clerk Team<br>";
				$message .= "</div>";
			break;
			
			case 'reviewed':
				$message = "";
				$message .= "<div style='font-family:Verdana,Tahoma,Helvetica,Arial,sans-serif'>";
				$message .= "Hi %RECEIVER_NAME%<br><br>";
				$message .= "%OTHER_NAME% has made changes in the contract and send back for review. ";
				$message .= "Please click <a href='%CONTRACT_URL%'>here</a> to access the contract<br><br>";
				$message .= "Best Regards,<br>";
				$message .= "Clerk Team<br>";
				$message .= "</div>";
			break;
			
			case 'finalized':
				$message = "";
				$message .= "<div style='font-family:Verdana,Tahoma,Helvetica,Arial,sans-serif'>";
				$message .= "Hi %NOTIFY%<br><br>";
				$message .= "Contract between %CREATOR% and %RECEIVER% has been finalized. ";
				$message .= "Please click <a href='%CONTRACT_URL%'>here</a> to view the contract<br><br>";
				$message .= "Best Regards,<br>";
				$message .= "Clerk Team<br>";
				$message .= "</div>";
			break;
			
			case 'opened':
				$message = "";
				$message .= "<div style='font-family:Verdana,Tahoma,Helvetica,Arial,sans-serif'>";
				$message .= "Hi %NOTIFY%<br><br>";
				$message .= "Contract between %CREATOR% and %RECEIVER% has back to open state now. ";
				$message .= "Please click <a href='%CONTRACT_URL%'>here</a> to view the contract<br><br>";
				$message .= "Best Regards,<br>";
				$message .= "Clerk Team<br>";
				$message .= "</div>";
			break;

			default:
				$message = "";
				$message .= "<div style='font-family:Verdana,Tahoma,Helvetica,Arial,sans-serif'>";
				$message .= "Hi %RECEIVER_NAME%<br><br>";
				$message .= "%OTHER_NAME% has %ACTION% the contract.";
				$message .= "Please click <a href='%CONTRACT_URL%'>here</a> to view the contract<br><br>";
				$message .= "Best Regards,<br>";
				$message .= "Clerk Team<br>";
				$message .= "</div>";
			break;
		}
		
		return $message;
	}
		
	public function showPdf(Request $request,$id){
			$contract = Contract::find($id);
			$contract->getCategoryData;
			$contract->getContractParts;
			$contract->getSenderData;
			if($contract->receiver_role == "user"){
				$contract->get_receiver_data = $contract->getReceiverUserData;
				unset($contract->getReceiverUserData);
			} else {
				$contract->get_receiver_data = $contract->getReceiverVendorData;
				unset($contract->getReceiverVendorData);
			}
			view()->share('contract', $contract);
            $pdf = PDF::loadView('contract.contract_pdf');
			//return view('contract.contract_pdf')->with('contract',$contract);			
			// Finally, you can download the file using download function
			return $pdf->download('contract-'.$id.'.pdf');
			
    }	
	
	public function printContract(Request $request,$id){
		$contract = Contract::find($id);
		$contract->getCategoryData;
		$contract->getContractParts;
		$contract->getSenderData;
		if($contract->receiver_role == "user"){
			$contract->get_receiver_data = $contract->getReceiverUserData;
			unset($contract->getReceiverUserData);
		} else {
			$contract->get_receiver_data = $contract->getReceiverVendorData;
			unset($contract->getReceiverVendorData);
		}
		view()->share('contract', $contract);
		return view('contract.contract_pdf')->with('contract',$contract);			
    }
	
	public function sendContractAttachmentEmail(Request $request,$id,$sender){		
		$contract = Contract::find($id);
		$contract->getCategoryData;
		$contract->getContractParts;
		$contract->getSenderData;
		if($contract->receiver_role == "user"){
			$contract->get_receiver_data = $contract->getReceiverUserData;
			unset($contract->getReceiverUserData);
		} else {
			$contract->get_receiver_data = $contract->getReceiverVendorData;
			unset($contract->getReceiverVendorData);
		}
		view()->share('contract', $contract);
        $pdf = PDF::loadView('contract.contract_pdf');
		$content = chunk_split(base64_encode($pdf->output()));

		/********************* Send Email with attachment *******************/
		if( $sender == "true"){
			$name = $contract->getSenderData->shop_name;
			$to = $contract->getSenderData->email;
		} else {
			$name = $contract->get_receiver_data->name;
			$to = $contract->email;
		}
		$template = $this->createTemplate('attachment');
		
		$constants = ['%RECEIVER_NAME%'];
		$values   = [$name];
		$message = str_replace($constants, $values, $template);
		$from = "Admin <admin@clerk.io>";
		
		$attachment = $content;
		$filename = 'contract-' . $contract->id .'.pdf';

		$boundary = md5(date('r', time()));

		$headers = "From: $from";

		$headers .= "\r\nMIME-Version: 1.0\r\nContent-Type: multipart/mixed; boundary=\"_1_$boundary\"";

		$message = "This is a multi-part message in MIME format.

--_1_$boundary
Content-Type: multipart/alternative; boundary=\"_2_$boundary\"

--_2_$boundary
Content-Type: text/html; charset=\"utf-8\"
Content-Transfer-Encoding: 7bit

$message

--_2_$boundary--
--_1_$boundary
Content-Type: application/octet-stream; name=\"$filename\" 
Content-Transfer-Encoding: base64 
Content-Disposition: attachment 

$attachment
--_1_$boundary--";

		if(mail($to, "Contract Attachment", $message, $headers)){
			return new Response([
				'message' => 'Contract attachment sent successfully',
				'statusCode' => 200
			]);
		} else {
			return new Response([
				'message' => 'Contract attachment not sent',
				'statusCode' => 404
			]);
		}
		
    }
	
	public function getTOS(Request $request){
		$cs = ContractSetting::find(1);
		return new Response($cs);
	}
	
	public function saveTOS(Request $request){
		$data = $request->post('terms');
		$cs = ContractSetting::find(1);
		$cs->tos = $data;
		$cs->save();
		return new Response([
            'message' => 'Contract Terms of service updated Successfully',
        ]);
	}
}
