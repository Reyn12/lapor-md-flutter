import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_kepala_kantor_controller.dart';

class DashboardKepalaKantorView
    extends GetView<DashboardKepalaKantorController> {
  const DashboardKepalaKantorView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashboardKepalaKantorView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DashboardKepalaKantorView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
