import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lapor_md/app/modules/dashboard_warga/controllers/dashboard_warga_controller.dart';
import 'widgets/w_header.dart';

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
              child: const Center(
                child: Text('Konten Dashboard'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}