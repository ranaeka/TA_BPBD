<?php

namespace App\Http\Controllers;

use App\Users;
use Illuminate\Http\Request;
use Carbon\Carbon;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;


class UserController extends Controller
{
 public function register(Request $request)
 {
    $validator = Validator::make($request->all(),[
        'email'=>'required|email|unique:users',
        'password'=>'required|',
        // min:6
    ]);
    if($validator->fails()){
        return response()->json([
            'error'=>$validator->errors()->getMessages()
        ]);
    }
    $md5=md5($request->input('password'));
    $hash = sha1($md5);
    $file = $request->file('foto');
    $path = 'files/foto_profil/';
    $namefile = $file->getClientOriginalName();
    $file->move($path, $namefile);
    $simpan= Users::insertGetId([
        "email"=>$request->input('email'),
        "password"=>$hash,
        "nama"=>$request->input('nama'),
        "alamat"=>$request->input('alamat'),
        "no_hp"=>$request->input('no_hp'),
        "foto"=>$namefile,
        "level"=>"pelapor",
        "created_at"=>Carbon::now(),
        "updated_at"=>Carbon::now(),
    ]);
   if($simpan){
       return response()->json([
           'status' => true,
           'code'=> 200,
           'message' => 'data berhasil disimpan',
       ]);
   }else{
   return response()->json([
       'status' => false,
       'code' => 600,
       'message' => 'data gagal disimpan'
   ]);
 }   
 }
 
public function login(Request $request)
 {
    $validator = Validator::make($request->all(),[
        'email'=>'required|email',
        'password'=>'required'
    ]);

    if($validator->fails()){
        return response()->json([
            'error' => $validator->errors()->getMessages()
        ]);
    }

    $user = Users::where('email', $request->input('email'))->first();
    $md5=md5($request->input('password'));
    $hash = sha1($md5);
    if($user){
        if($hash==$user->password){
            return response()->json([
                'status' => true,
                'code' => 200,
                'message' => 'Login Berhasil',
                'data' => $user
            ]);

            return response()->json([
                'status' => false,
                'code' => 600,
                'message' => 'Login Gagal'

            ]);
        }else{
            return response()->json([
                'status' => false,
                'code' => 600,
                'message' => 'Login Gagal'

            ]);  
        }
    }
 }

 public function updatePassword(Request $request, $id )
 {
    $user=Users::where('id', $id);
    $validator = Validator::make($request->all(),[
        'password'=>'required'
    ]);
    if($validator->fails()){
        return response()->json([
            'error' => $validator->errors()->getMessages()
        ]);
    }
    $md5=md5($request->input('password'));
    $hash = sha1($md5);
    $simpan=Users::where('id', $id)->update([
        "password"=>$hash,
    ]);
    if($simpan){
        return response()->json([
            'status' => true,
            'code'=> 200,
            'message' => 'data berhasil disimpan',
        ]);
    }
    return response()->json([
        'status' => false,
        'code' => 600,
        'message' => 'data gagal disimpan'
    ]);   
 }

 public function deleteUsers(Type $var = null)
 {
    
 }


}
