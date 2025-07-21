import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/dashboard_kepala_kantor_controller.dart';
import 'models/pengaduan_list_model.dart';
import 'widgets/w_list_pengaduan_card.dart';

class MonitoringKepalaKantorView extends StatelessWidget {
  const MonitoringKepalaKantorView({super.key});

  // Widget untuk menampilkan section stats cards
  Widget _buildStatsSection(RealTimeStats stats) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Statistik Real-Time',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Total Pengaduan
              _buildStatCard(
                'Total Pengaduan',
                '${stats.totalPengaduanAllTime}',
                Colors.blue,
                Icons.analytics,
              ),
              // Pengaduan Aktif
              _buildStatCard(
                'Pengaduan Aktif',
                '${stats.pengaduanAktif}',
                Colors.orange,
                Icons.pending_actions,
              ),
              // Performance
              _buildStatCard(
                'Performance',
                '${stats.performancePegawai}%',
                Colors.green,
                Icons.trending_up,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget untuk card statistik
  Widget _buildStatCard(
    String title,
    String value,
    Color color,
    IconData icon,
  ) {
    // Tentukan warna untuk gradient
    Color gradientStartColor = color;
    Color gradientEndColor = color.withOpacity(0.7);
    
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [gradientStartColor, gradientEndColor],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardKepalaKantorController>();

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
                  Color(0xFF2196F3), // Blue
                  Color(0xFF1976D2), // Darker Blue
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
                        'Monitoring Kepala Kantor',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Obx(
                        () => Text(
                          'Selamat datang, ${controller.userName.value}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: Obx(() {
              if (controller.isLoadingMonitoring.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final monitoringData = controller.monitoringData.value;

              if (monitoringData == null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Data monitoring tidak tersedia',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => controller.fetchMonitoringData(),
                        child: const Text('Refresh Data'),
                      ),
                    ],
                  ),
                );
              }

              final stats = monitoringData.data.realTimeStats;
              final pengaduanList = monitoringData.data.pengaduanList;

              return RefreshIndicator(
                onRefresh: () async {
                  controller.fetchMonitoringData();
                },
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // Real-time Stats Cards
                    _buildStatsSection(stats),
                    const SizedBox(height: 24),

                    // Pengaduan List Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Daftar Pengaduan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          'Total: ${monitoringData.data.pagination.totalItems} pengaduan',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Pengaduan Cards
                    if (pengaduanList.isEmpty) ...[
                      SizedBox(
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.inbox, size: 48, color: Colors.grey),
                              SizedBox(height: 16),
                              Text(
                                'Tidak ada pengaduan untuk ditampilkan',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ] else ...[
                      ...pengaduanList
                          .map(
                            (pengaduan) =>
                                WListPengaduanCard(pengaduan: pengaduan),
                          )
                          .toList(),
                    ],
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
