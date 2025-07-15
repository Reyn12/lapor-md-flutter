import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import '../controllers/dashboard_warga_controller.dart';

class DashboardWargaView extends GetView<DashboardWargaController> {
  const DashboardWargaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _buildPage()),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.reactCircle,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.history, title: 'Riwayat'),
          TabItem(icon: Icons.notifications, title: 'Notifikasi'),
          TabItem(icon: Icons.person, title: 'Profile'),
        ],
        initialActiveIndex: 0,
        onTap: (int index) => controller.changePage(index),
        height: 60,
      ),
    );
  }

  Widget _buildPage() {
    switch (controller.selectedIndex.value) {
      case 0:
        return const Center(
          child: Text(
            'Ini halaman Home Dashboard Warga',
            style: TextStyle(fontSize: 20),
          ),
        );
      case 1:
        return const Center(
          child: Text(
            'Ini halaman Riwayat Dashboard Warga',
            style: TextStyle(fontSize: 20),
          ),
        );
      case 2:
        return const Center(
          child: Text(
            'Ini halaman Notifikasi Dashboard Warga',
            style: TextStyle(fontSize: 20),
          ),
        );
      case 3:
        return const Center(
          child: Text(
            'Ini halaman Profile Dashboard Warga',
            style: TextStyle(fontSize: 20),
          ),
        );
      default:
        return const Center(
          child: Text('Halaman tidak ditemukan'),
        );
    }
  }
}
