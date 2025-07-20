class DetailPengaduanModel {
  final int id;
  final String nomorPengaduan;
  final String judul;
  final String deskripsi;
  final String lokasi;
  final String? fotoPengaduan;
  final String status;
  final bool isUrgent;
  final String pelaporNama;
  final String kategoriNama;
  final String tanggalPengaduan;
  final bool canAccept;
  final bool canUpdateProgress;
  final bool canComplete;

  DetailPengaduanModel({
    required this.id,
    required this.nomorPengaduan,
    required this.judul,
    required this.deskripsi,
    required this.lokasi,
    this.fotoPengaduan,
    required this.status,
    required this.isUrgent,
    required this.pelaporNama,
    required this.kategoriNama,
    required this.tanggalPengaduan,
    required this.canAccept,
    required this.canUpdateProgress,
    required this.canComplete,
  });

  factory DetailPengaduanModel.fromJson(Map<String, dynamic> json) {
    return DetailPengaduanModel(
      id: json['id'] ?? 0,
      nomorPengaduan: json['nomor_pengaduan'] ?? '',
      judul: json['judul'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      lokasi: json['lokasi'] ?? '',
      fotoPengaduan: json['foto_pengaduan'],
      status: json['status'] ?? '',
      isUrgent: json['is_urgent'] ?? false,
      pelaporNama: json['pelapor_nama'] ?? '',
      kategoriNama: json['kategori_nama'] ?? '',
      tanggalPengaduan: json['tanggal_pengaduan'] ?? '',
      canAccept: json['can_accept'] ?? false,
      canUpdateProgress: json['can_update_progress'] ?? false,
      canComplete: json['can_complete'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nomor_pengaduan': nomorPengaduan,
      'judul': judul,
      'deskripsi': deskripsi,
      'lokasi': lokasi,
      'foto_pengaduan': fotoPengaduan,
      'status': status,
      'is_urgent': isUrgent,
      'pelapor_nama': pelaporNama,
      'kategori_nama': kategoriNama,
      'tanggal_pengaduan': tanggalPengaduan,
      'can_accept': canAccept,
      'can_update_progress': canUpdateProgress,
      'can_complete': canComplete,
    };
  }
}
