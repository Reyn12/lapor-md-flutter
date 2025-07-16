class StatisticsModel {
  final int total;
  final int menunggu;
  final int diproses;
  final int selesai;

  StatisticsModel({
    required this.total,
    required this.menunggu,
    required this.diproses,
    required this.selesai,
  });

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    return StatisticsModel(
      total: json['total'] ?? 0,
      menunggu: json['menunggu'] ?? 0,
      diproses: json['diproses'] ?? 0,
      selesai: json['selesai'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'menunggu': menunggu,
      'diproses': diproses,
      'selesai': selesai,
    };
  }
}
