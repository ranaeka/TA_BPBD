// To parse this JSON data, do
//
//     final modelBencana = modelBencanaFromJson(jsonString);

import 'dart:convert';

ModelBencana modelBencanaFromJson(String str) => ModelBencana.fromJson(json.decode(str));

String modelBencanaToJson(ModelBencana data) => json.encode(data.toJson());

class ModelBencana {
  ModelBencana({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  bool status;
  int code;
  String message;
  List<Datum> data;

  factory ModelBencana.fromJson(Map<String, dynamic> json) => ModelBencana(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.idBencana,
    this.idJenisBencana,
    this.namaBencana,
  });

  int idBencana;
  int idJenisBencana;
  String namaBencana;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idBencana: json["id_bencana"],
    idJenisBencana: json["id_jenis_bencana"],
    namaBencana: json["nama_bencana"],
  );

  Map<String, dynamic> toJson() => {
    "id_bencana": idBencana,
    "id_jenis_bencana": idJenisBencana,
    "nama_bencana": namaBencana,
  };
}
