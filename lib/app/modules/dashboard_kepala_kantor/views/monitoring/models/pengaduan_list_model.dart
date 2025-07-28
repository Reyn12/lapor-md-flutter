import 'dart:convert';

MonitoringResponseModel monitoringResponseModelFromJson(String str) =>
    MonitoringResponseModel.fromJson(json.decode(str));

class MonitoringResponseModel {
  final bool success;
  final MonitoringData data;

  MonitoringResponseModel({
    required this.success,
    required this.data,
  });

  factory MonitoringResponseModel.fromJson(Map<String, dynamic> json) =>
      MonitoringResponseModel(
        success: json['success'] ?? false,
        data: MonitoringData.fromJson(json['data'] ?? {}),
      );
}

class MonitoringData {
  final RealTimeStats realTimeStats;
  final List<MonitoringPengaduan> pengaduanList;
  final PaginationInfo pagination;

  MonitoringData({
    required this.realTimeStats,
    required this.pengaduanList,
    required this.pagination,
  });

  factory MonitoringData.fromJson(Map<String, dynamic> json) => MonitoringData(
        realTimeStats: RealTimeStats.fromJson(json['real_time_stats'] ?? {}),
        pengaduanList: json['pengaduan_list'] != null
            ? List<MonitoringPengaduan>.from(
                json['pengaduan_list'].map(
                  (x) => MonitoringPengaduan.fromJson(x),
                ),
              )
            : [],
        pagination: PaginationInfo.fromJson(json['pagination'] ?? {}),
      );
}

class RealTimeStats {
  final int totalPengaduanAllTime;
  final int pengaduanAktif;
  final int performancePegawai;

  RealTimeStats({
    required this.totalPengaduanAllTime,
    required this.pengaduanAktif,
    required this.performancePegawai,
  });

  factory RealTimeStats.fromJson(Map<String, dynamic> json) => RealTimeStats(
        totalPengaduanAllTime: (json['total_pengaduan_all_time'] ?? 0) is int
            ? json['total_pengaduan_all_time']
            : (json['total_pengaduan_all_time'] ?? 0).toDouble().toInt(),
        pengaduanAktif: (json['pengaduan_aktif'] ?? 0) is int
            ? json['pengaduan_aktif']
            : (json['pengaduan_aktif'] ?? 0).toDouble().toInt(),
        performancePegawai: (json['performance_pegawai'] ?? 0) is int
            ? json['performance_pegawai']
            : (json['performance_pegawai'] ?? 0).toDouble().toInt(),
      );
}

class MonitoringPengaduan {
  final int id;
  final String nomorPengaduan;
  final String judul;
  final String status;
  final String prioritas;
  final String kategori;
  final String wargaNama;
  final String? pegawaiNama;
  final String lokasi;
  final DateTime tanggalPengaduan;
  final PengaduanProgress progress;
  final DateTime createdAt;

  MonitoringPengaduan({
    required this.id,
    required this.nomorPengaduan,
    required this.judul,
    required this.status,
    required this.prioritas,
    required this.kategori,
    required this.wargaNama,
    this.pegawaiNama,
    required this.lokasi,
    required this.tanggalPengaduan,
    required this.progress,
    required this.createdAt,
  });

  factory MonitoringPengaduan.fromJson(Map<String, dynamic> json) =>
      MonitoringPengaduan(
        id: (json['id'] ?? 0) is int ? json['id'] : (json['id'] ?? 0).toDouble().toInt(),
        nomorPengaduan: json['nomor_pengaduan'] ?? '',
        judul: json['judul'] ?? '',
        status: json['status'] ?? '',
        prioritas: json['prioritas'] ?? '',
        kategori: json['kategori'] ?? '',
        wargaNama: json['warga_nama'] ?? '',
        pegawaiNama: json['pegawai_nama'],
        lokasi: json['lokasi'] ?? '',
        tanggalPengaduan: json['tanggal_pengaduan'] != null
            ? DateTime.parse(json['tanggal_pengaduan'])
            : DateTime.now(),
        progress: PengaduanProgress.fromJson(json['progress'] ?? {}),
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : DateTime.now(),
      );
}

class PengaduanProgress {
  final int persentase;
  final String statusText;

  PengaduanProgress({
    required this.persentase,
    required this.statusText,
  });

  factory PengaduanProgress.fromJson(Map<String, dynamic> json) =>
      PengaduanProgress(
        persentase: (json['persentase'] ?? 0) is int ? json['persentase'] : (json['persentase'] ?? 0).toDouble().toInt(),
        statusText: json['status_text'] ?? '',
      );
}

class PaginationInfo {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int perPage;

  PaginationInfo({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.perPage,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) => PaginationInfo(
        currentPage: (json['current_page'] ?? 1) is int ? json['current_page'] : (json['current_page'] ?? 1).toDouble().toInt(),
        totalPages: (json['total_pages'] ?? 1) is int ? json['total_pages'] : (json['total_pages'] ?? 1).toDouble().toInt(),
        totalItems: (json['total_items'] ?? 0) is int ? json['total_items'] : (json['total_items'] ?? 0).toDouble().toInt(),
        perPage: (json['per_page'] ?? 10) is int ? json['per_page'] : (json['per_page'] ?? 10).toDouble().toInt(),
      );
}