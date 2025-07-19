class KategoriModel {
  final int id;
  final String namaKategori;

  KategoriModel({
    required this.id,
    required this.namaKategori,
  });

  // Helper untuk safe parsing int dari dynamic (bisa String atau int)
  static int _parseInt(dynamic value, [int defaultValue = 0]) {
    if (value == null) return defaultValue;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  factory KategoriModel.fromJson(Map<String, dynamic> json) {
    return KategoriModel(
      id: _parseInt(json['id']),
      namaKategori: json['nama_kategori']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_kategori': namaKategori,
    };
  }
} 