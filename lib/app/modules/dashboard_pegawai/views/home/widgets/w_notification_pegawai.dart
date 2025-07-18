import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/dashboard_pegawai_controller.dart';

class WNotificationPegawai extends StatelessWidget {
  final DashboardPegawaiController controller;
  
  const WNotificationPegawai({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final unreadCount = controller.recentNotifikasi
          .where((notif) => !(notif['isRead'] as bool))
          .length;
      
      return GestureDetector(
        onTap: () {
          // Navigasi ke halaman notifikasi (belum ada, bisa tambah nanti)
          
        },
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
                size: 24,
              ),
            ),
            if (unreadCount > 0)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFF10B981), // Green theme untuk pegawai
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  child: Text(
                    unreadCount > 99 ? '99+' : unreadCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
} 