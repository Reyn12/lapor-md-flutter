import 'package:get/get.dart';

import '../controllers/dashboard_pegawai_controller.dart';
import '../services/dashboard_pegawai_service.dart';

class DashboardPegawaiBinding extends Bindings {
  @override
  void dependencies() {
    // Inject service
    Get.lazyPut<DashboardPegawaiService>(
      () => DashboardPegawaiService(),
    );
    
    // Inject controller
    Get.lazyPut<DashboardPegawaiController>(
      () => DashboardPegawaiController(),
    );
  }
}
