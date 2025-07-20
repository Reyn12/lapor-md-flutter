import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/dashboard_kepala_kantor_controller.dart';

class WBannerWelcome extends StatelessWidget {
  const WBannerWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardKepalaKantorController>();

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2196F3), // Blue
            Color(0xFF1976D2), // Darker Blue
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Selamat Datang! ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      '👋',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Obx(() {
                  final kepalaKantor = controller.kepalaKantorData.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        kepalaKantor?.nama ?? 'Kepala Kantor',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        kepalaKantor?.jabatan ?? 'Kepala Dinas Pelayanan Masyarakat',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          
          // Profile Icon/Avatar
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              size: 32,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}