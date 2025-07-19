class PengaduanSayaTanganiModel {
  final int id;
  final String nomorPengaduan;
  final String judul;
  final String status;
  final String kategori;
  final String wargaNama;
  final String lokasi;
  final String tanggalProses;
  final String updatedAt;
  final String waktuRelatif;

  PengaduanSayaTanganiModel({
    required this.id,
    required this.nomorPengaduan,
    required this.judul,
    required this.status,
    required this.kategori,
    required this.wargaNama,
    required this.lokasi,
    required this.tanggalProses,
    required this.updatedAt,
    required this.waktuRelatif,
  });

  factory PengaduanSayaTanganiModel.fromJson(Map<String, dynamic> json) {
    return PengaduanSayaTanganiModel(
      id: json['id'] ?? 0,
      nomorPengaduan: json['nomor_pengaduan'] ?? '',
      judul: json['judul'] ?? '',
      status: json['status'] ?? '',
      kategori: json['kategori'] ?? '',
      wargaNama: json['warga_nama'] ?? '',
      lokasi: json['lokasi'] ?? '',
      tanggalProses: json['tanggal_proses'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      waktuRelatif: json['waktu_relatif'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nomor_pengaduan': nomorPengaduan,
      'judul': judul,
      'status': status,
      'kategori': kategori,
      'warga_nama': wargaNama,
      'lokasi': lokasi,
      'tanggal_proses': tanggalProses,
      'updated_at': updatedAt,
      'waktu_relatif': waktuRelatif,
    };
  }

  // Helper method untuk format nomor pengaduan pendek
  String get nomorPendek {
    final parts = nomorPengaduan.split('-');
    if (parts.length >= 3) {
      return '#${parts.last}';
    }
    return '#${id.toString().padLeft(3, '0')}';
  }

  // Helper method untuk status label yang user-friendly
  String get statusLabel {
    switch (status.toLowerCase()) {
      case 'diproses':
        return 'sedang diproses';
      case 'selesai':
        return 'telah diselesaikan';
      case 'perlu_approval':
        return 'masuk';
      case 'menunggu':
        return 'masuk';
      default:
        return status;
    }
  }

  // Helper method untuk warna background sesuai status
  String get statusColor {
    switch (status.toLowerCase()) {
      case 'selesai':
        return 'green';
      case 'diproses':
        return 'blue';
      case 'perlu_approval':
      case 'menunggu':
        return 'red';
      default:
        return 'grey';
    }
  }
} 