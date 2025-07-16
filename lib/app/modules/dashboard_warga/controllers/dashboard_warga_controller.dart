import 'package:get/get.dart';
import 'package:lapor_md/app/modules/dashboard_warga/services/dashboard_warga_service.dart';
import 'package:lapor_md/app/modules/dashboard_warga/views/home/models/statistics_model.dart';
import 'package:lapor_md/app/modules/dashboard_warga/views/home/models/recent_pengaduan_model.dart';
import 'package:lapor_md/app/modules/dashboard_warga/views/home/models/recent_notifikasi_model.dart';

class DashboardWargaController extends GetxController {
  // Index untuk bottom navigation
  final selectedIndex = 0.obs;
  
  // Data observables
  final isLoading = false.obs;
  final Rxn<StatisticsModel> statistics = Rxn<StatisticsModel>();
  final RxList<RecentPengaduanModel> recentPengaduan = <RecentPengaduanModel>[].obs;
  final RxList<RecentNotifikasiModel> recentNotifikasi = <RecentNotifikasiModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
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

  // Method untuk fetch data home
  Future<void> fetchHomeData() async {
    try {
      isLoading.value = true;
      
      final result = await DashboardWargaService.fetchDataHome();
      
      if (result['success'] == true) {
        statistics.value = result['statistics'];
        recentPengaduan.value = result['recent_pengaduan'];
        recentNotifikasi.value = result['recent_notifikasi'];
      } else {
        Get.snackbar(
          'Error',
          result['message'] ?? 'Gagal memuat data',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Method untuk refresh data
  Future<void> refreshData() async {
    await fetchHomeData();
  }
}
