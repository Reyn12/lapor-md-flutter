import 'performance_metrics_model.dart';
import 'trend_analysis_model.dart';

class LaporanModel {
  final PerformanceMetricsModel performanceMetrics;
  final TrendAnalysisModel trendAnalysis;

  LaporanModel({
    required this.performanceMetrics,
    required this.trendAnalysis,
  });

  factory LaporanModel.fromJson(Map<String, dynamic> json) {
    return LaporanModel(
      performanceMetrics: PerformanceMetricsModel.fromJson(json['performance_metrics'] ?? {}),
      trendAnalysis: TrendAnalysisModel.fromJson(json['trend_analysis'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'performance_metrics': performanceMetrics.toJson(),
      'trend_analysis': trendAnalysis.toJson(),
    };
  }
}
