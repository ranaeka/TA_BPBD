// To parse this JSON data, do
//
//     final modelLaporan = modelLaporanFromJson(jsonString);

import 'dart:convert';

ModelLaporan modelLaporanFromJson(String str) => ModelLaporan.fromJson(json.decode(str));

String modelLaporanToJson(ModelLaporan data) => json.encode(data.toJson());

class ModelLaporan {
  ModelLaporan({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  bool status;
  int code;
  String message;
  List<DataLaporan> data;

  factory ModelLaporan.fromJson(Map<String, dynamic> json) => ModelLaporan(
    status: json["status"],
    code: json["code"],
    message: json["message"],
    data: List<DataLaporan>.from(json["data"].map((x) => DataLaporan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DataLaporan {
  DataLaporan({
    this.id,
    this.idPelapor,
    this.idPetugas,
    this.idBencana,
    this.idJenisBencana,
    this.noHp,
    this.kecamatan,
    this.desa,
    this.jenisBencana,
    this.garisBujur,
    this.garisLintang,
    this.fotoLaporan,
    this.keterangan,
    this.penyebabBencana,
    this.statusLaporan,
    this.createdAt,
    this.updatedAt,
    this.tindakLanjut,
    this.detailJenisBencana,
    this.detailBencana,
    this.detailPelapor,
    this.detailPetugas,
  });

  int id;
  String idPelapor;
  int idPetugas;
  int idBencana;
  String idJenisBencana;
  String noHp;
  String kecamatan;
  String desa;
  String jenisBencana;
  String garisBujur;
  String garisLintang;
  String fotoLaporan;
  String keterangan;
  String penyebabBencana;
  String statusLaporan;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic tindakLanjut;
  DetailJenisBencana detailJenisBencana;
  DetailBencana detailBencana;
  DetailPe detailPelapor;
  DetailPe detailPetugas;

  factory DataLaporan.fromJson(Map<String, dynamic> json) => DataLaporan(
    id: json["id"],
    idPelapor: json["id_pelapor"],
    idPetugas: json["id_petugas"] == null ? null : json["id_petugas"],
    idBencana: json["id_bencana"],
    idJenisBencana: json["id_jenis_bencana"],
    noHp: json["no_hp"],
    kecamatan: json["kecamatan"],
    desa: json["desa"],
    jenisBencana: json["jenis_bencana"] == null ? null : json["jenis_bencana"],
    garisBujur: json["garis_bujur"],
    garisLintang: json["garis_lintang"],
    fotoLaporan: json["foto_laporan"],
    keterangan: json["keterangan"],
    penyebabBencana: json["penyebab_bencana"] == null ? null : json["penyebab_bencana"],
    statusLaporan: json["status_laporan"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    tindakLanjut: json["tindak_lanjut"],
    detailJenisBencana: DetailJenisBencana.fromJson(json["detail_jenis_bencana"]),
    detailBencana: DetailBencana.fromJson(json["detail_bencana"]),
    detailPelapor: DetailPe.fromJson(json["detail_pelapor"]),
    detailPetugas: json["detail_petugas"] == null ? null : DetailPe.fromJson(json["detail_petugas"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_pelapor": idPelapor,
    "id_petugas": idPetugas == null ? null : idPetugas,
    "id_bencana": idBencana,
    "id_jenis_bencana": idJenisBencana,
    "no_hp": noHp,
    "kecamatan": kecamatan,
    "desa": desa,
    "jenis_bencana": jenisBencana == null ? null : jenisBencana,
    "garis_bujur": garisBujur,
    "garis_lintang": garisLintang,
    "foto_laporan": fotoLaporan,
    "keterangan": keterangan,
    "penyebab_bencana": penyebabBencana == null ? null : penyebabBencana,
    "status_laporan": statusLaporan,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "tindak_lanjut": tindakLanjut,
    "detail_jenis_bencana": detailJenisBencana.toJson(),
    "detail_bencana": detailBencana.toJson(),
    "detail_pelapor": detailPelapor.toJson(),
    "detail_petugas": detailPetugas == null ? null : detailPetugas.toJson(),
  };
}

class DetailBencana {
  DetailBencana({
    this.idBencana,
    this.idJenisBencana,
    this.namaBencana,
  });

  int idBencana;
  int idJenisBencana;
  String namaBencana;

  factory DetailBencana.fromJson(Map<String, dynamic> json) => DetailBencana(
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

class DetailJenisBencana {
  DetailJenisBencana({
    this.idJenisBencana,
    this.jenisBencana,
  });

  int idJenisBencana;
  String jenisBencana;

  factory DetailJenisBencana.fromJson(Map<String, dynamic> json) => DetailJenisBencana(
    idJenisBencana: json["id_jenis_bencana"],
    jenisBencana: json["jenis_bencana"],
  );

  Map<String, dynamic> toJson() => {
    "id_jenis_bencana": idJenisBencana,
    "jenis_bencana": jenisBencana,
  };
}

class DetailPe {
  DetailPe({
    this.id,
    this.email,
    this.password,
    this.nama,
    this.alamat,
    this.noHp,
    this.foto,
    this.level,
    this.createdAt,
    this.updatedAt,
    this.nik,
  });

  int id;
  String email;
  String password;
  String nama;
  String alamat;
  String noHp;
  String foto;
  String level;
  DateTime createdAt;
  DateTime updatedAt;
  String nik;

  factory DetailPe.fromJson(Map<String, dynamic> json) => DetailPe(
    id: json["id"],
    email: json["email"],
    password: json["password"],
    nama: json["nama"],
    alamat: json["alamat"],
    noHp: json["no_hp"],
    foto: json["foto"],
    level: json["level"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    nik: json["nik"] == null ? null : json["nik"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "password": password,
    "nama": nama,
    "alamat": alamat,
    "no_hp": noHp,
    "foto": foto,
    "level": level,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "nik": nik == null ? null : nik,
  };
}
