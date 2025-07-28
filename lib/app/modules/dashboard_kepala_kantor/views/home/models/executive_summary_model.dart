class KategoriTrendingModel {
  final String nama;
  final int total;

  KategoriTrendingModel({required this.nama, required this.total});

  factory KategoriTrendingModel.fromJson(Map<String, dynamic> json) {
    return KategoriTrendingModel(
      nama: json['nama'] ?? '',
      total: _parseToInt(json['total']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'nama': nama, 'total': total};
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
      totalPengaduanBulanIni: _parseToInt(json['total_pengaduan_bulan_ini']),
      tingkatPenyelesaian: (json['tingkat_penyelesaian'] ?? 0).toDouble(),
      rataRataWaktuProses: _parseToInt(json['rata_rata_waktu_proses']),
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

// Helper function untuk parse ke int
int _parseToInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is String) {
    return int.tryParse(value) ?? 0;
  }
  return 0;
}
