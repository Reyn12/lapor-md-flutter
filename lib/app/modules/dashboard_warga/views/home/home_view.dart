import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lapor_md/app/modules/dashboard_warga/controllers/dashboard_warga_controller.dart';
import 'widgets/w_header.dart';
import 'widgets/w_welcome_banner.dart';
import 'widgets/w_statistic.dart';
import 'widgets/w_buat_pengaduan.dart';
import 'widgets/w_recent_pengaduan.dart';

class HomeView extends GetView<DashboardWargaController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom Header
          HeaderWidget(controller: controller),
          // Content
          Expanded(
            child: Container(
              color: Colors.grey[50],
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Welcome Banner
                    WelcomeBannerWidget(controller: controller),
                    // Statistics Cards
                    StatisticWidget(controller: controller),
                    const SizedBox(height: 16),
                    // Create Pengaduan Button
                    const WBuatPengaduan(),
                    const SizedBox(height: 16),
                    // Recent Pengaduan
                    WRecentPengaduan(controller: controller),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}