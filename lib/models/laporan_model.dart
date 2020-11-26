// To parse this JSON data, do
//
//     final modelLaporan = modelLaporanFromJson(jsonString);

import 'dart:convert';

ModelLaporan modelLaporanFromJson(String str) => ModelLaporan.fromJson(json.decode(str));

String modelLaporanToJson(ModelLaporan data) => json.encode(data.toJson());

class ModelLaporan {
    ModelLaporan({
        this.success,
        this.message,
        this.data,
    });

    bool success;
    String message;
    List<Datum> data;

    factory ModelLaporan.fromJson(Map<String, dynamic> json) => ModelLaporan(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.idPelapor,
        this.noHp,
        this.kecamatan,
        this.desa,
        this.jenisBencana,
        this.garisBujur,
        this.garisLintang,
        this.fotoLaporan,
        this.keterangan,
        this.statusLaporan,
        this.createdAt,
        this.updatedAt,
        this.nama,
    });

    int id;
    int idPelapor;
    String noHp;
    String kecamatan;
    String desa;
    String jenisBencana;
    String garisBujur;
    String garisLintang;
    String fotoLaporan;
    String keterangan;
    String statusLaporan;
    DateTime createdAt;
    DateTime updatedAt;
    String nama;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idPelapor: json["id_pelapor"],
        noHp: json["no_hp"],
        kecamatan: json["kecamatan"],
        desa: json["desa"],
        jenisBencana: json["jenis_bencana"],
        garisBujur: json["garis_bujur"],
        garisLintang: json["garis_lintang"],
        fotoLaporan: json["foto_laporan"],
        keterangan: json["keterangan"],
        statusLaporan: json["status_laporan"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        nama: json["nama"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_pelapor": idPelapor,
        "no_hp": noHp,
        "kecamatan": kecamatan,
        "desa": desa,
        "jenis_bencana": jenisBencana,
        "garis_bujur": garisBujur,
        "garis_lintang": garisLintang,
        "foto_laporan": fotoLaporan,
        "keterangan": keterangan,
        "status_laporan": statusLaporan,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "nama": nama,
    };
}
