import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'home/home_pegawai_view.dart';
import 'pengaduan/pengaduan_pegawai_view.dart';
import 'profile/profile_pegawai_view.dart';
import '../controllers/dashboard_pegawai_controller.dart';

class DashboardPegawaiView extends GetView<DashboardPegawaiController> {
  const DashboardPegawaiView({super.key});
  
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
          style: TabStyle.react,
          backgroundColor: const Color(0xFF1E293B), // Dark blue-gray
          activeColor: const Color(0xFF10B981), // Green
          color: Colors.grey[400],
          items: const [
            TabItem(icon: Icons.dashboard, title: 'Home'),
            TabItem(icon: Icons.inbox_outlined, title: 'Pengaduan'),
            TabItem(icon: Icons.account_circle, title: 'Profile'),
          ],
          initialActiveIndex: 0,
          onTap: (int index) => controller.changePage(index),
          height: 65,
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
        return const HomePegawaiView();
      case 1:
        return const PengaduanPegawaiView();
      case 2:
        return const ProfilePegawaiView();
      default:
        return const Center(
          child: Text('Halaman tidak ditemukan'),
        );
    }
  }
}
