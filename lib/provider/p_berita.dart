import 'package:bpbd/models/m_bencana.dart';
import 'package:bpbd/models/m_berita.dart';
import 'package:bpbd/models/m_jenis_bencana.dart';
import 'package:bpbd/models/m_laporan.dart';
import 'package:bpbd/models/m_riyawat_laporan.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api_service/api.dart';

class ProviderBerita extends ChangeNotifier{
  Dio dio=new Dio();
  
  
  ModelBerita _modelBerita;


  ModelBerita get modelBerita => _modelBerita;

  set modelBerita(ModelBerita value) {
    _modelBerita = value;notifyListeners();
  }

  Future<ModelBerita> getBerita()async{
    Response response;
    
    response=await dio.get("http://newsapi.org/v2/top-headlines",queryParameters: {
      "country"  : "id",
      "category" : "science",
      "apiKey"  : "10695d21fe844ce2aa82f7163bf9239c"
    });

    if(response.statusCode==200){
      modelBerita=ModelBerita.fromJson(response.data);
    }

    return modelBerita;
  }


  ModelLaporan _modelLaporan;

  ModelLaporan get modelLaporan => _modelLaporan;

  set modelLaporan(ModelLaporan value) {
    _modelLaporan = value;
    notifyListeners();
  }


  ModelRiwayatLaporan _riwayatLaporan;


  ModelRiwayatLaporan get riwayatLaporan => _riwayatLaporan;

  set riwayatLaporan(ModelRiwayatLaporan value) {
    _riwayatLaporan = value;
    notifyListeners();
  }

  Future<ModelLaporan> getLaporan({bool isMe=false})async{
    Response response;
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var level=prefs.get("level");
  var idUser =prefs.get("id");
    if(isMe){
      response=await dio.get(ApiServer.getLaporan,queryParameters: {
        "level"  : "$level",
        "id_user" : "$idUser"
      });
    }else{
      response=await dio.get(ApiServer.getLaporan);
    }
    if(response.statusCode==200){
      modelLaporan=ModelLaporan.fromJson(response.data);
    }
    return modelLaporan;
  }

  Future<ModelRiwayatLaporan> getRiwayatLaporan({bool isMe=false})async{
    Response response;
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var level=prefs.get("level");
    var idUser =prefs.get("id");
    print(level);
    print(idUser);
    if(isMe){
      response=await dio.get(ApiServer.getLaporan,queryParameters: {
        "level"  : "$level",
        "id_user" : "$idUser"
      });
    }else{
      response=await dio.get(ApiServer.getLaporan);
    }
    if(response.statusCode==200){
      riwayatLaporan=ModelRiwayatLaporan.fromJson(response.data);
    }
    return riwayatLaporan;
  }


  Future<bool> deleteLaporan({BuildContext context,String id})async{
    Response response;
    String url="${ApiServer.deleteLaporan}/$id";
    ProgressDialog pg=new ProgressDialog(context,dismissable: false,message: Text("Loading"),blur: 3);
    pg.show();
    response=await dio.delete(url);
    print(response.data);

    if(response.statusCode==200){
      pg.dismiss();

      getLaporan(isMe: true).then((value)  {
        Navigator.pop(context);
      });
      return true;
    }

    return true;
  }

  ModelJenisBencana _jenisBencana;

  ModelJenisBencana get jenisBencana => _jenisBencana;

  set jenisBencana(ModelJenisBencana value) {
    _jenisBencana = value;
    notifyListeners();
  }

  Future<ModelJenisBencana> getJenisBencana()async{
    Response response;
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var level=prefs.get("level");
    var idUser =prefs.get("id");
    print(level);
    print(idUser);

      response=await dio.get(ApiServer.getJenisBencana);
    if(response.statusCode==200){
      print(response.data);
      jenisBencana=ModelJenisBencana.fromJson(response.data);
    }
    return jenisBencana;
  }


  ModelBencana _bencana;

  ModelBencana get bencana => _bencana;

  set bencana(ModelBencana value) {
    _bencana = value;
    notifyListeners();
  }

  Future<ModelBencana> getBencana({BuildContext context,String id})async{
    Response response;
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var level=prefs.get("level");
    var idUser =prefs.get("id");
    print(level);
    print(idUser);
    ProgressDialog pg=ProgressDialog(context,message: Text("Loading.."),blur: 2,dismissable: false);
    pg.show();

    response=await dio.get(ApiServer.getBencana,queryParameters: {
      "id_jenis_bencana"  :"$id"
    });
    if(response.statusCode==200){
      pg.dismiss();
      bencana=ModelBencana.fromJson(response.data);
    }
    return bencana;
  }


  Future<bool> updateStatus({BuildContext context,String id, String status,String tindakLanjut})async{
    ProgressDialog pg=new ProgressDialog(context,message: Text("Mohon Tunggu.."),dismissable: false,blur: 3);
    pg.show();
    SharedPreferences prefs=await SharedPreferences.getInstance();
    var idUser=prefs.get('id');
    dio=new Dio();

    Response response;
    response=await dio.post(ApiServer.updateStatus,queryParameters: {
      "id_laporan" : "$id"
    },data: {
      "status"  : "$status",
      "tindak_lanjut"  :"$tindakLanjut",
      "id_user" : "$idUser"
    });
    if(response.statusCode==200){
      pg.dismiss();
      getLaporan();

    }
    return true;
  }
}