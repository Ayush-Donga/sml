<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use App\Models\Notification;
use Carbon\Carbon;

class NotificationController extends Controller
{
    public function fetch()
    {
        $user = Auth::user();
        
        // Check if the user is authenticated
        if (!$user) {
            return response()->json(['error' => 'Unauthenticated'], 401);
        }

        $allNotifications = Notification::where('user_id', $user->id)
            ->whereDate('created_at', '>=', Carbon::now()->subDays(30)->toDateString())
            ->latest()
            ->get();

        $unreadNotifications = $allNotifications->where('is_read', false);
        $readNotifications = $allNotifications->where('is_read', true);

        return response()->json([
            'unreadCount' => $unreadNotifications->count(),
            'unreadNotifications' => $unreadNotifications->values()->toArray(),
            'readNotifications' => $readNotifications->values()->toArray(),
            'allNotifications' => $allNotifications->values()->toArray(),
        ]);
    }

    public function markAsRead(Request $request)
    {
        $notification = Notification::find($request->id);

        if ($notification && $notification->user_id == Auth::id()) {
            $notification->is_read = true;
            $notification->save();

            $unreadCount = Notification::where('user_id', Auth::id())->where('is_read', false)->count();

            return response()->json(['status' => 'success', 'unreadCount' => $unreadCount]);
        }

        return response()->json(['status' => 'error', 'message' => 'Notification not found or unauthorized.']);
    }
}
