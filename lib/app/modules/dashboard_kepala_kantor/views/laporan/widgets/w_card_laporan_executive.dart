import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lapor_md/app/modules/dashboard_kepala_kantor/views/laporan/models/laporan_model.dart';

class WCardLaporanExecutive extends StatelessWidget {
  final LaporanModel? laporanData;
  final bool isLoading;

  const WCardLaporanExecutive({
    Key? key,
    this.laporanData,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildLoadingCard();
    }

    if (laporanData == null) {
      return _buildErrorCard();
    }

    return Column(
      children: [
        _buildHeaderCard(),
        const SizedBox(height: 16),
        _buildTemplateLaporanSection(),
        const SizedBox(height: 24),
        _buildDashboardAnalyticsSection(),
      ],
    );
  }

  Widget _buildLoadingCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Mengambil data laporan...'),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.error_outline, color: Colors.red[400], size: 60),
          const SizedBox(height: 16),
          const Text(
            'Data laporan tidak tersedia',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Silakan coba lagi nanti',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF9C27B0), Color(0xFF6A1B9A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.description, color: Colors.white, size: 28),
          const SizedBox(width: 12),
          const Text(
            'Laporan Executive',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateLaporanSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Template Laporan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildTemplateCard(
                icon: Icons.calendar_today,
                title: 'Laporan Bulanan',
                subtitle: 'Ringkasan bulanan lengkap',
                color: Colors.purple[100]!,
                iconColor: Colors.purple,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTemplateCard(
                icon: Icons.bar_chart,
                title: 'Laporan Tahunan',
                subtitle: 'Analisis tahunan mendalam',
                color: Colors.purple[100]!,
                iconColor: Colors.purple,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTemplateCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required Color iconColor,
  }) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardAnalyticsSection() {
    final performanceMetrics = laporanData?.performanceMetrics;
    final trendAnalysis = laporanData?.trendAnalysis;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dasbor Analitik Lanjutan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Performance Metrics
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Metrik Kinerja',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildMetricRow(
                      label: 'Tingkat Efisiensi',
                      value:
                          '${performanceMetrics?.tingkatEfisiensi.toStringAsFixed(1)}%',
                      valueColor: Colors.green,
                    ),
                    const SizedBox(height: 12),
                    _buildMetricRow(
                      label: 'Waktu Respon',
                      value:
                          '${performanceMetrics?.waktuRespon.toStringAsFixed(1)} hari',
                      valueColor: Colors.blue,
                    ),
                    const SizedBox(height: 12),
                    _buildMetricRow(
                      label: 'Skor Kepuasan',
                      value:
                          '${performanceMetrics?.skorKepuasan.toStringAsFixed(1)}/5',
                      valueColor: Colors.purple,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              // Trend Analysis
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Analisis Tren',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildTrendRow(
                      label: 'Tren Volume',
                      percentage: trendAnalysis?.trendVolume.persentase ?? 0,
                      trend: trendAnalysis?.trendVolume.trend ?? 'stabil',
                    ),
                    const SizedBox(height: 12),
                    _buildTrendRow(
                      label: 'T. Penyelesaian',
                      percentage:
                          trendAnalysis?.trendPenyelesaian.persentase ?? 0,
                      trend: trendAnalysis?.trendPenyelesaian.trend ?? 'stabil',
                    ),
                    const SizedBox(height: 12),
                    _buildTrendRow(
                      label: 'Efisiensi Biaya',
                      percentage:
                          trendAnalysis?.trendEfisiensiBiaya.persentase ?? 0,
                      trend:
                          trendAnalysis?.trendEfisiensiBiaya.trend ?? 'stabil',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricRow({
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTrendRow({
    required String label,
    required double percentage,
    required String trend,
  }) {
    Color trendColor;
    IconData trendIcon;

    if (trend.toLowerCase() == 'naik') {
      trendColor = Colors.green;
      trendIcon = Icons.arrow_upward;
    } else if (trend.toLowerCase() == 'turun') {
      trendColor = Colors.red;
      trendIcon = Icons.arrow_downward;
    } else {
      trendColor = Colors.grey;
      trendIcon = Icons.remove;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        Row(
          children: [
            Icon(trendIcon, color: trendColor, size: 16),
            const SizedBox(width: 4),
            Text(
              '+${percentage.toStringAsFixed(0)}%',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: trendColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
