<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Pagination\Paginator;
use App\Observers\UserObserver;
use App\Models\User;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
         // Use Bootstrap 4 for pagination styling
        Paginator::useBootstrapFour();

         // Register the observer for the User model
         User::observe(UserObserver::class);
    }
}
