<?php

namespace Modules\Appraisal\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;

use Modules\Appraisal\Entities\Appraisal;
use Modules\Appraisal\Entities\AppraisalFeedback;
use Modules\Appraisal\Entities\KeyResponsibility;
use App\User;

class AppraisalController extends Controller
{
	
	 public function index()
    {
        // Load params
        $user = $_GET['u_id'];
        $department = $_GET['dep'];

        // Default (return all)
        if(!$user && !$department){
            $appraisals = Appraisal::all();
			foreach($appraisals as $item) {
				$item->getUserData;
				$item->getReviewerData;
			}
			return new Response($appraisals);
		}
        // Setup query
        if($user) {
			if($department == 1){
				$appraisals = Appraisal::all();
				foreach($appraisals as $item) {
					$item->getUserData;
					$item->getReviewerData;
				}
				return new Response($appraisals);
			} else{
				$appraisal = Appraisal::where([
					['reviewer_id', '=' , $user]
				]);
				$appraisals = $appraisal->get();
				foreach($appraisals as $item) {
					$item->getUserData;
					$item->getReviewerData;
				}
				return new Response($appraisals);
			}
        }

    }

    /**
     * Display a listing of the resource.
     * @return Response
     */
    /* public function index()
    {
        $appraisals = Appraisal::all();
		foreach($appraisals as $item) {
		    $item->getUserData;
		    $item->getReviewerData;
        }
        return new Response($appraisals);
    } */

    /**
     *  *** CREATE ***
     * Store a newly created resource in storage.
     *
     * @param  Request $request
     * @return Response
     */
    public function store(Request $request)
    {
        $data = $request->post();
		
		$data['from_date'] = date("Y-m-d H:i:s", strtotime($data['from_date']));
		$data['to_date'] = date("Y-m-d H:i:s", strtotime($data['to_date']));
		
		$user = User::where([
					['id', '=' , $data['user_id']]
				])->first();
				
		$data['department'] = $user['department'];
		
        $appraisal = Appraisal::create($data);
		
		$newData = array();
		for($i = 1; $i <= 36; $i++ ){
			
			if($i <= 2){
				$tempRow['section'] = 'P1';
			} elseif($i <= 16){
				$tempRow['section'] = 'P2';
			} elseif($i <= 27){
				$tempRow['section'] = 'P3';
			} elseif($i <= 28){
				$tempRow['section'] = 'P4';
			} elseif($i <= 30){
				$tempRow['section'] = 'P5';
			} elseif($i <= 34){
				$tempRow['section'] = 'P6';
			} elseif($i <= 36){
				$tempRow['section'] = 'P7';
			}
			$tempRow['appraisal_id'] = $appraisal->id;
			$tempRow['point_id'] = $i;
			$tempRow['feedback'] = '';
			$tempRow['rating'] = 0;
			if(isset($row->feedback)){
				$tempRow['feedback'] = $row->feedback;
			}
			if(isset($row->rating)){
				$tempRow['rating'] = $row->rating;
			}
			$tempRow['created_at'] = $tempRow['updated_at'] = date("Y-m-d H:i:s");
			$newData[] = $tempRow;
		}		
		AppraisalFeedback::insert($newData);

        return new Response([
            'message' => 'Appraisal saved successfully',
            'appraisal' => $appraisal
        ]);
    }

    /**
     *  *** RETRIEVE ***
     * Show the specified resource.
     *
     * @param  Appraisal $appraisals
     * @return Response
     */
    public function show(Appraisal $appraisal)
    {
		$appraisal->getUserData;
		$appraisal->getReviewerData;
		$appraisal->getFeedBackData;
		$appraisal->getKeyResponsibilityData;
        return new Response($appraisal);
    }

    /**
     *  *** UPDATE ***
     * Update the specified resource in storage.
     *
     * @param  Appraisal $appraisal
     * @param  Request $request
     * @return Response
     */
    public function update(Appraisal $appraisal, Request $request)
    {
        // Load new data
        $data = $request->post();
		
		$data['from_date'] = date("Y-m-d H:i:s", strtotime($data['from_date']));
		$data['to_date'] = date("Y-m-d H:i:s", strtotime($data['to_date']));
        // Update data
        $appraisal->update($data);

        return new Response([
            'message' => 'Appraisal updated successfully',
            'appraisal' => $appraisal
        ]);
    }

