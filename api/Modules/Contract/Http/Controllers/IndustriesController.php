<?php

namespace Modules\Contract\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;

use Modules\Contract\Entities\Industry;
use Modules\Contract\Entities\Part;

class IndustriesController extends Controller
{
    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index()
    {
		return new Response(Industry::all());
    }

    /**
     * Store a newly created resource in storage.
     * @param  Request $request
     * @return Response
     */
    public function store(Request $request)
    {
		$data = $request->post();
        $industry = Industry::create($data);

        return new Response([
            'message' => 'Industry created successfully',
            'industries' => $industry
        ]);
    }

    /**
     * Show the specified resource.
     * @return Response
     */
    public function show(Industry $industry)
    {
        return new Response($industry);
    }

    /**
     * Update the specified resource in storage.
     * @param  Request $request
     * @return Response
     */
    public function update(Industry $industry, Request $request)
    {
        // Load new data
        $data = $request->post();
        // Update data
        $industry->update($data);

        return new Response([
            'message' => 'Industry updated successfully',
			'industries' => $industry
        ]);
    }

    /**
     * Remove the specified resource from storage.
     * @return Response
     */
    public function destroy(Industry $industry)
    {
		if(Part::where([['industry_id','=',$industry->id]])->count() > 0){
			$response = new Response([
				'message' => 'Industry can not be deleted',
				'statusCode' => 202,
				'industries' => $industry
			]);
			return $response;
		} else {
			 // Delete the Page
			try {
				$industry->delete();
			}
			catch(\Exception $e) {
				$response = new Response([
					'message' => $e->getMessage(),
					'industries' => $industry
				]);
				$response->setStatusCode(Response::HTTP_INTERNAL_SERVER_ERROR);
				return $response;
			}

			return new Response([
				'message' => 'Industry deleted successfully',
				'industries' => $industry
			]);
		}       
    }
	
	public function disableIndustry(Industry $industry) {
        // Disable Industry
        $industry->status = 0;
        $industry->save();

        return new Response([
            'message' => 'Industry Disabled',
            'Industry' => $industry
        ]);
    }
	
    public function enableIndustry(Industry $industry) {
        // Disable Industry
        $industry->status = 1;
        $industry->save();

        return new Response([
            'message' => 'Industry Enabled',
            'Industry' => $industry
        ]);
    }
	
	public function getIndustryArray(Request $request)
    {
       return new Response(Industry::select('id as value', 'name as label')->get());
    }
}
