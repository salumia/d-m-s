<?php
namespace Modules\Contract\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
use Carbon\Carbon;

use Modules\Contract\Entities\Contract;
use Modules\Contract\Entities\ContractPart;
use Modules\Contract\Entities\ContractLog;
use Modules\Notification\Entities\Notification;
use App\User;
use App\VendorUser;

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
		}
        $contract = Contract::create($data);
		if(!empty($contract->receiver_id)){
			$notification = [];
			$notification['user_id'] = $contract->receiver_id;
			$notification['role'] = $contract->receiver_role;
			$notification['ref_id'] = $contract->id;
			Notification::create($notification);
			$this->sendAppraisalMail($contract);
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
		}
        $contract->update($data);
		if(!empty($contract->receiver_id)){
			$notification = [];
			$notification['user_id'] = $contract->receiver_id;
			$notification['role'] = $contract->receiver_role;
			$notification['ref_id'] = $contract->id;
			Notification::create($notification);
			$this->sendAppraisalMail($contract);
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
		
	}
	
	public function openContract($contract, Request $request){
		$contract = Contract::find($contract);
		$contract->status = 1;
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
		
		return new Response([
            'message' => 'Contract status updated',
            'contracts' => $contract
        ]);
	}
	
	public function updateContractStatus($contract, Request $request){
		$data = $request->post();
		
		$contract = Contract::find($contract);
		$contract->status = $data['status'];
		if(isset($data['signature']) && !empty($data['signature'])){
			$contract->signature = $data['signature'];
		}		
        $contract->save();	
		$logData = [];
		if(!empty($contract->id)){
			$notification = [];
			$logData['contract_id'] = $contract->id;
			
			if($contract->status == 2){
				$notification['type'] = 'accept';
				$logData['type'] = 'accept';
			} else {				
				$notification['type'] = 'reject';
				$logData['type'] = 'reject';
			}
			
			if($contract->sender_flag == 2){
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
		
		/******* Delete Contract Old Logs *********/
		//ContractLog::where(["contract_id"=>$contract])->delete();
		
		/******* Update Contract Table*********/
		$contract = Contract::find($contract); 
		if($data['sender']){
			$role = 'sender';
			$contract->sender_flag = 1; // 1 = sent, 2= review, 3= approve, 4 = reject
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
	
	public function sendNotification(Request $request) {
		
            $from = 'accounting@shredex.ca'; //'shreddingtoronto@gmail.com';
            $to = 'nitinsaluja98@gmail.com'; //$client_email; //"testiwm007@gmail.com"; 

            $subject = 'Invoice : Thank You for choosing shredEX!';

            $message = "";
            $message .= "<div style='font-family:Verdana,Tahoma,Helvetica,Arial,sans-serif'>";
            $message .= "Hello John<br><br>";
            $message .= "Thank You for choosing shredEX!<br><br>";
            $message .= "Please find attached, a copy of your Invoice for your most recent Service Order.<br><br>";
            $message .= "If you have any questions, please contact me directly at your convenience.<br><br>";
            $message .= "Best Regards,<br><br>";
            $message .= "shredEX Accounting Department<br>";
            $message .= "<hr>";
            $message .= "<span style='color:#990000;'>SHREDEX INC.</span><br>";
            $message .= "377 Evans Ave., Toronto, ON M8Z 1K8<br><br>";
            $message .= "<span style='color:#990000;'>W:</span> <a href='http://www.shredex.ca' style='color: #15c;'>www.shredex.ca</a><br>";
            $message .= "DIRECT: 416.255.1500<br>";
            $message .= "TOLL FREE: 1.866.868.9585<br>";
            $message .= "<p style='font-size:10px;'>This message and any attachments are the property of the SHREDEX INC. or its affiliates. It may be legally privileged and/or confidential and is intended only for the use of the addressee(s). No addressee should store, forward, print, copy, or otherwise reproduce this message in any manner that would allow it to be viewed by any individual not originally listed as a recipient. If the reader of this message is not the intended recipient, you are hereby notified that any unauthorized storage, disclosure, dissemination, distribution, copying or the taking of any action in reliance on the information herein is strictly prohibited. If you have received this communication in error, please immediately notify the sender and delete this message.</p>";
            $message .= "</div>";

            $attachment = "";
            $filename = 'InvoiceNo.pdf';

            $boundary = md5(date('r', time()));

            $headers = "From: shredEX Accounting <" . $from . ">";

            $headers .= "\r\nMIME-Version: 1.0\r\nContent-Type: multipart/mixed; boundary=\"_1_$boundary\"";

            $message = "This is a multi-part message in MIME format.

--_1_$boundary
Content-Type: multipart/alternative; boundary=\"_2_$boundary\"

--_2_$boundary
Content-Type: text/html; charset=\"utf-8\"
Content-Transfer-Encoding: 7bit

$message

--_2_$boundary--";

            mail($to, $subject, $message, $headers);

	}
}
