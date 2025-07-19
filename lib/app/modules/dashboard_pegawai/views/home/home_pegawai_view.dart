import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/dashboard_pegawai_controller.dart';
import 'widgets/w_notification_pegawai.dart';
import 'widgets/w_statistic_pegawai_card.dart';
import 'widgets/w_pengaduan_urgent_pegawai_card.dart';
import 'widgets/w_aktifitas_terbaru_pegawai_card.dart';
import 'widgets/w_logout_button.dart';

class HomePegawaiView extends StatelessWidget {
  const HomePegawaiView({super.key});

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title & Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Dashboard Pegawai',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Obx(() => Text(
                        'Selamat datang, ${controller.userName.value}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      )),
                    ],
                  ),
                ),

                // Notification Icon with Badge
                WNotificationPegawai(controller: controller),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: Obx(() {
              if (controller.isLoadingHome.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              
              // Tampilkan statistics card atau message jika data belum ada
              if (controller.statistics.value != null) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // Statistics Cards
                      WStatisticPegawaiCard(
                        statistics: controller.statistics.value!,
                      ),
                      
                      // Pengaduan Prioritas/Urgent
                      WPengaduanUrgentPegawaiCard(
                        pengaduanList: controller.pengaduanPrioritas,
                        onTap: (pengaduan) {
                          // TODO: Navigate to detail pengaduan
                          Get.snackbar(
                            'Info',
                            'Akan ke detail pengaduan ${pengaduan.nomorPengaduan}',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                      ),
                      
                      // Aktivitas Terbaru
                      WAktifitasTerbaruPegawaiCard(
                        aktivitasList: controller.pengaduanSayaTangani,
                        onTap: (aktivitas) {
                          // TODO: Navigate to detail pengaduan
                          Get.snackbar(
                            'Info',
                            'Akan ke detail pengaduan ${aktivitas.nomorPengaduan}',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                      ),
                      
                      // Spacing bottom
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text(
                    'Gagal memuat data statistik',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
