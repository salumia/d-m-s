<?php

namespace Modules\Appraisal\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;

use Modules\Appraisal\Entities\AppraisalPoint;

class AppraisalPointsController extends Controller
{
    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index()
    {
        $points = AppraisalPoint::all();
        return new Response($points);
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
        $points = AppraisalPoint::create($data);

        return new Response([
            'message' => 'AppraisalPoint applied successfully',
            'point' => $points
        ]);
    }

    /**
     *  *** RETRIEVE ***
     * Show the specified resource.
     *
     * @param  AppraisalPoint $points
     * @return Response
     */
    public function show(AppraisalPoint $points)
    {
        return new Response($points);
    }

    /**
     *  *** UPDATE ***
     * Update the specified resource in storage.
     *
     * @param  AppraisalPoint $points
     * @param  Request $request
     * @return Response
     */
    public function update(AppraisalPoint $points, Request $request)
    {
        // Load new data
        $data = $request->post();

        // Update data
        $points->update($data);

        return new Response([
            'message' => 'AppraisalPoint updated successfully',
            'point' => $points
        ]);
    }

    /**
     *  *** DELETE ***
     * Remove the specified resource from storage.
     *
     * @param  AppraisalPoint $points
     * @return Response
     */
    public function destroy(AppraisalPoint $points)
    {
        // Delete the policy
        try {
            $points->delete();
        }
        catch(\Exception $e) {
            $response = new Response([
                'message' => $e->getMessage(),
                'point' => $points
            ]);
            $response->setStatusCode(Response::HTTP_INTERNAL_SERVER_ERROR);
            return $response;
        }

        return new Response([
            'message' => 'AppraisalPoint deleted successfully',
            'point' => $points
        ]);
    }
    //</editor-fold>
	
}
