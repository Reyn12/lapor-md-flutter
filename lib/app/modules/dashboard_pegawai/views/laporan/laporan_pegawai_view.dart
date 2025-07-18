import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/dashboard_pegawai_controller.dart';

class LaporanPegawaiView extends StatelessWidget {
  const LaporanPegawaiView({super.key});

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
                  'Laporan Pegawai',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Kelola laporan pengaduan',
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
            child: Obx(() {
              if (controller.isLoadingLaporan.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              
              return const Center(
                child: Text(
                  'Laporan Pegawai - Coming Soon',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
