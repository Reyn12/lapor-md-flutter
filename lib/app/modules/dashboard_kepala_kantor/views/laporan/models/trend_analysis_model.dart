class TrendModel {
  final double persentase;
  final String trend;

  TrendModel({
    required this.persentase,
    required this.trend,
  });

  factory TrendModel.fromJson(Map<String, dynamic> json) {
    return TrendModel(
      persentase: json['persentase']?.toDouble() ?? 0.0,
      trend: json['trend'] ?? 'stabil',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'persentase': persentase,
      'trend': trend,
    };
  }
}

class TrendAnalysisModel {
  final TrendModel trendVolume;
  final TrendModel trendPenyelesaian;
  final TrendModel trendEfisiensiBiaya;

  TrendAnalysisModel({
    required this.trendVolume,
    required this.trendPenyelesaian,
    required this.trendEfisiensiBiaya,
  });

  factory TrendAnalysisModel.fromJson(Map<String, dynamic> json) {
    return TrendAnalysisModel(
      trendVolume: TrendModel.fromJson(json['trend_volume'] ?? {}),
      trendPenyelesaian: TrendModel.fromJson(json['trend_penyelesaian'] ?? {}),
      trendEfisiensiBiaya: TrendModel.fromJson(json['trend_efisiensi_biaya'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trend_volume': trendVolume.toJson(),
      'trend_penyelesaian': trendPenyelesaian.toJson(),
      'trend_efisiensi_biaya': trendEfisiensiBiaya.toJson(),
    };
  }
}