import 'package:flutter/material.dart'; // Tambah import ini
import 'package:get/get.dart';
import 'package:lapor_md/app/modules/dashboard_warga/services/dashboard_warga_service.dart';
import 'package:lapor_md/app/modules/dashboard_warga/views/home/models/statistics_model.dart';
import 'package:lapor_md/app/modules/dashboard_warga/views/home/models/recent_pengaduan_model.dart';
import 'package:lapor_md/app/modules/dashboard_warga/views/home/models/recent_notifikasi_model.dart';
import 'package:lapor_md/utils/storage_utils.dart';
import 'package:lapor_md/app/modules/dashboard_warga/views/riwayat/models/pengaduan_data_model.dart';
import 'package:lapor_md/app/modules/dashboard_warga/views/riwayat/models/statistic_riwayat_data_model.dart';
import 'package:lapor_md/app/modules/dashboard_warga/views/notifikasi/models/notifikasi_model.dart';
import 'package:lapor_md/app/modules/dashboard_warga/views/profile/models/profile_model.dart';
// Tambah import untuk access view
import 'package:lapor_md/app/modules/dashboard_warga/views/dashboard_warga_view.dart';

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
  
  // Notifikasi data observables  
  final RxList<NotifikasiModel> notifikasiList = <NotifikasiModel>[].obs;
  final Rxn<NotifikasiPaginationModel> notifikasiPagination = Rxn<NotifikasiPaginationModel>();
  final Rxn<NotifikasiStatisticsModel> notifikasiStatistics = Rxn<NotifikasiStatisticsModel>();
  
  // Profile data observables
  final Rxn<ProfileModel> profileData = Rxn<ProfileModel>();

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
    
    // Animate ConvexAppBar ke index yang bener
    DashboardWargaView.animateToIndex(index);
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
  Future<void> fetchNotifikasiData({
    String? status,
    int? page,
    int? limit,
  }) async {
    try {
      isLoadingNotifikasi.value = true;
      
      final result = await DashboardWargaService.fetchNotifikasiData(
        status: status,
        page: page,
        limit: limit,
      );
      
      if (result['success'] == true) {
        final data = result['data'];
        
        // Parse notifikasi list
        final List<NotifikasiModel> notifikasiListData = 
            (data['notifikasi'] as List)
                .map((item) => NotifikasiModel.fromJson(item))
                .toList();
        
        notifikasiList.value = notifikasiListData;
        
        // Parse pagination
        if (data['pagination'] != null) {
          notifikasiPagination.value = NotifikasiPaginationModel.fromJson(data['pagination']);
        }
        
        // Parse statistics
        if (data['statistics'] != null) {
          notifikasiStatistics.value = NotifikasiStatisticsModel.fromJson(data['statistics']);
        }
      } else {
        Get.snackbar(
          'Error',
          result['message'] ?? 'Gagal memuat data notifikasi',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
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
      
      final result = await DashboardWargaService.fetchProfileData();
      
      if (result['success'] == true) {
        final data = result['data'];
        profileData.value = ProfileModel.fromJson(data);
      } else {
        Get.snackbar(
          'Error',
          result['message'] ?? 'Gagal memuat data profile',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
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

  // Method untuk update profile
  Future<void> updateProfile({
    required String nama,
    required String email,
    required String alamat,
    required String noTelepon,
    String? fotoProfil, // tambah foto profile
  }) async {
    try {
      // Show loading
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );

      await Future.delayed(const Duration(seconds: 2));
      
      final result = await DashboardWargaService.updateProfileData(
        nama: nama,
        email: email,
        alamat: alamat,
        noTelepon: noTelepon,
        fotoProfil: fotoProfil, // tambah foto profile
      );
      
      // Hide loading
      Get.back();
      
      if (result['success'] == true) {
        // Update local data
        profileData.value = ProfileModel.fromJson(result['data']);
        
        // Refresh data profile dari server
        await fetchProfileData();
        
        Get.snackbar(
          'Sukses',
          result['message'] ?? 'Profile berhasil diupdate',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          result['message'] ?? 'Gagal update profile',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      // Hide loading jika ada di stack
      if (Get.isDialogOpen == true) {
        Get.back();
      }
      
      Get.snackbar(
        'Error',
        'Gagal update profile: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Method untuk refresh data page yang aktif
  Future<void> refreshCurrentPage() async {
    loadPageData(selectedIndex.value);
  }
}
