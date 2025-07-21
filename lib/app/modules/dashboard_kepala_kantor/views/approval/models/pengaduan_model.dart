import 'dart:convert';

List<Pengaduan> pengaduanListFromJson(String str) =>
    List<Pengaduan>.from(json.decode(str)['data']['pengaduan_list'].map((x) => Pengaduan.fromJson(x)));

String pengaduanToJson(List<Pengaduan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pengaduan {
  int id;
  String nomorPengaduan;
  String judul;
  String status;
  String prioritas;
  String kategori;
  String wargaNama;
  String pegawaiNama;
  String lokasi;
  DateTime tanggalPengaduan;
  String estimasiBiaya;
  String rekomendasi;
  String deskripsiLengkap;
  DateTime createdAt;

  Pengaduan({
    required this.id,
    required this.nomorPengaduan,
    required this.judul,
    required this.status,
    required this.prioritas,
    required this.kategori,
    required this.wargaNama,
    required this.pegawaiNama,
    required this.lokasi,
    required this.tanggalPengaduan,
    required this.estimasiBiaya,
    required this.rekomendasi,
    required this.deskripsiLengkap,
    required this.createdAt,
  });

  factory Pengaduan.fromJson(Map<String, dynamic> json) => Pengaduan(
        id: json["id"],
        nomorPengaduan: json["nomor_pengaduan"],
        judul: json["judul"],
        status: json["status"],
        prioritas: json["prioritas"],
        kategori: json["kategori"],
        wargaNama: json["warga_nama"],
        pegawaiNama: json["pegawai_nama"],
        lokasi: json["lokasi"],
        tanggalPengaduan: DateTime.parse(json["tanggal_pengaduan"]),
        estimasiBiaya: json["estimasi_biaya"],
        rekomendasi: json["rekomendasi"],
        deskripsiLengkap: json["deskripsi_lengkap"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nomor_pengaduan": nomorPengaduan,
        "judul": judul,
        "status": status,
        "prioritas": prioritas,
        "kategori": kategori,
        "warga_nama": wargaNama,
        "pegawai_nama": pegawaiNama,
        "lokasi": lokasi,
        "tanggal_pengaduan": tanggalPengaduan.toIso8601String(),
        "estimasi_biaya": estimasiBiaya,
        "rekomendasi": rekomendasi,
        "deskripsi_lengkap": deskripsiLengkap,
        "created_at": createdAt.toIso8601String(),
      };
}