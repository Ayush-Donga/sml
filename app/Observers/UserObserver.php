<?php

namespace App\Observers;

use App\Models\User;
use App\Models\UserDeviceToken;

class UserObserver
{

    /**
     * Handle the User "updated" event.
     */
    public function updated(User $user): void
    {
        // Check if the status has been updated to 0 (deactivated)
        if ($user->isDirty('status') && $user->status == 0) {
            // Remove all device tokens associated with this user
            UserDeviceToken::where('user_id', $user->id)->delete();
        }
    }
}
