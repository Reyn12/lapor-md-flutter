import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/dashboard_kepala_kantor_controller.dart';

class WGrafikCard extends StatelessWidget {
  const WGrafikCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardKepalaKantorController>();

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header dengan ikon
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2196F3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.bar_chart,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Grafik Pengaduan per Bulan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 16),
            
            // Bar Chart
            Obx(() {
              final grafikData = controller.grafikBulananData;
              if (grafikData.isEmpty) {
                return const SizedBox(
                  height: 200,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              
              // Cari nilai maksimum untuk scaling
              final maxValue = grafikData
                  .map((item) => item.total)
                  .reduce((a, b) => a > b ? a : b)
                  .toDouble();
              
              return Column(
                children: grafikData.map((item) {
                  return _buildBarItem(
                    bulan: item.bulanSingkat,
                    total: item.total,
                    maxValue: maxValue,
                  );
                }).toList(),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildBarItem({
    required String bulan,
    required int total,
    required double maxValue,
  }) {
    // Hitung persentase untuk lebar bar
    final percentage = maxValue > 0 ? (total / maxValue) : 0.0;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          // Label bulan
          SizedBox(
            width: 40,
            child: Text(
              bulan,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 12),
          
          // Bar container
          Expanded(
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF2196F3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          
          // Angka total
          SizedBox(
            width: 30,
            child: Text(
              '$total',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}