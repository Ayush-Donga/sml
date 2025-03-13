<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;

class PermissionTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $permissions = [
            ['name' => 'user-list',   'category' => 'user'],
            ['name' => 'user-create', 'category' => 'user'],
            ['name' => 'user-edit',   'category' => 'user'],
            ['name' => 'user-delete', 'category' => 'user'],
            ['name' => 'user-reset-password', 'category' => 'user'],
            ['name' => 'role-list',   'category' => 'role'],
            ['name' => 'role-create', 'category' => 'role'],
            ['name' => 'role-edit',   'category' => 'role'],
            ['name' => 'role-delete', 'category' => 'role'],
            ['name' => 'order-list',   'category' => 'order'],
            ['name' => 'order-create', 'category' => 'order'],
            ['name' => 'order-edit',   'category' => 'order'],
            ['name' => 'order-delete', 'category' => 'order'],
            ['name' => 'bd-department-list', 'category' => 'bd-department'],
            ['name' => 'bd-department-edit', 'category' => 'bd-department'],
            ['name' => 'purchase-department-edit', 'category' => 'purchase-department'],
            ['name' => 'wareHouse-department-edit', 'category' => 'wareHouse-department'],
            ['name' => 'billing-edit', 'category' => 'billing'],
            ['name' => 'wareHouse-packing-list-edit', 'category' => 'wareHouse-packing-list'],
            ['name' => 'logistic-department-edit', 'category' => 'logistic-department'],
            ['name' => 'product-list',   'category' => 'product'],
            ['name' => 'product-create', 'category' => 'product'],
            ['name' => 'product-edit',   'category' => 'product'],
            ['name' => 'product-delete', 'category' => 'product'],
            ['name' => 'customer-list',   'category' => 'customer'],
            ['name' => 'customer-create', 'category' => 'customer'],
            ['name' => 'customer-edit',   'category' => 'customer'],
            ['name' => 'customer-delete', 'category' => 'customer'],
            ['name' => 'bank-list',   'category' => 'bank'],
            ['name' => 'bank-create', 'category' => 'bank'],
            ['name' => 'bank-edit',   'category' => 'bank'],
            ['name' => 'bank-delete', 'category' => 'bank'],
            ['name' => 'proforma-list',   'category' => 'proforma'],
            ['name' => 'proforma-create', 'category' => 'proforma'],
            ['name' => 'proforma-edit',   'category' => 'proforma'],
            ['name' => 'proforma-delete', 'category' => 'proforma'],       
            ['name' => 'vender-list',   'category' => 'vender'],
            ['name' => 'vender-create', 'category' => 'vender'],
            ['name' => 'vender-edit',   'category' => 'vender'],
            ['name' => 'vender-delete', 'category' => 'vender'],
            ['name' => 'generic-list',   'category' => 'generic'],
            ['name' => 'generic-create', 'category' => 'generic'],
            ['name' => 'generic-edit',   'category' => 'generic'],
            ['name' => 'generic-delete', 'category' => 'generic'],
            ['name' => 'manufacturer-list',   'category' => 'manufacturer'],
            ['name' => 'manufacturer-create', 'category' => 'manufacturer'],
            ['name' => 'manufacturer-edit',   'category' => 'manufacturer'],
            ['name' => 'manufacturer-delete', 'category' => 'manufacturer'],
            ['name' => 'inquire-list',   'category' => 'inquire'],
            ['name' => 'inquire-create', 'category' => 'inquire'],
            ['name' => 'inquire-edit',   'category' => 'inquire'],
            ['name' => 'inquire-delete', 'category' => 'inquire'],
            ['name' => 'quotation-list',   'category' => 'quotation'],
            ['name' => 'quotation-create', 'category' => 'quotation'],
            ['name' => 'quotation-edit',   'category' => 'quotation'],
        ];
    
        foreach ($permissions as $permissionData) {
            $existingPermission = Permission::where('name', $permissionData['name'])
                                             ->where('category', $permissionData['category'])
                                             ->first();

            if (!$existingPermission) {
                Permission::create([
                    'name'     => $permissionData['name'],
                    'category' => $permissionData['category'],
                ]);
            }
        }
    }
}
