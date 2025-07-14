import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background putih
      body: Center(
        child: Obx(() => AnimatedOpacity(
          opacity: controller.opacity.value, // Animasi opacity dari controller
          duration: const Duration(milliseconds: 1500), // Durasi animasi muncul
          child: Image.asset(
            'assets/icons/icon_aplikasi.png',
            width: 180, // Ukuran icon
            height: 180,
          ),
        )),
      ),
    );
  }
}
