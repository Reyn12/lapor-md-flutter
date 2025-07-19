class WargaModel {
  final int id;
  final String nama;

  WargaModel({
    required this.id,
    required this.nama,
  });

  // Helper untuk safe parsing int dari dynamic (bisa String atau int)
  static int _parseInt(dynamic value, [int defaultValue = 0]) {
    if (value == null) return defaultValue;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  factory WargaModel.fromJson(Map<String, dynamic> json) {
    return WargaModel(
      id: _parseInt(json['id']),
      nama: json['nama']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
    };
  }
} 