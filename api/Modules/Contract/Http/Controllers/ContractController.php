<?php
namespace Modules\Contract\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
use Carbon\Carbon;

use Modules\Contract\Entities\Contract;

class ContractController extends Controller
{
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
        $contract = Contract::create($data);

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
	
	public function disableContract(Contract $contract) {
        // Disable Contract
        $contract->status = 0;
        $contract->save();

        return new Response([
            'message' => 'Contract Disabled',
            'Contract' => $contract
        ]);
    }
	
    public function enableContract(Contract $contract) {
        // Disable Contract
        $contract->status = 1;
        $contract->save();

        return new Response([
            'message' => 'Contract Enabled',
            'Contract' => $contract
        ]);
    }
	
	public function getContractArray(Request $request)
    {
       return new Response(Contract::select('id as value', 'name as label')->get());
    }
}
