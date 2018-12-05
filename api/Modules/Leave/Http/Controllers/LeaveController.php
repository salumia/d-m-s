<?php

namespace Modules\Leave\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;

use Modules\User\Entities\Leave;

class LeaveController extends Controller
{
    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index()
    {
        $leaves = Leave::all();
		foreach($leaves as $item) {
		    $item->getUserData;
        }
        return new Response($leaves);
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
        $leave = Leave::create($data);

        return new Response([
            'message' => 'Leave applied successfully',
            'leave' => $leave
        ]);
    }

    /**
     *  *** RETRIEVE ***
     * Show the specified resource.
     *
     * @param  Leave $leave
     * @return Response
     */
    public function show(Leave $leave)
    {
		$leave->getUserData;
        return new Response($leave);
    }

    /**
     *  *** UPDATE ***
     * Update the specified resource in storage.
     *
     * @param  Leave $leave
     * @param  Request $request
     * @return Response
     */
    public function update(Leave $leave, Request $request)
    {
        // Load new data
        $data = $request->post();

        // Message data

		$data['from_date'] = date("Y-m-d H:i:s", strtotime($data['from_date']));
		$data['to_date'] = date("Y-m-d H:i:s", strtotime($data['to_date']));
		
        // Update data
        $leave->update($data);

        return new Response([
            'message' => 'Leave updated successfully',
            'leave' => $leave
        ]);
    }

    /**
     *  *** DELETE ***
     * Remove the specified resource from storage.
     *
     * @param  Leave $leave
     * @return Response
     */
    public function destroy(Leave $leave)
    {
        // Delete the policy
        try {
            $leave->delete();
        }
        catch(\Exception $e) {
            $response = new Response([
                'message' => $e->getMessage(),
                'leave' => $leave
            ]);
            $response->setStatusCode(Response::HTTP_INTERNAL_SERVER_ERROR);
            return $response;
        }

        return new Response([
            'message' => 'Leave deleted successfully',
            'leave' => $leave
        ]);
    }
    //</editor-fold>
	
	/**
     * Enables any user in the system
     *
     * @param User $user
     * @return Response
     */
    public function updateStatus(Leave $leave, Request $request) {
		
		$data = $request->post();
		
		$leave->status = $data['status'];
		$leave->updated_by = $data['user_id'];
        $leave->save();

        return new Response([
            'message' => 'leave status updated',
            'leave' => $leave
        ]);
    }
}
