import 'package:get/get.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/buat_pengaduan_warga/bindings/buat_pengaduan_warga_binding.dart';
import '../modules/buat_pengaduan_warga/views/buat_pengaduan_warga_view.dart';
import '../modules/dashboard_kepala_kantor/bindings/dashboard_kepala_kantor_binding.dart';
import '../modules/dashboard_kepala_kantor/views/dashboard_kepala_kantor_view.dart';
import '../modules/dashboard_pegawai/bindings/dashboard_pegawai_binding.dart';
import '../modules/dashboard_pegawai/views/dashboard_pegawai_view.dart';
import '../modules/dashboard_warga/bindings/dashboard_warga_binding.dart';
import '../modules/dashboard_warga/views/dashboard_warga_view.dart';
import '../modules/detail_riwayat/bindings/detail_riwayat_binding.dart';
import '../modules/detail_riwayat/views/detail_riwayat_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_WARGA,
      page: () => const DashboardWargaView(),
      binding: DashboardWargaBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: _Paths.DASHBOARD_PEGAWAI,
      page: () => const DashboardPegawaiView(),
      binding: DashboardPegawaiBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: _Paths.DASHBOARD_KEPALA_KANTOR,
      page: () => const DashboardKepalaKantorView(),
      binding: DashboardKepalaKantorBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: _Paths.BUAT_PENGADUAN_WARGA,
      page: () => const BuatPengaduanWargaView(),
      binding: BuatPengaduanWargaBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: _Paths.DETAIL_RIWAYAT,
      page: () => const DetailRiwayatView(),
      binding: DetailRiwayatBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
