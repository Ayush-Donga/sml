<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use App\Models\UserDeviceToken;


class UserDeviceTokenController extends Controller
{
    /**
     * Store a newly created user device token in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {
        // Validate the request
        $request->validate([
            'user_id' => 'required|exists:users,id',
            'player_id' => 'required|string',
        ]);

        try {
            $deviceToken = UserDeviceToken::create(
                [
                    'user_id' => $request->user_id,
                    'player_id' => $request->player_id,
                    'created_by' => $request->user()->id ?? null
                ]
            );

            return response()->json([
                'success' => true,
                'message' => 'Device token stored successfully.',
                'data' => $deviceToken,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to store device token.',
                'error' => $e->getMessage(),
            ], 500);
        }
    }
}
