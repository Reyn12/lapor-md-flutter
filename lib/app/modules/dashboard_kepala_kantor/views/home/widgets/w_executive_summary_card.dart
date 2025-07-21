import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/dashboard_kepala_kantor_controller.dart';

class WExecutiveSummaryCard extends StatelessWidget {
  const WExecutiveSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardKepalaKantorController>();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
                    color: Color(0xFF9C27B0),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.analytics_outlined,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Executive Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.grey[700]?.withOpacity(0.5), thickness: 1),
            // Grid Cards
            Obx(() {
              final executiveData = controller.executiveSummaryData.value;
              if (executiveData == null) {
                return const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5,
                children: [
                  // Card 1: Total Pengaduan Bulan Ini
                  _buildSummaryCard(
                    title: 'Total Pengaduan\nBulan Ini',
                    value: '${executiveData.totalPengaduanBulanIni}',
                    color: const Color(0xFF2196F3), // Blue
                  ),

                  // Card 2: Tingkat Penyelesaian
                  _buildSummaryCard(
                    title: 'Tingkat Penyelesaian',
                    value:
                        '${executiveData.tingkatPenyelesaian.toStringAsFixed(0)}%',
                    color: const Color(0xFF4CAF50), // Green
                  ),

                  // Card 3: Rata-rata Waktu Proses
                  _buildSummaryCard(
                    title: 'Rata-rata Waktu\nProses (hari)',
                    value: '${executiveData.rataRataWaktuProses}.0',
                    color: const Color(0xFFFF9800), // Orange
                  ),

                  // Card 4: Trending Kategori
                  _buildSummaryCard(
                    title: 'Trending Kategori',
                    value: executiveData.kategoriTrending.nama,
                    color: const Color(0xFF9C27B0), // Purple
                    isCategory: true,
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required Color color,
    bool isCategory = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isCategory) ...[
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ] else ...[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
          Text(
            isCategory ? value : title,
            style: TextStyle(
              color: Colors.white,
              fontSize: isCategory ? 12 : 12,
              fontWeight: isCategory ? FontWeight.w600 : FontWeight.w500,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
