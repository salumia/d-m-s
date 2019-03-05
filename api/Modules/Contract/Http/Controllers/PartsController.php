<?php

namespace Modules\Contract\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;

use Modules\Contract\Entities\Part;
use Modules\Set\Entities\SetPart;
use App\VendorUser as VendorUser;

class PartsController extends Controller
{
	
	private $industry;
	private $user;
	private $role;
	private $set;
    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index()
    {
		return new Response(Part::all());
    }
	
	public function userParts($user)
    {
		$this->user = $user;
		$userParts = Part::where('user_id',$this->user)->get();
		foreach($userParts as $item) {
			$item->getIndustryData;
		}
		return new Response($userParts);
    }
	
	public function industryParts($industry, $user, $role = 'vendor')
    {
		$this->user = $user;
		$userData = VendorUser::find($this->user);
		$this->industry = $userData->industry_id;
		$this->role = $role;
		
		$industryParts = Part::where(function($q) {
										$q->where('industry_id', 1)
										  ->where('user_id', $this->user)
										  ->where('role', $this->role);
									})->orWhere(function($q) {
										$q->where(['industry_id'=>$this->industry,'user_id'=>$this->user,'role'=>$this->role]);
									})->get();	
		$data = [];
		foreach($industryParts as $item) {
			$temp = [];
			$temp['label'] = $item->title ;
			$temp['value']['id'] = $item->id ;
			$temp['value']['body'] = $item->body ;
			$data[] = $temp;
		}
		return new Response($data);
    }
	
	public function globalParts()
    {
		$globalParts = Part::where('type',1)->get();
		foreach($globalParts as $item) {
			$item->getIndustryData;
		}
		return new Response($globalParts);
    }
	
	public function availableParts($user,$set=0)
    {
		$availableParts = [];
		$userData = VendorUser::select('industry_id')->where('id',$user)->first();
		if($userData->industry_id > 0){
			$this->user = $user;
			$this->set = $set;			
			$this->industry = $userData->industry_id;			
			if($set > 0 ){
				$availableParts  = Part::where(function($q1) {
											$q1->where('industry_id',1) //All Industry
												->orWhere('industry_id',$this->industry); //industry Specific
										})
										->whereNotIn('id' ,function($query){
												$query->select('part_id')
												->from(with(new SetPart)->getTable())
												->where('set_id', $this->set);
											})												
										->where(function($q) {
											$q->where(['type'=>1, 'status'=>1])
											   ->orWhere('user_id', $this->user);
										 })
										->get();
				
			} else {
				$availableParts  = Part::where(function($q1) {
										$q1->where('industry_id',1) //All Industry
											->orWhere('industry_id',$this->industry); //industry Specific
									})
									->where(function($q) {
										$q->where(['type'=>1, 'status'=>1]) //Global
										->orWhere('user_id',$this->user); //User Specific
									})
									->get();
			}
			
			foreach($availableParts as $item) {
				$item->getIndustryData;
			}
		}
		return new Response($availableParts);
    }

    /**
     * Store a newly created resource in storage.
     * @param  Request $request
     * @return Response
     */
    public function store(Request $request)
    {
		$data = $request->post();
        $contractPart = Part::create($data);

        return new Response([
            'message' => 'Contract Part created successfully',
            'Parts' => $contractPart
        ]);
    }

    /**
     * Show the specified resource.
     * @return Response
     */
    public function show($contractPart)
    {
		$contractPart = Part::find($contractPart);
        return new Response($contractPart);
    }

    /**
     * Update the specified resource in storage.
     * @param  Request $request
     * @return Response
     */
    public function update($contractPart, Request $request)
    {
		$contractPart = Part::find($contractPart);
        // Load new data
        $data = $request->post();
        // Update data
        $contractPart->update($data);

        return new Response([
            'message' => 'Contract Part updated successfully',
			'Parts' => $contractPart
        ]);
    }

    /**
     * Remove the specified resource from storage.
     * @return Response
     */
    public function destroy($contractPart)
    {
		$contractPart = Part::find($contractPart);
        // Delete the Page
        try {
			$contractPart->delete();
        }
        catch(\Exception $e) {
            $response = new Response([
                'message' => $e->getMessage(),
                'Parts' => $contractPart
            ]);
            $response->setStatusCode(Response::HTTP_INTERNAL_SERVER_ERROR);
            return $response;
        }

        return new Response([
            'message' => 'Contract Part deleted successfully',
            'Parts' => $contractPart
        ]);
    }
	
	public function disablePart($contractPart) {
        // Disable ContractPart
		$contractPart = Part::find($contractPart);
        $contractPart->status = 0;
        $contractPart->save();

        return new Response([
            'message' => 'Contract Part Disabled',
            'Contract Part' => $contractPart
        ]);
    }
	
    public function enablePart($contractPart) {
        // Enable ContractPart
		$contractPart = Part::find($contractPart);
        $contractPart->status = 1;
        $contractPart->save();

        return new Response([
            'message' => 'Contract Part Enabled',
            'Contract Part' => $contractPart
        ]);
    }
}
