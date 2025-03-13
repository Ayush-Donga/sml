<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;

class OneSignalService
{
    protected $appId;
    protected $authToken;

    public function __construct()
    {
        $this->appId = config('services.onesignal.app_id');  
        $this->authToken = config('services.onesignal.rest_api_key');
    }
    
    public function sendNotification($playerIds, $heading, $content, $url)
    {

        $response = Http::withHeaders([
            'Authorization' => "Basic $this->authToken",
            'Content-Type' => 'application/json',
        ])
        ->post('https://onesignal.com/api/v1/notifications', [
            'app_id' => $this->appId,
            'include_player_ids' => $playerIds,
            'headings' => ['en' => $heading],
            'contents' => ['en' => $content],
            'url' => $url,
        ]);
        
        // Log the response for debugging
        //\Log::info('OneSignal Response:', $response->json());
    
        return $response->json();
    }
    
}
