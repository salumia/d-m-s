<?php

namespace Modules\Contract\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;

use Modules\Contract\Entities\Part;
use Modules\Set\Entities\SetPart;

class ContractParts extends Controller
{
	
	private $industry;
	private $user;
	private $set;
    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index()
    {
		return new Response(ContractPart::all());
    }
	
	public function userParts($user)
    {
		$this->user = $user;
		$userParts = ContractPart::where('user_id',$this->user)->get();
		foreach($userParts as $item) {
			$item->getIndustryData;
		}
		return new Response($userParts);
    }	

    /**
     * Store a newly created resource in storage.
     * @param  Request $request
     * @return Response
     */
    public function store(Request $request)
    {
		$data = $request->post();
        $contractPart = ContractPart::create($data);

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
		$contractPart = ContractPart::find($contractPart);
        return new Response($contractPart);
    }

    /**
     * Update the specified resource in storage.
     * @param  Request $request
     * @return Response
     */
    public function update($contractPart, Request $request)
    {
		$contractPart = ContractPart::find($contractPart);
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
		$contractPart = ContractPart::find($contractPart);
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
}
