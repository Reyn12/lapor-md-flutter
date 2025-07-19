import 'package:flutter/material.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/views/home/models/statistic_pegawai_model.dart';

class WStatisticPegawaiCard extends StatelessWidget {
  final StatisticPegawaiModel statistics;

  const WStatisticPegawaiCard({
    super.key,
    required this.statistics,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Pengaduan Masuk
          Expanded(
            child: _buildStatCard(
              icon: Icons.warning,
              count: statistics.pengaduanMasuk,
              title: 'Pengaduan\nMasuk',
              color: const Color(0xFFE53E3E), // Red
            ),
          ),
          const SizedBox(width: 12),
          
          // Sedang Diproses
          Expanded(
            child: _buildStatCard(
              icon: Icons.access_time,
              count: statistics.sedangDiproses,
              title: 'Sedang\nDiproses',
              color: const Color(0xFFFF8A00), // Orange
            ),
          ),
          const SizedBox(width: 12),
          
          // Selesai Hari Ini
          Expanded(
            child: _buildStatCard(
              icon: Icons.check_circle,
              count: statistics.selesaiHariIni,
              title: 'Selesai Hari\nIni',
              color: const Color(0xFF38A169), // Green
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required int count,
    required String title,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 28,
          ),
          const SizedBox(height: 8),
          Text(
            count.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
