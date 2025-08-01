import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:lapor_md/app/modules/dashboard_warga/views/notifikasi/notifikasi_view.dart';
import 'package:lapor_md/app/modules/dashboard_warga/views/profile/profile_view.dart';
import 'package:lapor_md/app/modules/dashboard_warga/views/riwayat/riwayat_view.dart';
import 'package:lapor_md/app/modules/dashboard_warga/views/home/home_view.dart';
import '../controllers/dashboard_warga_controller.dart';

class DashboardWargaView extends GetView<DashboardWargaController> {
  const DashboardWargaView({super.key});
  
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
        return const HomeView();
      case 1:
        return const RiwayatView();
      case 2:
        return const NotifikasiView();
      case 3:
        return const ProfileView();
      default:
        return const Center(
          child: Text('Halaman tidak ditemukan'),
        );
    }
  }
}