    /**
     *  *** DELETE ***
     * Remove the specified resource from storage.
     *
     * @param  Appraisal $appraisals
     * @return Response
     */
    public function destroy(Appraisal $appraisal)
    {
        // Delete the policy
        try {
            $appraisal->delete();
        }
        catch(\Exception $e) {
            $response = new Response([
                'message' => $e->getMessage(),
                'appraisal' => $appraisal
            ]);
            $response->setStatusCode(Response::HTTP_INTERNAL_SERVER_ERROR);
            return $response;
        }

        return new Response([
            'message' => 'Appraisal deleted successfully',
            'appraisal' => $appraisal
        ]);
    }
    //</editor-fold>
	public function getUsersArray(Request $request)
    {
	   $user_id = $request->post('user_id');
       return new Response(User::select('id as value', 'first_name as label')->where([
					['id', '!=' , $user_id]
				])->get());
    }
	
	public function saveFeedback(Request $request)
    {
		$data = json_decode($request->getContent());
		$newData = array();
		foreach($data as $key=>$row){
			$tempRow['appraisal_id'] = 1;
			$tempRow['point_id'] = $row->id;
			$tempRow['feedback'] = '';
			$tempRow['rating'] = 0;
			if(isset($row->feedback)){
				$tempRow['feedback'] = $row->feedback;
			}
			if(isset($row->rating)){
				$tempRow['rating'] = $row->rating;
			}
			$tempRow['created_at'] = $tempRow['updated_at'] = date("Y-m-d H:i:s");
			$newData[] = $tempRow;
		}		
		AppraisalFeedback::insert($newData);
        return new Response([
            'message' => 'Feedback saved successfully',
        ]); 
    }	
	
	
	public function updateFeedback(Request $request)
    {
		$data = $request->post();
		foreach($data as $key=>$row){			
			$data[$key]['updated_at'] = date("Y-m-d H:i:s");
			AppraisalFeedback::where('id', $data[$key]['id'])
			  ->update($data[$key]);
		}
        return new Response([
            'message' => 'Feedback saved successfully',
        ]); 
    }	
	
	public function updateKeyResponsibility(Request $request)
    {
		$data = $request->post();
		foreach($data as $key=>$row){			
			$data[$key]['updated_at'] = date("Y-m-d H:i:s");
			KeyResponsibility::where('id', $data[$key]['id'])
			  ->update($data[$key]);
		}
        return new Response([
            'message' => 'Feedback saved successfully',
        ]); 
    }	
	
	public function saveKeyResponsibilities(Request $request)
    {
		$data = $request->post();
		foreach($data as $key=>$row){			
			$data[$key]['created_at'] = $data[$key]['updated_at'] = date("Y-m-d H:i:s");
			KeyResponsibility::insert($data[$key]);
		}
        return new Response([
            'message' => 'Responsibilities saved successfully',
        ]); 
    }	
	
	public function getActiveAppraisal(Request $request)
    {
		$user_id = $request->post('user_id');		
        return new Response([
			'data' => Appraisal::where([
					['user_id', '=' , $user_id],
					['status', '!=' , 'Completed']
				])->first()
        ]); 
    }	
	
	public function getReviewAppraisals(Request $request)
    {
		$user_id = $request->post('user_id');		
        return new Response([
			'data' => Appraisal::where([
					['reviewer_id', '=' , $user_id]
				])->get()
        ]); 
    }	
	
	public function getDepartmentAppraisals(Request $request)
    {
		$department = $request->post('department');	
		
        $appraisal = Appraisal::where([
					['department', '=' , $department]
				]);
		$appraisals = $appraisal->get();
		foreach($appraisals as $item) {
			$item->getUserData;
			$item->getReviewerData;
		}
		return new Response($appraisals);
    }	
	
	public function deleteResponsibility(Request $request)
    {
		$id = $request->post('id');	
		$res=KeyResponsibility::where('id',$id)->delete();	
        return new Response([
            'message' => 'Responsibility deleted successfully',
        ]); 
    }	
}
