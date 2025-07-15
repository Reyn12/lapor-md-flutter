import 'package:get/get.dart';

import '../controllers/dashboard_kepala_kantor_controller.dart';

class DashboardKepalaKantorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardKepalaKantorController>(
      () => DashboardKepalaKantorController(),
    );
  }
}
