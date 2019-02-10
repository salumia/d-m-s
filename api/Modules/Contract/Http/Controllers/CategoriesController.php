<?php
namespace Modules\Contract\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
use Carbon\Carbon;

use Modules\Contract\Entities\Category;

class CategoriesController extends Controller
{
    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index()
    {
		return new Response(Category::all());
    }

    /**
     * Store a newly created resource in storage.
     * @param  Request $request
     * @return Response
     */
    public function store(Request $request)
    {
		$data = $request->post();
        $category = Category::create($data);

        return new Response([
            'message' => 'Category created successfully',
            'categories' => $category
        ]);
    }

    /**
     * Show the specified resource.
     * @return Response
     */
    public function show(Category $category)
    {
        return new Response($category);
    }

    /**
     * Update the specified resource in storage.
     * @param  Request $request
     * @return Response
     */
    public function update(Category $category, Request $request)
    {
        // Load new data
        $data = $request->post();
        // Update data
        $category->update($data);

        return new Response([
            'message' => 'Category updated successfully',
			'categories' => $category
        ]);
    }

    /**
     * Remove the specified resource from storage.
     * @return Response
     */
    public function destroy(Category $category)
    {
        // Delete the Page
        try {
			$category->delete();
        }
        catch(\Exception $e) {
            $response = new Response([
                'message' => $e->getMessage(),
                'categories' => $category
            ]);
            $response->setStatusCode(Response::HTTP_INTERNAL_SERVER_ERROR);
            return $response;
        }

        return new Response([
            'message' => 'Category deleted successfully',
            'categories' => $category
        ]);
    }
	
	public function disableCategory(Category $category) {
        // Disable Category
        $category->status = 0;
        $category->save();

        return new Response([
            'message' => 'Category Disabled',
            'category' => $category
        ]);
    }
	
    public function enableCategory(Category $category) {
        // Disable Category
        $category->status = 1;
        $category->save();

        return new Response([
            'message' => 'Category Enabled',
            'category' => $category
        ]);
    }
	
	public function getCategoryArray(Request $request)
    {
       return new Response(Category::select('id as value', 'name as label')->get());
    }
}
