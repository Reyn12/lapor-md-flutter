class PengaduanPrioritasModel {
  final int id;
  final String nomorPengaduan;
  final String judul;
  final String status;
  final String kategori;
  final String wargaNama;
  final String lokasi;
  final bool isUrgent;
  final String createdAt;
  final String waktuRelatif;

  PengaduanPrioritasModel({
    required this.id,
    required this.nomorPengaduan,
    required this.judul,
    required this.status,
    required this.kategori,
    required this.wargaNama,
    required this.lokasi,
    required this.isUrgent,
    required this.createdAt,
    required this.waktuRelatif,
  });

  factory PengaduanPrioritasModel.fromJson(Map<String, dynamic> json) {
    return PengaduanPrioritasModel(
      id: json['id'] ?? 0,
      nomorPengaduan: json['nomor_pengaduan'] ?? '',
      judul: json['judul'] ?? '',
      status: json['status'] ?? '',
      kategori: json['kategori'] ?? '',
      wargaNama: json['warga_nama'] ?? '',
      lokasi: json['lokasi'] ?? '',
      isUrgent: json['is_urgent'] ?? false,
      createdAt: json['created_at'] ?? '',
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
      'is_urgent': isUrgent,
      'created_at': createdAt,
      'waktu_relatif': waktuRelatif,
    };
  }

  // Helper method untuk format nomor pengaduan
  String get nomorPendek {
    // Ambil 3 digit terakhir dari nomor pengaduan
    final parts = nomorPengaduan.split('-');
    if (parts.length >= 3) {
      return '#${parts.last}';
    }
    return '#${id.toString().padLeft(3, '0')}';
  }

  // Helper method untuk format tanggal
  String get tanggalFormat {
    try {
      final dateTime = DateTime.parse(createdAt);
      return '${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year}';
    } catch (e) {
      return waktuRelatif;
    }
  }

  // Helper method untuk warna status
  String get statusColor {
    switch (status.toLowerCase()) {
      case 'menunggu':
        return 'red';
      case 'diproses':
        return 'orange';
      case 'selesai':
        return 'green';
      default:
        return 'grey';
    }
  }
} 