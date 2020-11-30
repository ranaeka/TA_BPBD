// To parse this JSON data, do
//
//     final modelJenisBencana = modelJenisBencanaFromJson(jsonString);

import 'dart:convert';

ModelJenisBencana modelJenisBencanaFromJson(String str) => ModelJenisBencana.fromJson(json.decode(str));

String modelJenisBencanaToJson(ModelJenisBencana data) => json.encode(data.toJson());

class ModelJenisBencana {
  ModelJenisBencana({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  bool status;
  int code;
  String message;
  List<Datum> data;

  factory ModelJenisBencana.fromJson(Map<String, dynamic> json) => ModelJenisBencana(
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
    this.idJenisBencana,
    this.jenisBencana,
  });

  int idJenisBencana;
  String jenisBencana;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idJenisBencana: json["id_jenis_bencana"],
    jenisBencana: json["jenis_bencana"],
  );

  Map<String, dynamic> toJson() => {
    "id_jenis_bencana": idJenisBencana,
    "jenis_bencana": jenisBencana,
  };
}
