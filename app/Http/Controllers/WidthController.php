<?php

namespace App\Http\Controllers;

use App\Models\Width;
use Illuminate\Http\Request;
use App\Datatables\WidthDataTable;

class WidthController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request,WidthDataTable $dataTable)
    {
        return $dataTable->render('width.index');
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('width.create');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        request()->validate([
            'name' => 'required|max:10',
        ]);
        $input = $request->all();
        $input['status'] = @isset($request->status) ? 1 : 0;

        Width::create($input);

        return redirect()->route('width.index')
                        ->with('success','Weight created successfully.');
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Width  $width
     * @return \Illuminate\Http\Response
     */
    public function show(Width $width)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Width  $width
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $width  = Width::find($id);
        return view('width.edit',compact('width'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Width  $width
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        request()->validate([
            'name' => 'required|max:10|unique:widths,name,'.$id,
        ]);

        $input = $request->all();
        $input['status'] = @isset($request->status) ? 1 : 0;
        $State = Width::find($id);
        $State->update($input);

        return redirect()->route('width.index')
                        ->with('success','Weight updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Width  $width
     * @return \Illuminate\Http\Response
     */
    public function destroy(Request $request, $id)
    {
        Width::where('id',$id)->delete();
        if ($request->ajax()) {
            return response()->json(['msg' => true]);
        }

        return redirect()->route('width.index')
                        ->with('success','Weight deleted successfully');
    }
}
