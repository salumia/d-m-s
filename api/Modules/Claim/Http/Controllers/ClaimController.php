<?php

namespace Modules\Claim\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;

use Modules\Claim\Entities\Claim;

class ClaimController extends Controller
{
    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index()
    {
        $claims = Claim::all();
		foreach($claims as $item) {
		    $item->getUserData;
        }
        return new Response($claims);
    }

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
        $claim = Claim::create($data);

        return new Response([
            'message' => 'Claim applied successfully',
            'claim' => $claim
        ]);
    }

    /**
     *  *** RETRIEVE ***
     * Show the specified resource.
     *
     * @param  Claim $claim
     * @return Response
     */
    public function show(Claim $claim)
    {
		$claim->getUserData;
        return new Response($claim);
    }

    /**
     *  *** UPDATE ***
     * Update the specified resource in storage.
     *
     * @param  Claim $claim
     * @param  Request $request
     * @return Response
     */
    public function update(Claim $claim, Request $request)
    {
        // Load new data
        $data = $request->post();

        // Message data

		$data['from_date'] = date("Y-m-d H:i:s", strtotime($data['from_date']));
		$data['to_date'] = date("Y-m-d H:i:s", strtotime($data['to_date']));
		
        // Update data
        $claim->update($data);

        return new Response([
            'message' => 'Claim updated successfully',
            'claim' => $claim
        ]);
    }

    /**
     *  *** DELETE ***
     * Remove the specified resource from storage.
     *
     * @param  Claim $claim
     * @return Response
     */
    public function destroy(Claim $claim)
    {
        // Delete the policy
        try {
            $claim->delete();
        }
        catch(\Exception $e) {
            $response = new Response([
                'message' => $e->getMessage(),
                'claim' => $claim
            ]);
            $response->setStatusCode(Response::HTTP_INTERNAL_SERVER_ERROR);
            return $response;
        }

        return new Response([
            'message' => 'Claim deleted successfully',
            'claim' => $claim
        ]);
    }
    //</editor-fold>
	
	/**
     * Enables any user in the system
     *
     * @param User $user
     * @return Response
     */
    public function updateStatus(Claim $claim, Request $request) {
		
		$data = $request->post();
		
		$claim->status = $data['status'];
		$claim->updated_by = $data['user_id'];
        $claim->save();

        return new Response([
            'message' => 'Claim status updated',
            'claim' => $claim
        ]);
    }
}
