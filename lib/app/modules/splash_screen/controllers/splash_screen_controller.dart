import 'package:get/get.dart';
import '../../../widgets/loading_dialog.dart';
import '../../../routes/app_pages.dart';

class SplashScreenController extends GetxController {
  // Variable untuk animasi opacity
  final opacity = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    // Mulai animasi icon muncul
    startAnimation();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Fungsi untuk mulai animasi dan navigasi
  void startAnimation() {
    // Animasi icon muncul setelah 500ms
    Future.delayed(const Duration(milliseconds: 500), () {
      opacity.value = 1.0;
    });

    // Setelah 3 detik, tampilkan loading dan navigasi
    Future.delayed(const Duration(seconds: 3), () {
      showLoading(); 
      
      // Setelah 2 detik loading, pindah ke onboarding
      Future.delayed(const Duration(seconds: 1), () {
        hideLoading(); 
        Get.offNamed(Routes.ONBOARDING);
      });
    });
  }
}
