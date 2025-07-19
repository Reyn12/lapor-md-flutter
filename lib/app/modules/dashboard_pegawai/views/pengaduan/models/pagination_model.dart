class PaginationModel {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int perPage;

  PaginationModel({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.perPage,
  });

  // Helper untuk safe parsing int dari dynamic (bisa String atau int)
  static int _parseInt(dynamic value, [int defaultValue = 0]) {
    if (value == null) return defaultValue;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      currentPage: _parseInt(json['current_page'], 1),
      totalPages: _parseInt(json['total_pages'], 1),
      totalItems: _parseInt(json['total_items']),
      perPage: _parseInt(json['per_page'], 10),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'total_pages': totalPages,
      'total_items': totalItems,
      'per_page': perPage,
    };
  }
} 