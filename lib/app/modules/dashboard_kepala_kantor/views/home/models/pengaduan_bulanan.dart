class PengaduanBulananModel {
  final String bulan;
  final int total;

  PengaduanBulananModel({
    required this.bulan,
    required this.total,
  });

  factory PengaduanBulananModel.fromJson(Map<String, dynamic> json) {
    return PengaduanBulananModel(
      bulan: json['bulan'] ?? '',
      total: json['total_pengaduan'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bulan': bulan,
      'total': total,
    };
  }

  // Helper untuk convert nama bulan singkat
  String get bulanSingkat {
    switch (bulan.toLowerCase()) {
      case 'januari':
        return 'Jan';
      case 'februari':
        return 'Feb';
      case 'maret':
        return 'Mar';
      case 'april':
        return 'Apr';
      case 'mei':
        return 'May';
      case 'juni':
        return 'Jun';
      case 'juli':
        return 'Jul';
      case 'agustus':
        return 'Aug';
      case 'september':
        return 'Sep';
      case 'oktober':
        return 'Oct';
      case 'november':
        return 'Nov';
      case 'desember':
        return 'Dec';
      default:
        return bulan.length > 3 ? bulan.substring(0, 3) : bulan;
    }
  }
}