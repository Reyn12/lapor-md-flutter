import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/dashboard_kepala_kantor_controller.dart';

class MonitoringKepalaKantorView extends StatelessWidget {
  const MonitoringKepalaKantorView({super.key});

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


              ],
            ),
          ),

          // Content
          Expanded(
            child: Obx(() {
              if (controller.isLoadingMonitoring.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const Center(
                child: Text(
                  'Monitoring Kepala Kantor Content',
                  style: TextStyle(fontSize: 20),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}