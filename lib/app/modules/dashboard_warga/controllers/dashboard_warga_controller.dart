import 'package:get/get.dart';

class DashboardWargaController extends GetxController {
  // Index untuk bottom navigation
  final selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Method untuk ganti halaman
  void changePage(int index) {
    selectedIndex.value = index;
  }
}
