import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lapor_md/app/widgets/loading_dialog.dart';
import '../../../routes/app_pages.dart';

class OnboardingController extends GetxController {
  // Page controller untuk handle swipe
  final PageController pageController = PageController();
  
  // Current page index
  final currentPage = 0.obs;
  
  // Data onboarding
  final List<OnboardingData> onboardingData = [
    OnboardingData(
      image: 'assets/images/splash_1.png',
      title: 'Laporkan Keluhan\nKamu dengan Mudah',
      description: 'Sampaikan aspirasi dan keluhan kamu\ntentang kondisi lingkungan di Mangga Dua\nTernate hanya dengan beberapa sentuhan.',
    ),
    OnboardingData(
      image: 'assets/images/splash_2.png', 
      title: 'Data Kamu\nAman Terjaga',
      description: 'Semua laporan dan data pribadi kamu\ndilindungi dengan enkripsi tingkat tinggi\nuntuk menjaga keamanan dan privasi.',
    ),
    OnboardingData(
      image: 'assets/images/splash_3.png',
      title: 'Pantau Status\nLaporan Kamu', 
      description: 'Lihat perkembangan tindak lanjut laporan\nkamu secara real-time dan dapatkan notifikasi\nupdate dari pemerintah daerah.',
    ),
  ];

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
    pageController.dispose();
    super.onClose();
  }

  // Function untuk next page
  void nextPage() {
    if (currentPage.value < onboardingData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Kalau sudah halaman terakhir, pindah ke auth
      showLoading();
      Future.delayed(const Duration(seconds: 1), () {
        hideLoading();
        Get.offNamed(Routes.AUTH);
      });
    }
  }

  // Function untuk update current page
  void updatePageIndex(int index) {
    currentPage.value = index;
  }

  // Function untuk skip ke auth langsung
  void skipOnboarding() {
    showLoading();
    Future.delayed(const Duration(seconds: 1), () {
      hideLoading();
      Get.offNamed(Routes.AUTH);
    });
  }
}

// Data class untuk onboarding
class OnboardingData {
  final String image;
  final String title;
  final String description;

  OnboardingData({
    required this.image,
    required this.title,
    required this.description,
  });
}
