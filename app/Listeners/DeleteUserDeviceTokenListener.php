<?php

namespace App\Listeners;

use Illuminate\Auth\Events\Logout;
use App\Models\UserDeviceToken;

class DeleteUserDeviceTokenListener
{
    /**
     * Handle the event.
     *
     * @param  \Illuminate\Auth\Events\Logout  $event
     * @return void
     */
    public function handle(Logout $event)
    {
        // Get the user that logged out
        $user = $event->user;

        // Delete the associated device tokens for the logged-out user
        UserDeviceToken::where('user_id', $user->id)->delete();
    }
}
