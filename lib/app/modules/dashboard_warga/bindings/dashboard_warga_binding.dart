import 'package:get/get.dart';

import '../controllers/dashboard_warga_controller.dart';

class DashboardWargaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardWargaController>(
      () => DashboardWargaController(),
    );
  }
}
