<?php

namespace Modules\Page\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
use Carbon\Carbon;

use Modules\Page\Entities\Page;
use Modules\Page\Entities\PageFiles;

class PageController extends Controller
{
    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index()
    {
		return new Response(Page::all());
    }

    /**
     * Show the form for creating a new resource.
     * @return Response
     */
    public function create()
    {
        return view('Page::create');
    }

    /**
     * Store a newly created resource in storage.
     * @param  Request $request
     * @return Response
     */
    public function store(Request $request)
    {
		$data = $request->post();
        $page = Page::create($data);

        return new Response([
            'message' => 'Page created successfully',
            'pages' => $page
        ]);
    }

    /**
     * Show the specified resource.
     * @return Response
     */
    public function show(Page $page)
    {
		$page->getFiles;
        return new Response($page);
    }

    /**
     * Show the form for editing the specified resource.
     * @return Response
     */
    public function edit()
    {
        return view('Page::edit');
    }

    /**
     * Update the specified resource in storage.
     * @param  Request $request
     * @return Response
     */
    public function update(Page $page, Request $request)
    {
        // Load new data
        $data = $request->post();
        // Update data
        $page->update($data);

        return new Response([
            'message' => 'Page updated successfully',
			'pages' => $page
        ]);
    }

    /**
     * Remove the specified resource from storage.
     * @return Response
     */
    public function destroy(Page $page)
    {
        // Delete the Page
        try {
			$page->delete();
        }
        catch(\Exception $e) {
            $response = new Response([
                'message' => $e->getMessage(),
                'pages' => $page
            ]);
            $response->setStatusCode(Response::HTTP_INTERNAL_SERVER_ERROR);
            return $response;
        }

        return new Response([
            'message' => 'Page deleted successfully',
            'pages' => $page
        ]);
    }
	
		public function updatedocuments(Request $request) {
		$id = $request->post('id');
		$files = $request->post('files');
		$data = [];		
		foreach($files as $file){
			$row['name'] = $file[0];
			$row['original_name'] = $file[1];
			$row['page_id'] =$id;
			$row['created_at'] = $row['updated_at'] = date('Y-m-d H:i:s');
			$data[] = $row;
		}		
		PageFiles::insert($data);       
		return new Response([
            'message' => 'Page docs saved successfully',
        ]);
	}
	
	public function uploadDocuments(Request $request) {
		$destinationPath = public_path('/images');
		$output = [];
		foreach($request->file('documents') as $image){
			$name = time().'.'.$image->getClientOriginalExtension();			
			$image->move($destinationPath, $name);
			$output[] = array($name,$image->getClientOriginalName());
		}
		return new Response([
            'message' => 'Files uploaded successfully',
            'upoadedfiles' => $output
        ]);
	}
	
	public function deleteDocument(Request $request) {
		$page_id = $request->post('id');
		$file = $request->post('file');
		$destinationPath = public_path('images');
		try{
			unlink($destinationPath."/".$file['name']);
			//PageFiles::where('id',$page_id)->delete();
			PageFiles::where([['page_id','=',$page_id],['name','=',$file['name']]])->delete();
			return new Response([
				'message' => 'File deleted successfully',
			]);
		}catch(\Exception $e) {
            $response = new Response([
                'message' => $e->getMessage()
            ]);
            $response->setStatusCode(Response::HTTP_INTERNAL_SERVER_ERROR);
            return $response;
        }
		
	}	
	
	public function deleteCover(Request $request) {
		$id = $request->post('id');
		$file = $request->post('file');
		$destinationPath = public_path('images');
		try{
			unlink($destinationPath."/".$file);
			$page = new Page();
			$collection = $page->whereId($id);
			$data = $collection->get();
			$collection->update(array("cover_image" => ""));			
			return new Response([
				'message' => 'File deleted successfully'
			]);
		}catch(\Exception $e) {
            $response = new Response([
                'message' => $e->getMessage()
            ]);
            $response->setStatusCode(Response::HTTP_INTERNAL_SERVER_ERROR);
            return $response;
        }		
	}
}
