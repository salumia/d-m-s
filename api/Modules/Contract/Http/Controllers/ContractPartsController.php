<?php

namespace Modules\Contract\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;

use Modules\Contract\Entities\ContractPart;

class ContractPartsController extends Controller
{
    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index()
    {
		return new Response(ContractPart::all());
    }
	
	public function globalParts()
    {
		$globalParts = ContractPart::where('type',1)->get();
		foreach($globalParts as $item) {
			$item->getIndustryData;
		}
		return new Response($globalParts);
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
    public function show(ContractPart $contractPart)
    {
        return new Response($contractPart);
    }

    /**
     * Update the specified resource in storage.
     * @param  Request $request
     * @return Response
     */
    public function update(ContractPart $contractPart, Request $request)
    {
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
    public function destroy(ContractPart $contractPart)
    {
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
		$contractPart = ContractPart::find($contractPart);
        $contractPart->status = 0;
        $contractPart->save();

        return new Response([
            'message' => 'Contract Part Disabled',
            'Contract Part' => $contractPart
        ]);
    }
	
    public function enablePart($contractPart) {
        // Enable ContractPart
		$contractPart = ContractPart::find($contractPart);
        $contractPart->status = 1;
        $contractPart->save();

        return new Response([
            'message' => 'Contract Part Enabled',
            'Contract Part' => $contractPart
        ]);
    }
}
