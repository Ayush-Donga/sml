<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use App\Models\Notification;
use Log;

class MarkNotificationAsRead
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return \Symfony\Component\HttpFoundation\Response
     */
    public function handle(Request $request, Closure $next): Response
    {
        if ($request->has('notification_id')) {
            $notificationId = $request->query('notification_id');
            Log::info("Notification ID received: $notificationId");

            // Validate
            if (!is_numeric($notificationId) || empty($notificationId)) {
                Log::error("Invalid notification_id received.");
                return $next($request);
            }

            // Mark as read if found
            $notification = Notification::where('id', $notificationId)->where('is_read', false)->first();
            if ($notification) {
                $notification->update(['is_read' => true]);
                Log::info("Notification ID $notificationId marked as read.");
            } else {
                Log::error("Notification not found or already read for ID: $notificationId");
            }
        }

        return $next($request);
    }

}
