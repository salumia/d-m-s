<?php
namespace Modules\Contract\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
use Carbon\Carbon;

use Modules\Contract\Entities\Contract;
use Modules\Contract\Entities\ContractPart;
use Modules\Contract\Entities\ContractLog;
use App\User;
use App\VendorUser;

class ContractController extends Controller
{
	private $user;
    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index()
    {
		return new Response(Contract::all());
    }

    /**
     * Store a newly created resource in storage.
     * @param  Request $request
     * @return Response
     */
    public function store(Request $request)
    {
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
        $contract = Contract::create($data);
		$this->sendAppraisalMail($contract);
        return new Response([
            'message' => 'Contract created successfully',
            'contracts' => $contract
        ]);
    }

    /**
     * Show the specified resource.
     * @return Response
     */
    public function show(Contract $contract)
    {
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
    public function update(Contract $contract, Request $request)
    {
        // Load new data
        $data = $request->post();
        // Update data
        $contract->update($data);

        return new Response([
            'message' => 'Contract updated successfully',
			'contracts' => $contract
        ]);
    }

    /**
     * Remove the specified resource from storage.
     * @return Response
     */
    public function destroy(Contract $contract)
    {
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
	
	public function getContractArray(Request $request)
    {
       return new Response(Contract::select('id as value', 'name as label')->get());
    }
		
	public function contractPartData($contractPart){
		$contractPartData = ContractPart::find($contractPart);
		$contractPartData->getLogData;
		return new Response([
            'message' => 'Contract part data',
            'data' => $contractPartData,
        ]);
	}
	
	public function userContracts($user,$role)
    {
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
	
	public function updateContractStatus($contract, Request $request){
		$data = $request->post();
		
		$contract = Contract::find($contract);
		$contract->status = $data['status'];
        $contract->save();		

        return new Response([
            'message' => 'Contract status updated',
            'contracts' => $contract
        ]);
	}
	
	public function updateContractParts($contract,$user, Request $request){
		$data = $request->post();
		
		/******* Delete Contract Old Logs *********/
		ContractLog::where(["contract_id"=>$contract])->delete();
		
		/******* Update Contract Table*********/
		$contract = Contract::find($contract); 
		if($data['sender']){
			$contract->sender_flag = 1; // 1 = sent, 2= review, 3= approve, 4 = reject
			$contract->receiver_flag = 2;
			$contract->save();
		} else {
			$contract->receiver_flag = 1;
			$contract->sender_flag = 2;
			$contract->save();
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
				ContractPart::insert($part);
			}
		}
		
		/******* Save latest Log *********/
		if( sizeof($data['edited_parts']) > 0 ){			
			// save log
			foreach($data['edited_parts'] as $edited){
				ContractLog::create($edited);
			}
		}
		
        return new Response([
            'message' => 'Contract Updated Successfully',
        ]);
    }
}
