import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/dashboard_pegawai_controller.dart';
import 'widgets/w_tab_status_pengaduan.dart';
import 'widgets/w_search_filter_bar.dart';
import 'widgets/w_card_list_pengaduan.dart';

class PengaduanPegawaiView extends StatelessWidget {
  const PengaduanPegawaiView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardPegawaiController>();
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 20,
              left: 20,
              right: 20,
              bottom: 24,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1E293B), // Dark blue-gray
                  Color(0xFF334155), // Slightly lighter dark gray
                ],
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pengaduan Pegawai',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Kelola pengaduan menunggu',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: Column(
              children: [
                // Tab Status Pengaduan
                Obx(() => WTabStatusPengaduan(
                  selectedStatus: controller.selectedStatus.value,
                  tabCounts: controller.pengaduanData.value?.tabCounts,
                  onTabChanged: (status) {
                    controller.changeStatusTab(status);
                  },
                )),
                
                // Search Filter Bar
                Obx(() => WSearchFilterBar(
                  searchQuery: controller.searchQuery.value,
                  selectedKategoriId: controller.selectedKategoriId.value,
                  selectedPrioritas: controller.selectedPrioritas.value,
                  tanggalDari: controller.tanggalDari.value,
                  tanggalSampai: controller.tanggalSampai.value,
                  onSearchChanged: (query) {
                    controller.updateFilter(search: query);
                  },
                  onFilterApplied: ({
                    int? kategoriId,
                    String? prioritas,
                    String? tanggalDari,
                    String? tanggalSampai,
                  }) {
                    controller.updateFilter(
                      kategoriId: kategoriId,
                      prioritas: prioritas,
                      tanggalDari: tanggalDari,
                      tanggalSampai: tanggalSampai,
                      updateKategoriId: true,
                      updatePrioritas: true,
                      updateTanggalDari: true,
                      updateTanggalSampai: true,
                    );
                  },
                )),
                
                // Content Area
                Expanded(
                  child: Obx(() {
                    if (controller.isLoadingPengaduan.value) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    
                    final pengaduanData = controller.pengaduanData.value;
                    if (pengaduanData == null) {
                      return const Center(
                        child: Text(
                          'Gagal memuat data pengaduan',
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }
                    
                    if (pengaduanData.pengaduan.isEmpty) {
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
                                                         Obx(() => Text(
                               'Tidak ada pengaduan untuk status "${controller.selectedStatus.value == 'masuk' ? 'Menunggu' : controller.selectedStatus.value}"',
                               style: const TextStyle(fontSize: 16, color: Colors.grey),
                               textAlign: TextAlign.center,
                             )),
                          ],
                        ),
                      );
                    }
                    
                    // Debug info sebelum render list
                    print('=== DEBUG RENDER LIST ===');
                    print('Current selected status: ${controller.selectedStatus.value}');
                    print('Pengaduan count: ${pengaduanData.pengaduan.length}');
                    print('Tab counts - Selesai: ${pengaduanData.tabCounts.selesai}');
                    print('==========================');
                    
                    // Special case: Jika tab "Selesai" tapi count 0, force show empty state
                    if (controller.selectedStatus.value == 'selesai' && 
                        pengaduanData.tabCounts.selesai == 0) {
                      print('FORCE EMPTY STATE for Selesai tab with 0 count');
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: 64,
                              color: Colors.green[300],
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Belum ada pengaduan yang selesai',
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }
                    
                    // List Pengaduan Cards
                    return WCardListPengaduan(
                      pengaduanList: pengaduanData.pengaduan,
                      currentStatus: controller.selectedStatus.value,
                      onDetailTap: (pengaduan) {
                        // TODO: Navigate to detail pengaduan
                        Get.snackbar(
                          'Info',
                          'Detail pengaduan ${pengaduan.nomorPengaduan}',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      onActionTap: (pengaduan, actionType) {
                        // Handle action berdasarkan action type
                        switch (actionType) {
                          case 'accept':
                            // TODO: Implement terima pengaduan
                            Get.snackbar(
                              'Info',
                              'Terima pengaduan ${pengaduan.nomorPengaduan}',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            break;
                          case 'reject':
                            // TODO: Implement tolak pengaduan
                            Get.snackbar(
                              'Info',
                              'Tolak pengaduan ${pengaduan.nomorPengaduan}',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            break;
                          case 'update_progress':
                            // TODO: Implement update progress
                            Get.snackbar(
                              'Info',
                              'Update progress ${pengaduan.nomorPengaduan}',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            break;
                          case 'complete':
                            // TODO: Implement complete pengaduan
                            Get.snackbar(
                              'Info',
                              'Selesaikan pengaduan ${pengaduan.nomorPengaduan}',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                            break;
                        }
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
