import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/dashboard_pegawai_controller.dart';
import 'widgets/w_notification_pegawai.dart';

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
              
              return const Center(
                child: Text(
                  'Home Pegawai - Coming Soon',
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
