import 'warga_model.dart';
import 'kategori_model.dart';

class PengaduanPegawaiModel {
  final int id;
  final String nomorPengaduan;
  final String judul;
  final String deskripsi;
  final String status;
  final String lokasi;
  final String? fotoPengaduan;
  final KategoriModel kategori;
  final WargaModel warga;
  final bool isUrgent;
  final bool canAccept;
  final bool canUpdateProgress;
  final bool canComplete;
  final bool canRequestApproval;
  final String tanggalPengaduan;
  final String? tanggalProses;
  final String createdAt;
  final String waktuRelatif;
  final String? catatanPegawai;

  PengaduanPegawaiModel({
    required this.id,
    required this.nomorPengaduan,
    required this.judul,
    required this.deskripsi,
    required this.status,
    required this.lokasi,
    this.fotoPengaduan,
    required this.kategori,
    required this.warga,
    required this.isUrgent,
    required this.canAccept,
    required this.canUpdateProgress,
    required this.canComplete,
    required this.canRequestApproval,
    required this.tanggalPengaduan,
    this.tanggalProses,
    required this.createdAt,
    required this.waktuRelatif,
    this.catatanPegawai,
  });

  // Helper untuk safe parsing int dari dynamic (bisa String atau int)
  static int _parseInt(dynamic value, [int defaultValue = 0]) {
    if (value == null) return defaultValue;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  // Helper untuk safe parsing bool dari dynamic
  static bool _parseBool(dynamic value, [bool defaultValue = false]) {
    if (value == null) return defaultValue;
    if (value is bool) return value;
    if (value is String) return value.toLowerCase() == 'true' || value == '1';
    if (value is int) return value == 1;
    return defaultValue;
  }

  factory PengaduanPegawaiModel.fromJson(Map<String, dynamic> json) {
    return PengaduanPegawaiModel(
      id: _parseInt(json['id']),
      nomorPengaduan: json['nomor_pengaduan']?.toString() ?? '',
      judul: json['judul']?.toString() ?? '',
      deskripsi: json['deskripsi']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      lokasi: json['lokasi']?.toString() ?? '',
      fotoPengaduan: json['foto_pengaduan']?.toString(),
      kategori: KategoriModel.fromJson(json['kategori'] ?? {}),
      warga: WargaModel.fromJson(json['warga'] ?? {}),
      isUrgent: _parseBool(json['is_urgent']),
      canAccept: _parseBool(json['can_accept']),
      canUpdateProgress: _parseBool(json['can_update_progress']),
      canComplete: _parseBool(json['can_complete']),
      canRequestApproval: _parseBool(json['can_request_approval']),
      tanggalPengaduan: json['tanggal_pengaduan']?.toString() ?? '',
      tanggalProses: json['tanggal_proses']?.toString(),
      createdAt: json['created_at']?.toString() ?? '',
      waktuRelatif: json['waktu_relatif']?.toString() ?? '',
      catatanPegawai: json['catatan_pegawai']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nomor_pengaduan': nomorPengaduan,
      'judul': judul,
      'deskripsi': deskripsi,
      'status': status,
      'lokasi': lokasi,
      'foto_pengaduan': fotoPengaduan,
      'kategori': kategori.toJson(),
      'warga': warga.toJson(),
      'is_urgent': isUrgent,
      'can_accept': canAccept,
      'can_update_progress': canUpdateProgress,
      'can_complete': canComplete,
      'can_request_approval': canRequestApproval,
      'tanggal_pengaduan': tanggalPengaduan,
      'tanggal_proses': tanggalProses,
      'created_at': createdAt,
      'waktu_relatif': waktuRelatif,
      'catatan_pegawai': catatanPegawai,
    };
  }
} 