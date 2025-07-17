import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lapor_md/app/modules/dashboard_warga/controllers/dashboard_warga_controller.dart';
import 'package:lapor_md/app/modules/dashboard_warga/views/riwayat/widgets/w_status.dart';
import 'package:lapor_md/app/modules/dashboard_warga/views/riwayat/widgets/w_statistic.dart';
import 'package:lapor_md/app/modules/dashboard_warga/views/riwayat/widgets/w_riwayat_pengaduan_card.dart';

class RiwayatView extends StatelessWidget {
  const RiwayatView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardWargaController>();
    final selectedStatus = 'semua'.obs;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: 16),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF6366F1), // Indigo
                  Color(0xFF8B5CF6), // Purple
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6366F1).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  // History Icon
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.history,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Text Content
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Riwayat Pengaduan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Lihat semua pengaduan yang pernah kamu buat',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Status Filter
          Obx(() => StatusWidget(
            selectedStatus: selectedStatus.value,
            onStatusChanged: (status) {
              selectedStatus.value = status;
              // Hit API dengan status baru
              controller.fetchRiwayatData(status: status);
            },
          )),
          
          const SizedBox(height: 16),
          
          // Conditional Statistic Card (only for "semua" dan ada statistics)
          Obx(() {
            if (selectedStatus.value == 'semua' && controller.riwayatStatistics.value != null) {
              return Column(
                children: [
                  RiwayatStatisticWidget(controller: controller),
                  const SizedBox(height: 16),
                ],
              );
            }
            return const SizedBox.shrink();
          }),
          
          // List Pengaduan
          Expanded(
            child: Obx(() {
              if (controller.isLoadingRiwayat.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              
              final pengaduanList = controller.riwayatList;
              
              if (pengaduanList.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inbox_outlined,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Belum ada pengaduan',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        selectedStatus.value == 'semua' 
                            ? 'Kamu belum pernah membuat pengaduan'
                            : 'Belum ada pengaduan dengan status ${selectedStatus.value}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }
              
              return RefreshIndicator(
                onRefresh: () => controller.fetchRiwayatData(status: selectedStatus.value),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: pengaduanList.length,
                  itemBuilder: (context, index) {
                    final pengaduan = pengaduanList[index];
                    return RiwayatPengaduanCard(
                      pengaduan: pengaduan,
                      // Hapus onTap custom, biar pakai default navigation ke detail
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}