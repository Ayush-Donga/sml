<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use App\Providers\RouteServiceProvider;
use Illuminate\Support\Facades\Auth;

class CheckStatus
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle(Request $request, Closure $next)
    {
        // //If the status is not approved redirect to login 
        // if(Auth::user()->status == 1){

        //     auth()->logout();
        //     return redirect()->route('login')
        //         ->withError('Your account was deactivate now .');
        // }
        // return $next($request);
        
        if (Auth::check()) {
            if (Auth::user()->status == 0) {
                $user = auth()->user();
                auth()->logout();
                return redirect()->route('login')
                    ->withError('Your account was Deactivate Now ');
            }
            return $next($request);
            // return back()->withError('Your account was deactivate now .');
          }
         
    }
}
