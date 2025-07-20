class KategoriTrendingModel {
  final String nama;
  final int total;

  KategoriTrendingModel({
    required this.nama,
    required this.total,
  });

  factory KategoriTrendingModel.fromJson(Map<String, dynamic> json) {
    return KategoriTrendingModel(
      nama: json['nama'] ?? '',
      total: json['total'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'total': total,
    };
  }
}

class ExecutiveSummaryModel {
  final int totalPengaduanBulanIni;
  final double tingkatPenyelesaian;
  final int rataRataWaktuProses;
  final KategoriTrendingModel kategoriTrending;

  ExecutiveSummaryModel({
    required this.totalPengaduanBulanIni,
    required this.tingkatPenyelesaian,
    required this.rataRataWaktuProses,
    required this.kategoriTrending,
  });

  factory ExecutiveSummaryModel.fromJson(Map<String, dynamic> json) {
    return ExecutiveSummaryModel(
      totalPengaduanBulanIni: json['total_pengaduan_bulan_ini'] ?? 0,
      tingkatPenyelesaian: (json['tingkat_penyelesaian'] ?? 0).toDouble(),
      rataRataWaktuProses: json['rata_rata_waktu_proses'] ?? 0,
      kategoriTrending: KategoriTrendingModel.fromJson(
        json['kategori_trending'] ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_pengaduan_bulan_ini': totalPengaduanBulanIni,
      'tingkat_penyelesaian': tingkatPenyelesaian,
      'rata_rata_waktu_proses': rataRataWaktuProses,
      'kategori_trending': kategoriTrending.toJson(),
    };
  }
}