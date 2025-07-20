import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'home/home_kepala_kantor_view.dart';
import 'approval/approval_kepala_kantor_view.dart';
import 'laporan/laporan_kepala_kantor_view.dart';
import 'monitoring/monitoring_kepala_kantor_view.dart';
import 'profile/profile_kepala_kantor_view.dart';
import '../controllers/dashboard_kepala_kantor_controller.dart';

class DashboardKepalaKantorView extends GetView<DashboardKepalaKantorController> {
  const DashboardKepalaKantorView({super.key});
  
  // Tambah GlobalKey untuk ConvexAppBar
  static final GlobalKey<ConvexAppBarState> _appBarKey = GlobalKey<ConvexAppBarState>();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Obx(() => _buildPage()),
        bottomNavigationBar: ConvexAppBar(
          key: _appBarKey, // Tambah key ini
          style: TabStyle.fixedCircle,
          backgroundColor: const Color(0xFF2196F3), // Blue
          activeColor: const Color(0xFFF59E0B), // Amber/Orange
          color: Colors.grey[300],
          items: const [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.check_circle_outline, title: 'Approval'),
            TabItem(icon: Icons.assessment, title: 'Laporan'),
            TabItem(icon: Icons.monitor, title: 'Monitor'),
            TabItem(icon: Icons.account_circle, title: 'Profile'),
          ],
          initialActiveIndex: 0,
          onTap: (int index) => controller.changePage(index),
          height: 70,
        ),
      ),
    );
  }

  // Tambah static method untuk access dari luar
  static void animateToIndex(int index) {
    _appBarKey.currentState?.animateTo(index);
  }

  Widget _buildPage() {
    switch (controller.selectedIndex.value) {
      case 0:
        return const HomeKepalaKantorView();
      case 1:
        return const ApprovalKepalaKantorView();
      case 2:
        return const LaporanKepalaKantorView();
      case 3:
        return const MonitoringKepalaKantorView();
      case 4:
        return const ProfileKepalaKantorView();
      default:
        return const Center(
          child: Text('Halaman tidak ditemukan'),
        );
    }
  }
}
