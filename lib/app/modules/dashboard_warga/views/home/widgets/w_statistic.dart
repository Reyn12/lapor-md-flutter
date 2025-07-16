import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lapor_md/app/modules/dashboard_warga/controllers/dashboard_warga_controller.dart';

class StatisticWidget extends StatelessWidget {
  final DashboardWargaController controller;
  
  const StatisticWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Obx(() {
        final stats = controller.statistics.value;
        
        if (controller.isLoadingHome.value) {
          return _buildLoadingCards();
        }
        
        if (stats == null) {
          return _buildEmptyCards();
        }
        
        return Row(
          children: [
            // Total Card
            Expanded(
              child: _buildStatCard(
                title: 'Total',
                value: stats.total.toString(),
                color: const Color(0xFF4F46E5), // Indigo
                icon: Icons.assessment,
              ),
            ),
            const SizedBox(width: 12),
            // Menunggu Card
            Expanded(
              child: _buildStatCard(
                title: 'Menunggu',
                value: stats.menunggu.toString(),
                color: const Color(0xFFF59E0B), // Orange
                icon: Icons.pending,
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
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Value
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Title
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
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
        const SizedBox(width: 12),
        Expanded(child: _buildLoadingCard()),
      ],
    );
  }

  Widget _buildLoadingCard() {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
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
            title: 'Total',
            value: '0',
            color: const Color(0xFF4F46E5),
            icon: Icons.assessment,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            title: 'Menunggu',
            value: '0',
            color: const Color(0xFFF59E0B),
            icon: Icons.pending,
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
