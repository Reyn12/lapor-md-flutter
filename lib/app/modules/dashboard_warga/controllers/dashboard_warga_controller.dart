import 'package:get/get.dart';
import 'package:lapor_md/app/modules/dashboard_warga/services/dashboard_warga_service.dart';
import 'package:lapor_md/app/modules/dashboard_warga/views/home/models/statistics_model.dart';
import 'package:lapor_md/app/modules/dashboard_warga/views/home/models/recent_pengaduan_model.dart';
import 'package:lapor_md/app/modules/dashboard_warga/views/home/models/recent_notifikasi_model.dart';
import 'package:lapor_md/utils/storage_utils.dart';
import 'package:lapor_md/app/modules/dashboard_warga/views/riwayat/models/pengaduan_data_model.dart';
import 'package:lapor_md/app/modules/dashboard_warga/views/riwayat/models/statistic_riwayat_data_model.dart';

class DashboardWargaController extends GetxController {
  // Index untuk bottom navigation
  final selectedIndex = 0.obs;
  
  // Loading states per page
  final isLoadingHome = false.obs;
  final isLoadingRiwayat = false.obs;
  final isLoadingNotifikasi = false.obs;
  final isLoadingProfile = false.obs;
  
  // Home data observables
  final Rxn<StatisticsModel> statistics = Rxn<StatisticsModel>();
  final RxList<RecentPengaduanModel> recentPengaduan = <RecentPengaduanModel>[].obs;
  final RxList<RecentNotifikasiModel> recentNotifikasi = <RecentNotifikasiModel>[].obs;
  
  // User data observables
  final userName = ''.obs;
  
  // Riwayat data observables
  final RxList<PengaduanDataModel> riwayatList = <PengaduanDataModel>[].obs;
  final Rxn<StatisticRiwayatDataModel> riwayatStatistics = Rxn<StatisticRiwayatDataModel>();
  
  // TODO: Notifikasi data observables  
  // final RxList<NotifikasiModel> notifikasiList = <NotifikasiModel>[].obs;
  
  // TODO: Profile data observables
  // final Rxn<ProfileModel> profileData = Rxn<ProfileModel>();

  @override
  void onInit() {
    super.onInit();
    loadUserData(); // Cuma load user data sekali
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
  }

  // Method untuk load data sesuai page yang aktif
  void loadPageData(int pageIndex) {
    switch (pageIndex) {
      case 0:
        fetchHomeData();
        break;
      case 1:
        fetchRiwayatData(); // Default tanpa parameter (semua)
        break;
      case 2:
        fetchNotifikasiData();
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
      userName.value = userData['nama'] ?? 'User';
    }
  }

  // Method untuk fetch data home
  Future<void> fetchHomeData() async {
    try {
      isLoadingHome.value = true;
      
      final result = await DashboardWargaService.fetchDataHome();
      
      if (result['success'] == true) {
        statistics.value = result['statistics'];
        recentPengaduan.value = result['recent_pengaduan'];
        recentNotifikasi.value = result['recent_notifikasi'];
      } else {
        Get.snackbar(
          'Error',
          result['message'] ?? 'Gagal memuat data home',
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
      isLoadingHome.value = false;
    }
  }

  // Method untuk fetch data riwayat
  Future<void> fetchRiwayatData({String? status}) async {
    try {
      isLoadingRiwayat.value = true;
      
      final result = await DashboardWargaService.fetchDataRiwayat(status: status);
      
      if (result['success'] == true) {
        final data = result['data'];
        
        // Parse statistics (cuma ada kalau gak ada filter status)
        if (data['statistics'] != null) {
          riwayatStatistics.value = StatisticRiwayatDataModel.fromJson(data['statistics']);
        } else {
          riwayatStatistics.value = null;
        }
        
        // Parse pengaduan list
        final List<PengaduanDataModel> pengaduanList = 
            (data['pengaduan'] as List)
                .map((item) => PengaduanDataModel.fromJson(item))
                .toList();
        
        riwayatList.value = pengaduanList;
      } else {
        Get.snackbar(
          'Error',
          result['message'] ?? 'Gagal memuat data riwayat',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memuat data riwayat: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingRiwayat.value = false;
    }
  }

  // Method untuk fetch data notifikasi
  Future<void> fetchNotifikasiData() async {
    try {
      isLoadingNotifikasi.value = true;
      
      // TODO: Hit API endpoint notifikasi
      // final result = await DashboardWargaService.fetchNotifikasiData();
      
      // TODO: Parse dan assign ke notifikasiList
      // if (result['success'] == true) {
      //   notifikasiList.value = result['notifikasi'];
      // }
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memuat data notifikasi: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingNotifikasi.value = false;
    }
  }

  // Method untuk fetch data profile
  Future<void> fetchProfileData() async {
    try {
      isLoadingProfile.value = true;
      
      // TODO: Hit API endpoint profile
      // final result = await DashboardWargaService.fetchProfileData();
      
      // TODO: Parse dan assign ke profileData
      // if (result['success'] == true) {
      //   profileData.value = result['profile'];
      // }
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memuat data profile: $e',
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
