<?php

namespace Modules\Set\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
use Carbon\Carbon;

use Modules\Set\Entities\Set;
use Modules\Set\Entities\SetPart;
class SetController extends Controller
{
    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index()
    {
		//return new Response(Set::all());
		$sets = Set::all();
		foreach($sets as $item) {
			$item->getParts;
		}
		return new Response($sets);
    }
		
	public function getUserSets($user)
    {
		$sets = Set::where(['user_id'=>$user, 'status'=>1])->get();
		$data = [];
		foreach($sets as $set) {
			$getParts = $set->getParts;
			$setParts = [];
			foreach($getParts as $part) {
				$setParts[] = $part->getPartData;
			}
			$temp = [];
			$temp['label'] = $set->title ;
			$temp['value'] = $setParts;
			$data[] = $temp;
		}
		return new Response($data);
    }

    /**
     * Store a newly created resource in storage.
     * @param  Request $request
     * @return Response
     */
    public function store(Request $request)
    {
		$data = $request->post();
        $set = Set::create($data);

        return new Response([
            'message' => 'Set created successfully',
            'sets' => $set
        ]);
    }

    /**
     * Show the specified resource.
     * @return Response
     */
    public function show($set)
    {
        //return new Response($set);
		$set = Set::find($set);
		$set->getParts;
		return new Response($set);
    }

    /**
     * Update the specified resource in storage.
     * @param  Request $request
     * @return Response
     */
    public function update($set, Request $request)
    {
		$set = Set::find($set);
        // Load new data
        $data = $request->post();
        // Update data
        $set->update($data);

        return new Response([
            'message' => 'Set updated successfully',
			'sets' => $set
        ]);
    }

    /**
     * Remove the specified resource from storage.
     * @return Response
     */
    public function destroy(Set $set)
    {
        // Delete the Page
        try {
			$set->delete();
        }
        catch(\Exception $e) {
            $response = new Response([
                'message' => $e->getMessage(),
                'sets' => $set
            ]);
            $response->setStatusCode(Response::HTTP_INTERNAL_SERVER_ERROR);
            return $response;
        }

        return new Response([
            'message' => 'Set deleted successfully',
            'sets' => $set
        ]);
    }
	
	public function disableSet($set) {
		$set = Set::find($set);
        // Disable Set
        $set->status = 0;
        $set->save();

        return new Response([
            'message' => 'Set Disabled',
            'Set' => $set
        ]);
    }
	    
    public function enableSet($set) {
        // Disable Set
		$set = Set::find($set);
        $set->status = 1;
        $set->save();

        return new Response([
            'message' => 'Set Enabled',
            'Set' => $set
        ]);
    }
	
	public function getSetTerms($set) {		
		$sets = SetPart::where([['set_id','=',$set]])->get();
		$data = [];
		foreach($sets as $item) {
			$data[] = $item->getPartData;
		}
		/* foreach($data as $item) {
			$item->getIndustryData;
		} */
		return new Response($data);
	}
	
	public function saveTerms($set, Request $request) {		
		// Load new data
        $terms = $request->post();
		SetPart::where([['set_id','=',$set]])->delete();
		$data = [];		
		foreach($terms as $term){
			$row['part_id'] = $term['id'];
			$row['set_id'] =$set;
			$row['created_at'] = $row['updated_at'] = date('Y-m-d H:i:s');
			$data[] = $row;
		}	
		try{
			if(SetPart::insert($data)){
				return new Response([
					'message' => 'Terms added successfully',
				]);
				
			}
		}catch(\Exception $e) {
            $response = new Response([
                'message' => $e->getMessage()
            ]);
            $response->setStatusCode(Response::HTTP_INTERNAL_SERVER_ERROR);
            return $response;
        }
	}
}
