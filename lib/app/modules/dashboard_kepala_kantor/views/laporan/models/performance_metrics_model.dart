class PerformanceMetricsModel {
  final double tingkatEfisiensi;
  final double waktuRespon;
  final double skorKepuasan;

  PerformanceMetricsModel({
    required this.tingkatEfisiensi,
    required this.waktuRespon,
    required this.skorKepuasan,
  });

  factory PerformanceMetricsModel.fromJson(Map<String, dynamic> json) {
    return PerformanceMetricsModel(
      tingkatEfisiensi: json['tingkat_efisiensi']?.toDouble() ?? 0.0,
      waktuRespon: json['waktu_respon']?.toDouble() ?? 0.0,
      skorKepuasan: json['skor_kepuasan']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tingkat_efisiensi': tingkatEfisiensi,
      'waktu_respon': waktuRespon,
      'skor_kepuasan': skorKepuasan,
    };
  }
}