<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;
use DB;
use App\DataTables\RolesDataTable;
use App\Models\RoleHasPermissions;
use App\Models\Configurations;

class RoleController extends Controller
{

    public function __construct()
    {
        $this->middleware('permission:role-list', ['only' => ['index', 'show']]);
        $this->middleware('permission:role-create', ['only' => ['create', 'store']]);
        $this->middleware('permission:role-edit', ['only' => ['edit', 'update']]);
        $this->middleware('permission:role-delete', ['only' => ['destroy']]);
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request, RolesDataTable $dataTable)
    {
        return $dataTable->render('roles.index');
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Request $request)
    {
        $permission = Permission::get();
        $roleTypes = Configurations::where('code', 'ROLE_TYPE')->value('value');

        // Decode the JSON value to an array
        $roleTypes = json_decode($roleTypes, true);

        $categories = [
            'user'                  => 'User',
            'role'                  => 'Role',
            'customer'              => 'Customer',
            'product'               => 'Product',
            'bank'                  => 'Bank',
            'vender'                => 'Vender',
            'generic'               => 'Generic',
            'manufacturer'          => 'Manufacturer',
            'proforma'              => 'Proforma',
            'inquire'               => 'Inquire',
            'quotation'             => 'Quotation',
            'order'                 => 'Order',
            'bd-department'         => 'BD Department',
            'purchase-department'   => 'Purchase Department',
            'wareHouse-department'  => 'Warehouse Department',
            'billing'               => 'Billing',
            'wareHouse-packing-list'=> 'Warehouse Packing List',
            'logistic-department'   => 'Logistic Department',
        ];

        $redirectUrl = urldecode($request->query('redirect', url()->previous()));

        return view('roles.create', compact('categories', 'permission','roleTypes','redirectUrl'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $this->validate($request, [
            'name' => 'required|unique:roles,name|max:255',
            'type' => 'required',
            'permission' => [
                'required',
                'array',
                function ($attribute, $value, $fail) {
                    if (empty ($value)) {
                        $fail('At least one permission must be selected.');
                    }
                }
            ],
            'permission.*' => 'exists:permissions,id',
        ], [
            'permission.required' => 'At least one permission must be selected.',
        ]);

        // Convert the name to uppercase
        $name = strtoupper($request->input('name'));
        $type = strtoupper($request->input('type'));

        // Create the role
        $role = Role::create([
            'name' => $name,
            'type' => $type,
            'guard_name' => 'web',
        ]);

        // Attach permissions to the role
        $role->permissions()->sync($request->input('permission'));

        $redirectUrl = urldecode($request->input('redirect'));

        return redirect($redirectUrl)->with('success', 'Role created successfully');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $role = Role::find($id);
        $rolePermissions = Permission::join("role_has_permissions", "role_has_permissions.permission_id", "=", "permissions.id")
            ->where("role_has_permissions.role_id", $id)
            ->get();

        return view('roles.show', compact('role', 'rolePermissions'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit(Request $request, $id)
    {
        $role = Role::find($id);
        $permission = Permission::get();
        $rolePermissions = DB::table("role_has_permissions")->where("role_has_permissions.role_id", $id)
            ->pluck('role_has_permissions.permission_id', 'role_has_permissions.permission_id')
            ->all();
        $roleTypes = Configurations::where('code', 'ROLE_TYPE')->value('value');

        // Decode the JSON value to an array
        $roleTypes = json_decode($roleTypes, true);

        $categories = [
            'user'                  => 'User',
            'role'                  => 'Role',
            'customer'              => 'Customer',
            'product'               => 'Product',
            'bank'                  => 'Bank',
            'vender'                => 'Vender',
            'generic'               => 'Generic',
            'manufacturer'          => 'Manufacturer',
            'proforma'              => 'Proforma',
            'inquire'               => 'Inquire',
            'quotation'             => 'Quotation',
            'order'                 => 'Order',
            'bd-department'         => 'BD Department',
            'purchase-department'   => 'Purchase Department',
            'wareHouse-department'  => 'WareHouse Department',
            'billing'               => 'Billing',
            'wareHouse-packing-list'=> 'Warehouse Packing List',
            'logistic-department'   => 'Logistic Department',
        ];

        $redirectUrl = urldecode($request->query('redirect', url()->previous()));

        return view('roles.edit', compact('role', 'permission', 'rolePermissions', 'roleTypes', 'categories', 'redirectUrl'));
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
        $this->validate($request, [
            'name' => 'required|max:255|unique:roles,name,' . $id,
            'type' => 'required',
            'permission' => 'required|array', 
            'permission.*' => 'exists:permissions,id',
        ]);

        // Convert the name to uppercase
        $name = strtoupper($request->input('name'));
        $type = strtoupper($request->input('type'));

        // Find the role by ID
        $role = Role::findOrFail($id);

        // Update the role attributes
        $role->update([
            'name' => $name,
            'type' => $type,
            'guard_name' => 'web',
        ]);

        // Sync permissions with the role
        $permissionsIds = $request->input('permission');
        $permissions = Permission::whereIn('id', $permissionsIds)
            ->where('guard_name', 'web')
            ->get();

        $role->syncPermissions($permissions);

        $redirectUrl = urldecode($request->input('redirect'));

        return redirect($redirectUrl)->with('success', 'Role updated successfully');
    }
    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        try {
            $assignedUsers = DB::table('model_has_roles')
                ->where('role_id', $id)
                ->count();

            if ($assignedUsers > 0) {
                return response()->json([
                    'error' => 'This role is used.'
                ]);
            }

            $role = Role::findOrFail($id);
            $role->delete();

            return response()->json(['success' => 'Role deleted successfully']);

        } catch (\Exception $e) {
            return response()->json(['error' => 'Role not found'], 404);
        }
    }
}
