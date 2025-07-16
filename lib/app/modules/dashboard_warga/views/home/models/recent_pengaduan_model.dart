class RecentPengaduanModel {
  final int id;
  final String nomorPengaduan;
  final String judul;
  final String status;
  final String kategori;
  final String createdAt;
  final String waktuRelatif;

  RecentPengaduanModel({
    required this.id,
    required this.nomorPengaduan,
    required this.judul,
    required this.status,
    required this.kategori,
    required this.createdAt,
    required this.waktuRelatif,
  });

  factory RecentPengaduanModel.fromJson(Map<String, dynamic> json) {
    return RecentPengaduanModel(
      id: json['id'] ?? 0,
      nomorPengaduan: json['nomor_pengaduan'] ?? '',
      judul: json['judul'] ?? '',
      status: json['status'] ?? '',
      kategori: json['kategori'] ?? '',
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
      'created_at': createdAt,
      'waktu_relatif': waktuRelatif,
    };
  }
}
