class StatisticRiwayatDataModel {
  final int totalPengaduan;
  final int selesai;

  StatisticRiwayatDataModel({
    required this.totalPengaduan,
    required this.selesai,
  });

  factory StatisticRiwayatDataModel.fromJson(Map<String, dynamic> json) {
    return StatisticRiwayatDataModel(
      totalPengaduan: json['total_pengaduan'] ?? 0,
      selesai: json['selesai'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_pengaduan': totalPengaduan,
      'selesai': selesai,
    };
  }
}