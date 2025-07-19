class TabCountsModel {
  final int masuk;
  final int diproses;

  TabCountsModel({
    required this.masuk,
    required this.diproses,
  });

  // Helper untuk safe parsing int dari dynamic (bisa String atau int)
  static int _parseInt(dynamic value, [int defaultValue = 0]) {
    if (value == null) return defaultValue;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  factory TabCountsModel.fromJson(Map<String, dynamic> json) {
    return TabCountsModel(
      masuk: _parseInt(json['masuk']),
      diproses: _parseInt(json['diproses']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'masuk': masuk,
      'diproses': diproses,
    };
  }
} 