import 'package:get/get.dart';

import '../controllers/dashboard_pegawai_controller.dart';

class DashboardPegawaiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardPegawaiController>(
      () => DashboardPegawaiController(),
    );
  }
}
