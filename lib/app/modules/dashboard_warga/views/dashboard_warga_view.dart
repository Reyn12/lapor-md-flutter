import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_warga_controller.dart';

class DashboardWargaView extends GetView<DashboardWargaController> {
  const DashboardWargaView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashboardWargaView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DashboardWargaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
