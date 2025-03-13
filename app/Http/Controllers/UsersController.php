<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\DataTables\UsersDataTable;
use App\Models\User;
use App\Models\Order;
use App\Models\Proforma;
use App\Models\Inquire;
use App\Models\QuotationQuery; 
use App\Models\UserDeviceToken;
use App\Models\Notification;
use Spatie\Permission\Models\Role;
use DB;
use Auth;
use Hash;
use Illuminate\Support\Arr;

class UsersController extends Controller
{

    public function __construct()
    {
        $this->middleware('permission:user-list', ['only' => ['index', 'show']]);
        $this->middleware('permission:user-create', ['only' => ['create', 'store']]);
        $this->middleware('permission:user-edit', ['only' => ['edit', 'update']]);
        $this->middleware('permission:user-delete', ['only' => ['destroy']]);
        $this->middleware('permission:user-reset-password', ['only' => ['resetPassword', 'updateResetPassword']]);
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request, UsersDataTable $dataTable)
    {
        return $dataTable->render('users.index');
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Request $request)
    {
        $roles = Role::pluck('name', 'name')->all();
        $parents = User::where('status', 1)->get(); 
        $redirectUrl = urldecode($request->query('redirect', url()->previous()));

        return view('users.create', compact('roles','parents','redirectUrl'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        // Validate the incoming request data
        $validator = Validator::make($request->all(), [
            'name'     => 'required|max:50|regex:/^[a-zA-Z\s;:.,"&-]*$/',
            'email'    => 'required|email|unique:users,email',
            'password' => 'required|same:confirm-password',
            'confirm-password' => 'required',
            'role'     => 'required',
        ]);
        
        if ($validator->fails()) {
            return redirect()
                ->back()
                ->withErrors($validator)
                ->withInput($request->all());
        }
        
        $input = $request->all();
        $input['password'] = Hash::make($input['password']);
        $input['status'] = @isset($request->status) ? 1 : 0;
        $user = User::create($input);

        $user->assignRole($request->input('role'));

        $redirectUrl = urldecode($request->input('redirect'));

        // Redirect to the users index with a success message
        return redirect($redirectUrl)->with('success', 'User created successfully');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $user = User::with('parent')->findOrFail($id);
       
        return view('users.show', compact('user'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit(Request $request, $id)
    {
        $user = User::find($id);
        $roles = Role::pluck('name', 'name')->all();
        $userRole = collect($user->roles)->pluck('name', 'name')->all();
        $parents = User::where('status', 1)->get();
        $redirectUrl = urldecode($request->query('redirect', url()->previous()));

        return view('users.edit', compact('user', 'roles', 'userRole','parents', 'redirectUrl'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $request->validate([
            'name' => 'required|max:50|regex:/^[a-zA-Z\s;:.,"&-]*$/',
            // 'email' => 'required|email|unique:users,email,' . $id,
            'roles' => 'required'
        ]);

         $input = $request->all();
        // Hash the password if provided
        if (!empty($input['password'])) {
            $input['password'] = Hash::make($input['password']);
        } else {
            $input = Arr::except($input, array('password'));
        }

        // Set the status based on the input
        $input['status'] = isset($request->status) ? 1 : 0;

        // Update the user
        $user = User::find($id);
        $user->update($input);

        // Remove existing roles for the user
        DB::table('model_has_roles')->where('model_id', $id)->delete();

        // Assign new roles to the user
        $user->assignRole($request->input('roles'));

        $redirectUrl = urldecode($request->input('redirect'));

        return redirect($redirectUrl)->with('success', 'User updated successfully');
    }
    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(string $id)
    {
        try {
            $order       = Order::where('created_by', $id)->exists();
            $proforma    = Proforma::where('created_by', $id)->exists();
            $inquire     = Inquire::where('assigned_user_id', $id)->exists();
            $deviceToken = UserDeviceToken::where('user_id', $id)->exists();
            $notification= Notification::where('user_id', $id)->exists();
    
            if ($order || $proforma || $inquire || $deviceToken || $notification) {
                return response()->json(['error' => 'This user is used.']);
            }
    
            $user = User::findOrFail($id);
            $user->delete();
    
            return response()->json(['success' => 'User deleted successfully.']);
    
        } catch (\Exception $e) {
            return response()->json(['error' => 'Unable to delete user. Please try again later.'], 500);
        }
    }
    
    public function resetPassword($id)
    {
        $user = User::find($id);
        
        return view('users.resetPassword', compact('user'));
    }

    public function updateResetPassword(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'newpassword' => 'required|string|min:6|confirmed',
            'newpassword_confirmation' => 'required',
        ], [
            'newpassword.required' => 'The new password field is required.',
            'newpassword.min' => 'The password must be at least 6 characters.',
            'newpassword.confirmed' => 'The new password confirmation does not match.',
            'newpassword_confirmation.required' => 'The confirm password field is required.',
        ]);
    
        // If validation fails, return with errors
        if ($validator->fails()) {
            return redirect()->back()
                ->withErrors($validator)
                ->withInput();
        }    
    
        $user = User::findOrFail($id);
        $user->password = Hash::make($request->get('newpassword'));
        $user->save();
        
        return redirect()->route('users.index')
            ->with('success', 'User password reset successfully');
    }
}
