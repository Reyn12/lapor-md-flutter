import 'package:get/get.dart';

import '../controllers/buat_pengaduan_warga_controller.dart';

class BuatPengaduanWargaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuatPengaduanWargaController>(
      () => BuatPengaduanWargaController(),
    );
  }
}
