<?php

namespace Modules\Contract\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;

use Modules\Contract\Entities\ContractType;

class ContractTypesController extends Controller
{
    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index()
    {
		return new Response(ContractType::all());
    }

    /**
     * Store a newly created resource in storage.
     * @param  Request $request
     * @return Response
     */
    public function store(Request $request)
    {
		$data = $request->post();
        $contractType = ContractType::create($data);

        return new Response([
            'message' => 'Contract Type created successfully',
            'types' => $contractType
        ]);
    }

    /**
     * Show the specified resource.
     * @return Response
     */
    public function show(ContractType $contractType)
    {
        return new Response($contractType);
    }

    /**
     * Update the specified resource in storage.
     * @param  Request $request
     * @return Response
     */
    public function update(ContractType $contractType, Request $request)
    {
        // Load new data
        $data = $request->post();
        // Update data
        $contractType->update($data);

        return new Response([
            'message' => 'Contract Type updated successfully',
			'types' => $contractType
        ]);
    }

    /**
     * Remove the specified resource from storage.
     * @return Response
     */
    public function destroy(ContractType $contractType)
    {
        // Delete the Page
        try {
			$contractType->delete();
        }
        catch(\Exception $e) {
            $response = new Response([
                'message' => $e->getMessage(),
                'types' => $contractType
            ]);
            $response->setStatusCode(Response::HTTP_INTERNAL_SERVER_ERROR);
            return $response;
        }

        return new Response([
            'message' => 'Contract Type deleted successfully',
            'types' => $contractType
        ]);
    }
	
	public function disableContractType($contractType) {
        // Disable ContractType
		$contractType = ContractType::find($contractType);
        $contractType->status = 0;
        $contractType->save();
		
        return new Response([
            'message' => 'Contract Type Disabled',
            'Contract Type' => $contractType
        ]);
    }
	
    public function enableContractType($contractType) {
        // Disable ContractType
		$contractType = ContractType::find($contractType);
        $contractType->status = 1;
        $contractType->save();

        return new Response([
            'message' => 'Contract Type Enabled',
            'Contract Type' => $contractType
        ]);
    }
	
	public function getTypesArray(Request $request)
    {
       return new Response(ContractType::select('name as value', 'name as label')->get());
    }
}
