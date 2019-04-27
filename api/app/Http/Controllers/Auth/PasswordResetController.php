<?php
namespace App\Http\Controllers\Auth;
use App\Http\Controllers\Controller;
use App\PasswordReset;
use App\User;
use Illuminate\Http\Request;
use Mail;
class PasswordResetController extends Controller
{
    public function sendResetLinkEmail(Request $request)
    {
        $this->validate($request, [
            'email' => 'required|email|exists:users,email',
        ]);
        //invalidate old tokens
        PasswordReset::whereEmail($request->email)->delete();
        $email = $request->email;
        $reset = PasswordReset::create([
            'email' => $email,
            'token' => str_random(10),
        ]);
		$reset_password_url = config('constants.url').'#/reset-password/'.$reset->token;
        Mail::send('emails.reset_link', compact('email', 'reset_password_url'), function ($mail) use ($email) {
            $mail->to($email)
            ->from('noreply@example.com')
            ->subject('Password reset link');
        });
        return response()->success(true);
    }
    public function verify(Request $request)
    {
        $this->validate($request, [
            'email' => 'required|email',
            'token' => 'required',
        ]);
        $check = PasswordReset::whereEmail($request->email)
        ->whereToken($request->token)
        ->first();
        if (!$check) {
            return response()->error('Email does not exist', 422);
        }
        return response()->success(true);
    }
    public function reset(Request $request)
    {
        $this->validate($request, [
            'email'    => 'required|email',
            'token'    => "required|exists:password_resets,token,email,{$request->email}",
            'password' => 'required|min:8|confirmed',
        ]);
        $user = User::whereEmail($request->email)->firstOrFail();
        $user->password = bcrypt($request->password);
        $user->save();
        //delete pending resets
        PasswordReset::whereEmail($request->email)->delete();
        return response()->success(true);
    }
}

