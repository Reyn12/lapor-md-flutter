class CurrentFilterModel {
  final String status;
  final String search;
  final int? kategoriId;
  final String? prioritas;
  final String? tanggalDari;
  final String? tanggalSampai;

  CurrentFilterModel({
    required this.status,
    required this.search,
    this.kategoriId,
    this.prioritas,
    this.tanggalDari,
    this.tanggalSampai,
  });

  // Helper untuk safe parsing nullable int dari dynamic
  static int? _parseNullableInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  factory CurrentFilterModel.fromJson(Map<String, dynamic> json) {
    return CurrentFilterModel(
      status: json['status']?.toString() ?? '',
      search: json['search']?.toString() ?? '',
      kategoriId: _parseNullableInt(json['kategori_id']),
      prioritas: json['prioritas']?.toString(),
      tanggalDari: json['tanggal_dari']?.toString(),
      tanggalSampai: json['tanggal_sampai']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'search': search,
      'kategori_id': kategoriId,
      'prioritas': prioritas,
      'tanggal_dari': tanggalDari,
      'tanggal_sampai': tanggalSampai,
    };
  }
} 