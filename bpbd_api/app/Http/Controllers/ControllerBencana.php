<?php

namespace App\Http\Controllers;

use App\Bencana;
use App\JenisBencana;
use Illuminate\Http\Request;
use App\Laporan;
use App\Uraian;
use Carbon\Carbon;

class ControllerBencana extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }


    public function getJenisBencana(Request $request)
    {
        $data=JenisBencana::get();

        return response()->json([
                'status' => true,
                'code' => 200,
                "message" => "data ditemukan",
                "data" => $data
        ]);
    }

    public function getBencana(Request $request)
    {
        $data = Bencana::where('id_jenis_bencana',$request->id_jenis_bencana)->get();

        return response()->json([
            'status' => true,
            'code' => 200,
            "message" => "data ditemukan",
            "data" => $data
        ]);
    }


    public function getLaporan(Request $request)
    {
        if($request->id_user==null){
            $data=Laporan::with(['detailJenisBencana','detailBencana','detailPelapor','detailPetugas'])->orderBy('updated_at','DESC')->get();
            return response()->json([
                'status' => true,
                "code" => 200,
                "message" => "data ditemukan",
                "data" => $data
            ]);
        }else{
           if($request->level=="Petugas"){
                $data = Laporan::with(['detailJenisBencana', 'detailBencana', 'detailPelapor', 'detailPetugas'])
                    ->where('id_petugas',$request->id_user)->orderBy('updated_at', 'DESC')->get();
                return response()->json([
                    'status' => true,
                    "code" => 200,
                    "message" => "data ditemukan",
                    "data" => $data
                ]);
           }else{
                $data = Laporan::with(['detailJenisBencana', 'detailBencana', 'detailPelapor', 'detailPetugas'])
                ->where('id_pelapor', $request->id_user)->orderBy('updated_at', 'DESC')->get();
                return response()->json([
                    'status' => true,
                    "code" => 200,
                    "message" => "data ditemukan",
                    "data" => $data
                ]);
           }
        }
    }

    public function updateStatus(Request $request)
    {


            $data=Laporan::where('id',$request->id_laporan)->update([
                'status_laporan' => $request->input('status'),
                'tindak_lanjut' => $request->input('tindak_lanjut'),
                'id_petugas' => $request->input('id_user'),
                'updated_at' => Carbon::now()
            ]);

            $save=Uraian::insertGetId([
                "uraian" => $request->input('tindak_lanjut'),
                "status" => $request->input("status"),
                "created_at" => Carbon::now(),
                "updated_at" => Carbon::now(),
                "id_user" => $request->input("id_user")
            ]);

            if($data && $save){
            return response()->json([
                'status' => true,
                "code" => 200,
                "message" => "data berhasil disimpan",

            ]);
            }
        return response()->json([
            'status' => false,
            "code" => 600,
            "message" => "data gagal disimpan",

        ]);

    }

    public function saveUraian(Request $request)
    {
        $save = Uraian::insertGetId([
            "uraian" => $request->input('tindak_lanjut'),
            "status" => $request->input("status"),
            "created_at" => Carbon::now(),
            "updated_at" => Carbon::now(),
            "id_user" => $request->input("id_user")
        ]);

        if ($save) {
            return response()->json([
                'status' => true,
                "code" => 200,
                "message" => "data berhasil disimpan",

            ]);
        }
        return response()->json([
            'status' => false,
            "code" => 600,
            "message" => "data gagal disimpan",

        ]);
    }

    public function editUraian(Request $request)
    {
        $save = Uraian::where('id_uraian',$request->id_uraian)->update([
            "uraian" => $request->input('tindak_lanjut'),
            "status" => $request->input("status"),
            "created_at" => Carbon::now(),
            "updated_at" => Carbon::now(),
            "id_user" => $request->input("id_user")
        ]);

        if ($save) {
            return response()->json([
                'status' => true,
                "code" => 200,
                "message" => "data berhasil disimpan",

            ]);
        }
        return response()->json([
            'status' => false,
            "code" => 600,
            "message" => "data gagal disimpan",

        ]);
    }

    public function deleteUraian(Request $request,$id)
    {
        $delete=Uraian::where('id_uraian',$id)->delete();

        return response()->json([
            "status" => true,
            "message" => "success delete",
            "code" => 200
        ]);
    }
    public function getUraian(Request $request)
    {
        $data = Uraian::where('id_user',$request->id_user)->orderBy('updated_at','DESC')->get();

        return response()->json([
            "status" => true,
            "message" => "data ditemukan",
            "code" => 200,
            "data" => $data
        ]);
    }



    //
}
