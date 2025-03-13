<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;

class CreateAdminUserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // Create admin user
        $user = User::create([
            'name' => 'Admin',
            'email' => 'admin@gmail.com',
            'password' => bcrypt('123456'),
            'status' => 1,
        ]);

        // Create admin role if it doesn't exist
        $role = Role::firstOrCreate(['name' => 'Admin']);

        // Assign all permissions to the admin role
        $permissions = Permission::pluck('id');
        $role->syncPermissions($permissions);

        // Assign admin role to the admin user
        $user->assignRole([$role->id]);
    }
}
