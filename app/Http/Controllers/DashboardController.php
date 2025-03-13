<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Carbon\Carbon;
use Auth;
use Hash;
use App\Models\User;
use Illuminate\Support\Facades\Auth as FacadesAuth;

class DashboardController extends Controller
{
    public function profile(Request $request)
    {
        $activeTab = $request->input('active_tab', 'v-pills-profile'); 
        $profile = Auth::user();
        return view('settings.profile', compact('profile', 'activeTab'));
    }


    public function profileUpdate(Request $request)
    {
        $request->validate([
            'name' => 'required|max:50|regex:/^[a-zA-Z\s;:.,"&-]*$/',
            'email' => 'required|email',
        ]);
    
        $user = User::find(Auth::id());
        $user->name = $request->name;
        $user->email = $request->email;
        $user->save();
    
        return redirect()->route('profile', ['active_tab' => 'v-pills-profile'])->with('success', 'Profile updated successfully.');
    }
    

    public function changePasswordUpdate(Request $request)
    {
        $request->validate([
            'currentpassword' => 'required',
            'newpassword' => 'required|string|min:6|confirmed',
            'newpassword_confirmation' => 'required'
        ]);
    
        $user = Auth::user();
    
        // Check if the current password matches the password provided
        if (!Hash::check($request->currentpassword, $user->password)) {
            return redirect()->route('profile', ['active_tab' => 'v-pills-dashboard'])
                             ->withErrors(['currentpassword' => 'Your current password does not match the password you provided! Please try again.']);
        }
    
        // Check if the new password is the same as the current password
        if (strcmp($request->currentpassword, $request->newpassword) === 0) {
            return redirect()->route('profile', ['active_tab' => 'v-pills-dashboard'])
                             ->withErrors(['newpassword' => 'New Password cannot be the same as your current password! Please choose a different password.']);
        }
    
        // Update the user's password
        $user->password = bcrypt($request->newpassword);
        $user->save();
    
        return redirect()->route('profile', ['active_tab' => 'v-pills-dashboard'])->with('success', 'Password changed successfully.');
    }
    


    public function expirydate($id)
    {

    }
}
