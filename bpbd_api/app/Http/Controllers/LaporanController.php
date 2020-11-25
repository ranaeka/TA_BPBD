<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Laporan;
use Carbon\Carbon;
use Illuminate\Support\Facades\Validator;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\DB;


class LaporanController extends Controller
{
    public function buatLaporan(Request $request)
    {
       $file = $request->file("foto");
       $path = "files/foto_laporan/";
       $namefile = $file->getClientOriginalName();
       $file->move($path, $namefile);
       $simpan= Laporan::insertGetId([
        //    "nama_pelapor"=>$request->input("nama_pelapor"),
           "id_pelapor"=>$request->input("id_pelapor"),
           "no_hp"=>$request->input("no_hp"),
           "kecamatan"=>$request->input("kecamatan"),
           "desa"=>$request->input("desa"),
           "jenis_bencana"=>$request->input("jenis_bencana"),
           "garis_bujur"=>$request->input("garis_bujur"),
           "garis_lintang"=>$request->input("garis_lintang"),
           "foto_laporan"=>$namefile,
           "keterangan"=>$request->input("keterangan"),
           "status_laporan"=>"Diterima",
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

    public function lihatLaporan($id)
    {
        // $lihat = Laporan::join('users','users.id','laporan.id_pelapor')->where('laporan.id_pelapor',$id)->get();
        $lihat = DB::table('laporan')
        ->join('users', 'laporan.id_pelapor', '=', 'users.id')
        ->select( 'laporan.id','laporan.id_pelapor','laporan.no_hp','laporan.kecamatan','laporan.desa',
        'laporan.jenis_bencana','laporan.garis_bujur','laporan.garis_lintang','laporan.foto_laporan','laporan.keterangan',
        'laporan.status_laporan','laporan.created_at','laporan.updated_at','users.nama')
        ->where('laporan.id_pelapor', '=', $id)
        ->orderby('laporan.created_at',"desc")
        ->get();

        if ($lihat) {
            return response()->json([
                'success'   => true,
                'message'   => 'Detail Post!',
                'data'      => $lihat
            ], 200);
        } else {
            return response()->json([
                'success' => false,
                'message' => 'Post Tidak Ditemukan!',
            ], 404);
        }
    }
}