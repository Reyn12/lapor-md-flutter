class RecentNotifikasiModel {
  final int id;
  final String judul;
  final String pesan;
  final bool isRead;
  final String pengaduanNomor;
  final String createdAt;
  final String waktuRelatif;

  RecentNotifikasiModel({
    required this.id,
    required this.judul,
    required this.pesan,
    required this.isRead,
    required this.pengaduanNomor,
    required this.createdAt,
    required this.waktuRelatif,
  });

  factory RecentNotifikasiModel.fromJson(Map<String, dynamic> json) {
    return RecentNotifikasiModel(
      id: json['id'] ?? 0,
      judul: json['judul'] ?? '',
      pesan: json['pesan'] ?? '',
      isRead: json['is_read'] ?? false,
      pengaduanNomor: json['pengaduan_nomor'] ?? '',
      createdAt: json['created_at'] ?? '',
      waktuRelatif: json['waktu_relatif'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'judul': judul,
      'pesan': pesan,
      'is_read': isRead,
      'pengaduan_nomor': pengaduanNomor,
      'created_at': createdAt,
      'waktu_relatif': waktuRelatif,
    };
  }
}