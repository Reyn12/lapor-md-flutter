import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lapor_md/app/modules/dashboard_warga/controllers/dashboard_warga_controller.dart';
import 'widgets/w_header.dart';

class NotifikasiView extends StatelessWidget {
  const NotifikasiView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardWargaController>();
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Header
          const WHeader(),
          
          // Content
          Expanded(
            child: Obx(() {
              if (controller.isLoadingNotifikasi.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              
              final notifikasiList = controller.notifikasiList;
              
              if (notifikasiList.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notifications_off_outlined,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Belum ada notifikasi',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Notifikasi akan muncul ketika ada update pengaduan',
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
                onRefresh: () => controller.fetchNotifikasiData(),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: notifikasiList.length,
                  itemBuilder: (context, index) {
                    final notifikasi = notifikasiList[index];
                    
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            // Left Border dengan warna status
                            Container(
                              width: 4,
                              decoration: BoxDecoration(
                                color: notifikasi.pengaduan != null 
                                    ? _getStatusColor(notifikasi.pengaduan!.status)
                                    : Colors.grey,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                ),
                              ),
                            ),
                            // Content
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Header dengan icon dan status
                                    Row(
                                      children: [
                                        // Status Icon
                                        Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: notifikasi.pengaduan != null
                                                ? _getStatusColor(notifikasi.pengaduan!.status).withOpacity(0.1)
                                                : Colors.grey.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Icon(
                                            notifikasi.pengaduan != null
                                                ? _getStatusIcon(notifikasi.pengaduan!.status)
                                                : Icons.notifications,
                                            color: notifikasi.pengaduan != null
                                                ? _getStatusColor(notifikasi.pengaduan!.status)
                                                : Colors.grey,
                                            size: 16,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        // Judul
                                        Expanded(
                                          child: Text(
                                            notifikasi.judul,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                        ),
                                        // Badge unread
                                        if (!notifikasi.isRead)
                                          Container(
                                            width: 8,
                                            height: 8,
                                            decoration: const BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    // Pesan
                                    Text(
                                      notifikasi.pesan,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[600],
                                        height: 1.4,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    // Bottom info
                                    Text(
                                      notifikasi.waktuRelatif,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[500],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'selesai':
        return const Color(0xFF22C55E); // Green
      case 'diproses':
        return const Color(0xFFF59E0B); // Orange  
      case 'diterima':
        return const Color(0xFF3B82F6); // Blue
      case 'ditolak':
        return const Color(0xFFEF4444); // Red
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'selesai':
        return Icons.check_circle;
      case 'diproses':
        return Icons.schedule;
      case 'diterima':
        return Icons.info;
      case 'ditolak':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }
}