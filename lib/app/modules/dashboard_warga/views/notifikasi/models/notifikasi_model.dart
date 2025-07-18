class NotifikasiModel {
  final int id;
  final String judul;
  final String pesan;
  final bool isRead;
  final PengaduanNotifikasiModel? pengaduan; // Bikin nullable
  final String createdAt;
  final String waktuRelatif;

  NotifikasiModel({
    required this.id,
    required this.judul,
    required this.pesan,
    required this.isRead,
    this.pengaduan, // Nullable
    required this.createdAt,
    required this.waktuRelatif,
  });

  factory NotifikasiModel.fromJson(Map<String, dynamic> json) {
    return NotifikasiModel(
      id: json['id'] ?? 0,
      judul: json['judul'] ?? '',
      pesan: json['pesan'] ?? '',
      isRead: json['is_read'] ?? false,
      pengaduan: json['pengaduan'] != null 
          ? PengaduanNotifikasiModel.fromJson(json['pengaduan'])
          : null, // Handle null pengaduan
      createdAt: json['created_at'] ?? '',
      waktuRelatif: json['waktu_relatif'] ?? '',
    );
  }
}

class PengaduanNotifikasiModel {
  final int id;
  final String nomorPengaduan;
  final String judul;
  final String status;

  PengaduanNotifikasiModel({
    required this.id,
    required this.nomorPengaduan,
    required this.judul,
    required this.status,
  });

  factory PengaduanNotifikasiModel.fromJson(Map<String, dynamic> json) {
    return PengaduanNotifikasiModel(
      id: json['id'] ?? 0,
      nomorPengaduan: json['nomor_pengaduan'] ?? '',
      judul: json['judul'] ?? '',
      status: json['status'] ?? '',
    );
  }
}

class NotifikasiPaginationModel {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int perPage;

  NotifikasiPaginationModel({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.perPage,
  });

  factory NotifikasiPaginationModel.fromJson(Map<String, dynamic> json) {
    return NotifikasiPaginationModel(
      currentPage: json['current_page'] ?? 1,
      totalPages: json['total_pages'] ?? 1,
      totalItems: json['total_items'] ?? 0,
      perPage: json['per_page'] ?? 10,
    );
  }
}

class NotifikasiStatisticsModel {
  final int totalNotifikasi;
  final int belumDibaca;

  NotifikasiStatisticsModel({
    required this.totalNotifikasi,
    required this.belumDibaca,
  });

  factory NotifikasiStatisticsModel.fromJson(Map<String, dynamic> json) {
    return NotifikasiStatisticsModel(
      totalNotifikasi: json['total_notifikasi'] ?? 0,
      belumDibaca: json['belum_dibaca'] ?? 0,
    );
  }
}
