import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_pegawai_controller.dart';

class DashboardPegawaiView extends GetView<DashboardPegawaiController> {
  const DashboardPegawaiView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashboardPegawaiView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DashboardPegawaiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
