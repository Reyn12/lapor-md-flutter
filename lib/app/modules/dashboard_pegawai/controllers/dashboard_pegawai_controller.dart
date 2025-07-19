import 'package:get/get.dart';
// Tambah import untuk access view
import 'package:lapor_md/app/modules/dashboard_pegawai/views/dashboard_pegawai_view.dart';
import 'package:lapor_md/utils/storage_utils.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/services/dashboard_pegawai_service.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/views/home/models/statistic_pegawai_model.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/views/home/models/pengaduan_prioritas_model.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/views/home/models/pengaduan_saya_tangani_model.dart';

class DashboardPegawaiController extends GetxController {
  // Service
  final DashboardPegawaiService _service = Get.find<DashboardPegawaiService>();

  // Index untuk bottom navigation
  final selectedIndex = 0.obs;
  
  // Loading states per page
  final isLoadingHome = false.obs;
  final isLoadingLaporan = false.obs;
  final isLoadingPengaduan = false.obs;
  final isLoadingProfile = false.obs;
  
  // User data observables
  final userName = ''.obs;
  
  // Statistics data
  final Rx<StatisticPegawaiModel?> statistics = Rx<StatisticPegawaiModel?>(null);
  
  // Pengaduan prioritas data
  final RxList<PengaduanPrioritasModel> pengaduanPrioritas = <PengaduanPrioritasModel>[].obs;
  
  // Pengaduan saya tangani data
  final RxList<PengaduanSayaTanganiModel> pengaduanSayaTangani = <PengaduanSayaTanganiModel>[].obs;
  
  // Notification data (dummy untuk sekarang)
  final RxList<dynamic> recentNotifikasi = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData(); // Load user data sekali
  }

  @override
  void onReady() {
    super.onReady();
    // Load data untuk page default (home)
    loadPageData(0);
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Method untuk ganti halaman + fetch data yang sesuai
  void changePage(int index) {
    selectedIndex.value = index;
    loadPageData(index);
    
    // Animate ConvexAppBar ke index yang bener
    DashboardPegawaiView.animateToIndex(index);
  }

  // Method untuk load data sesuai page yang aktif
  void loadPageData(int pageIndex) {
    switch (pageIndex) {
      case 0:
        fetchHomeData();
        break;
      case 1:
        fetchLaporanData();
        break;
      case 2:
        fetchPengaduanData();
        break;
      case 3:
        fetchProfileData();
        break;
    }
  }

  // Method untuk load user data dari storage (sekali aja)
  void loadUserData() {
    final userData = StorageUtils.getValue<Map<String, dynamic>>('user_data');
    if (userData != null) {
      userName.value = userData['nama'] ?? 'Pegawai';
    }
  }

  // Method untuk fetch data home
  Future<void> fetchHomeData() async {
    try {
      isLoadingHome.value = true;
      
      // Fetch semua data dari service
      final statisticsData = await _service.fetchStatistics();
      final pengaduanPrioritasData = await _service.fetchPengaduanPrioritas();
      final pengaduanSayaTanganiData = await _service.fetchPengaduanSayaTangani();
      
      // Update observables
      statistics.value = statisticsData;
      pengaduanPrioritas.assignAll(pengaduanPrioritasData);
      pengaduanSayaTangani.assignAll(pengaduanSayaTanganiData);
      
      // Dummy data notifikasi untuk testing
      recentNotifikasi.value = [
        {'id': 1, 'judul': 'Pengaduan Baru', 'isRead': false},
        {'id': 2, 'judul': 'Laporan Selesai', 'isRead': false},
        {'id': 3, 'judul': 'Update Status', 'isRead': true},
      ];
      
      print('Berhasil fetch home data pegawai');
      print('Statistics: ${statistics.value?.toJson()}');
      print('Pengaduan Prioritas: ${pengaduanPrioritas.length} items');
      print('Pengaduan Saya Tangani: ${pengaduanSayaTangani.length} items');
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      print('Error fetch home data: $e');
    } finally {
      isLoadingHome.value = false;
    }
  }

  // Method untuk fetch data laporan
  Future<void> fetchLaporanData() async {
    try {
      isLoadingLaporan.value = true;
      
      // Simulasi API call
      await Future.delayed(const Duration(seconds: 1));
      
      // TODO: Implement actual API call
      // print('Fetching laporan data for pegawai...');
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingLaporan.value = false;
    }
  }

  // Method untuk fetch data pengaduan
  Future<void> fetchPengaduanData() async {
    try {
      isLoadingPengaduan.value = true;
      
      // Simulasi API call
      await Future.delayed(const Duration(seconds: 1));
      
      // TODO: Implement actual API call
      // print('Fetching pengaduan data for pegawai...');
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingPengaduan.value = false;
    }
  }

  // Method untuk fetch data profile
  Future<void> fetchProfileData() async {
    try {
      isLoadingProfile.value = true;
      
      // Simulasi API call
      await Future.delayed(const Duration(seconds: 1));
      
      // TODO: Implement actual API call
      // print('Fetching profile data for pegawai...');
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingProfile.value = false;
    }
  }

  // Method untuk refresh data page yang aktif
  Future<void> refreshCurrentPage() async {
    loadPageData(selectedIndex.value);
  }
}
