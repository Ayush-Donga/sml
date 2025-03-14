<?php

namespace App\Exceptions;

use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;
use Illuminate\Session\TokenMismatchException;
use Throwable;

class Handler extends ExceptionHandler
{
    /**
     * The list of the inputs that are never flashed to the session on validation exceptions.
     *
     * @var array<int, string>
     */
    protected $dontFlash = [
        'current_password',
        'password',
        'password_confirmation',
    ];

    /**
     * Register the exception handling callbacks for the application.
     */
    public function register(): void
    {
        $this->reportable(function (Throwable $e) {
            //
        });

        // Add this "renderable" callback to handle TokenMismatchException (419 error).
        $this->renderable(function (TokenMismatchException $e, $request) {
            return redirect()
                ->route('login')
                ->withErrors(['message' => 'Your session has expired. Please log in again.']);
        });
    }
}
