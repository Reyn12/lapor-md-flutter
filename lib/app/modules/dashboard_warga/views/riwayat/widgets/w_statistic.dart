import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lapor_md/app/modules/dashboard_warga/controllers/dashboard_warga_controller.dart';

class RiwayatStatisticWidget extends StatelessWidget {
  final DashboardWargaController controller;
  
  const RiwayatStatisticWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Obx(() {
        final stats = controller.riwayatStatistics.value;
        
        if (controller.isLoadingRiwayat.value) {
          return _buildLoadingCards();
        }
        
        if (stats == null) {
          return _buildEmptyCards();
        }
        
        return Row(
          children: [
            // Total Pengaduan Card
            Expanded(
              child: _buildStatCard(
                title: 'Total Pengaduan',
                value: stats.totalPengaduan.toString(),
                color: const Color(0xFF4F46E5), // Indigo
                icon: Icons.assessment,
              ),
            ),
            const SizedBox(width: 12),
            // Selesai Card
            Expanded(
              child: _buildStatCard(
                title: 'Selesai',
                value: stats.selesai.toString(),
                color: const Color(0xFF10B981), // Green
                icon: Icons.check_circle,
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color,
            color.withOpacity(0.8),
          ],
        ),
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
        children: [
          // Icon
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(height: 8),
          // Value with white color
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          // Title
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingCards() {
    return Row(
      children: [
        Expanded(child: _buildLoadingCard()),
        const SizedBox(width: 12),
        Expanded(child: _buildLoadingCard()),
      ],
    );
  }

  Widget _buildLoadingCard() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildEmptyCards() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: 'Total Pengaduan',
            value: '0',
            color: const Color(0xFF4F46E5),
            icon: Icons.assessment,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            title: 'Selesai',
            value: '0',
            color: const Color(0xFF10B981),
            icon: Icons.check_circle,
          ),
        ),
      ],
    );
  }
} 