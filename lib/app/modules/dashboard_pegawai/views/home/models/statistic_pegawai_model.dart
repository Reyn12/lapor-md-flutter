class StatisticPegawaiModel {
  final int pengaduanMasuk;
  final int sedangDiproses;
  final int selesaiHariIni;

  StatisticPegawaiModel({
    required this.pengaduanMasuk,
    required this.sedangDiproses,
    required this.selesaiHariIni,
  });

  factory StatisticPegawaiModel.fromJson(Map<String, dynamic> json) {
    return StatisticPegawaiModel(
      pengaduanMasuk: json['pengaduan_masuk'] ?? 0,
      sedangDiproses: json['sedang_diproses'] ?? 0,
      selesaiHariIni: json['selesai_hari_ini'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pengaduan_masuk': pengaduanMasuk,
      'sedang_diproses': sedangDiproses,
      'selesai_hari_ini': selesaiHariIni,
    };
  }
}
