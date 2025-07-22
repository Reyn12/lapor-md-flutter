import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Tambah import untuk access view
import 'package:lapor_md/app/modules/dashboard_pegawai/views/dashboard_pegawai_view.dart';
import 'package:lapor_md/utils/storage_utils.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/services/dashboard_pegawai_service.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/views/home/models/statistic_pegawai_model.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/views/home/models/pengaduan_prioritas_model.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/views/home/models/pengaduan_saya_tangani_model.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/views/pengaduan/models/pengaduan_pegawai_response_model.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/views/pengaduan/models/detail_pengaduan_model.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/views/profile/models/profile_pegawai_model.dart';

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

  // Pengaduan data
  final Rx<PengaduanPegawaiResponseModel?> pengaduanData = Rx<PengaduanPegawaiResponseModel?>(null);
  
  // Detail pengaduan data
  final Rx<DetailPengaduanModel?> detailPengaduan = Rx<DetailPengaduanModel?>(null);
  final isLoadingDetailPengaduan = false.obs;
  
  // Accept pengaduan
  final isLoadingAcceptPengaduan = false.obs;
  
  // Complete pengaduan
  final isLoadingCompletePengaduan = false.obs;
  
  // Filter states
  final selectedStatus = 'masuk'.obs; // API expect 'masuk' untuk pengaduan menunggu
  final searchQuery = ''.obs;
  final selectedKategoriId = Rx<int?>(null);
  final selectedPrioritas = Rx<String?>(null);
  final tanggalDari = Rx<String?>(null);
  final tanggalSampai = Rx<String?>(null);
  final currentPage = 1.obs;
  
  // Search debounce timer
  Timer? _searchTimer;

  final Rx<ProfilePegawaiModel?> profilePegawai = Rx<ProfilePegawaiModel?>(null);

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
    _searchTimer?.cancel();
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
        fetchPengaduanData();
        break;
      case 2:
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
      
      // Clear existing data untuk avoid confusion
      pengaduanData.value = null;
      
      // Debug token authentication
      final token = StorageUtils.getValue<String>('access_token');
      final userData = StorageUtils.getValue<Map<String, dynamic>>('user_data');
      print('=== DEBUG AUTHENTICATION ===');
      print('Token tersedia: ${token != null}');
      print('Token: ${token?.substring(0, 20)}...' ?? 'null');
      print('User role: ${userData?['role']}');
      print('User name: ${userData?['nama']}');
      print('============================');
      
      // Print all storage untuk debug
      StorageUtils.printAllStorage();
      
      // Debug filter values sebelum kirim ke service
      print('=== DEBUG CONTROLLER FILTERS ===');
      print('selectedStatus: ${selectedStatus.value}');
      print('searchQuery: ${searchQuery.value}');
      print('selectedKategoriId: ${selectedKategoriId.value}');
      print('selectedPrioritas: ${selectedPrioritas.value}');
      print('tanggalDari: ${tanggalDari.value}');
      print('tanggalSampai: ${tanggalSampai.value}');
      print('==================================');

      // Fetch pengaduan data dari service dengan filter
      final pengaduanResponse = await _service.fetchPengaduanData(
        status: selectedStatus.value,
        search: searchQuery.value,
        kategoriId: selectedKategoriId.value,
        prioritas: selectedPrioritas.value,
        tanggalDari: tanggalDari.value,
        tanggalSampai: tanggalSampai.value,
        page: currentPage.value,
        limit: 10,
      );
      
      // Update observable
      pengaduanData.value = pengaduanResponse;
      
      print('Berhasil fetch pengaduan data pegawai');
      print('Status filter: ${selectedStatus.value}');
      print('Total pengaduan: ${pengaduanResponse.pengaduan.length}');
      print('Tab counts: Menunggu=${pengaduanResponse.tabCounts.masuk}, Diproses=${pengaduanResponse.tabCounts.diproses}, Selesai=${pengaduanResponse.tabCounts.selesai}');
      
      // Debug actual status dari setiap pengaduan
      if (pengaduanResponse.pengaduan.isNotEmpty) {
        print('=== PENGADUAN STATUS DEBUG ===');
        for (var pengaduan in pengaduanResponse.pengaduan) {
          print('${pengaduan.nomorPengaduan}: status="${pengaduan.status}"');
        }
        print('==============================');
      }
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      print('Error fetch pengaduan data: $e');
    } finally {
      isLoadingPengaduan.value = false;
    }
  }

  // Method untuk update filter dan refresh data
  void updateFilter({
    String? status,
    String? search,
    int? kategoriId,
    String? prioritas,
    String? tanggalDari,
    String? tanggalSampai,
    bool updateKategoriId = false,
    bool updatePrioritas = false,
    bool updateTanggalDari = false,
    bool updateTanggalSampai = false,
  }) {
    print('=== UPDATE FILTER ===');
    print('kategoriId: $kategoriId, updateKategoriId: $updateKategoriId');
    print('prioritas: $prioritas, updatePrioritas: $updatePrioritas');
    
    // Update observables
    if (status != null) selectedStatus.value = status;
    
    // Handle nullable fields dengan explicit flag
    if (updateKategoriId) {
      selectedKategoriId.value = kategoriId;
      print('Updated selectedKategoriId to: ${selectedKategoriId.value}');
    }
    if (updatePrioritas) {
      selectedPrioritas.value = prioritas;
      print('Updated selectedPrioritas to: ${selectedPrioritas.value}');
    }
    if (updateTanggalDari) {
      this.tanggalDari.value = tanggalDari;
    }
    if (updateTanggalSampai) {
      this.tanggalSampai.value = tanggalSampai;
    }
    
    // Handle search dengan debounce
    if (search != null) {
      searchQuery.value = search;
      _searchTimer?.cancel();
      _searchTimer = Timer(const Duration(milliseconds: 500), () {
        currentPage.value = 1;
        fetchPengaduanData();
      });
    } else {
      // Reset ke page 1 dan refresh data langsung untuk filter lainnya
      currentPage.value = 1;
      fetchPengaduanData();
    }
    print('==================');
  }

  // Method untuk change status tab
  void changeStatusTab(String status) {
    print('=== DEBUG CHANGE STATUS TAB ===');
    print('From: ${selectedStatus.value}');
    print('To: $status');
    print('==============================');
    
    selectedStatus.value = status;
    currentPage.value = 1;
    fetchPengaduanData();
  }

  // Method untuk fetch data profile
  Future<void> fetchProfileData() async {
    try {
      isLoadingProfile.value = true;
      final data = await _service.fetchProfilePegawai();
      profilePegawai.value = data;
    } catch (e) {
      Get.snackbar('Error', 'Gagal ambil data profile: $e', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoadingProfile.value = false;
    }
  }

  // Method untuk update profile pegawai
  Future<void> updateProfilePegawai(Map<String, dynamic> data) async {
    try {
      isLoadingProfile.value = true;
      final updated = await _service.updateProfilePegawai(data);
      profilePegawai.value = updated;
      Get.back();
      Get.snackbar(
        'Berhasil',
        'Profile berhasil diupdate',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF2563EB),
        colorText: Colors.white,
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
        icon: const Icon(Icons.check_circle, color: Colors.white),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal update profile: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
        icon: const Icon(Icons.close_rounded, color: Colors.white),
      );
    } finally {
      isLoadingProfile.value = false;
    }
  }

  // Method untuk refresh data page yang aktif
  Future<void> refreshCurrentPage() async {
    loadPageData(selectedIndex.value);
  }

  // Method untuk fetch detail pengaduan
  Future<void> fetchDetailPengaduan(int pengaduanId) async {
    try {
      isLoadingDetailPengaduan.value = true;
      
      // Clear existing data
      detailPengaduan.value = null;
      
      print('=== DEBUG FETCH DETAIL PENGADUAN ===');
      print('Pengaduan ID: $pengaduanId');
      print('====================================');
      
      // Fetch detail pengaduan dari service
      final detailData = await _service.fetchDetailPengaduan(pengaduanId);
      
      // Update observable
      detailPengaduan.value = detailData;
      
      print('Berhasil fetch detail pengaduan');
      print('Nomor Pengaduan: ${detailData.nomorPengaduan}');
      print('Judul: ${detailData.judul}');
      print('Status: ${detailData.status}');
      print('Can Accept: ${detailData.canAccept}');
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      print('Error fetch detail pengaduan: $e');
    } finally {
      isLoadingDetailPengaduan.value = false;
    }
  }

  // Method untuk terima pengaduan
  Future<void> acceptPengaduan(int pengaduanId) async {
    try {
      isLoadingAcceptPengaduan.value = true;
      
      print('=== DEBUG ACCEPT PENGADUAN ===');
      print('Pengaduan ID: $pengaduanId');
      print('==============================');
      
      // Hit API terima pengaduan
      final result = await _service.acceptPengaduan(pengaduanId);
      
      print('Berhasil terima pengaduan');
      print('Response: ${result['message']}');
      
      // Tutup dialog
      Get.back(); // Tutup konfirmasi dialog
      Get.back(); // Tutup detail dialog
      
      // Refresh data pengaduan
      fetchPengaduanData();
      
      // Show success message
      Get.snackbar(
        'Berhasil',
        'Pengaduan berhasil diterima dan akan diproses',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
      );
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal terima pengaduan: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error accept pengaduan: $e');
    } finally {
      isLoadingAcceptPengaduan.value = false;
    }
  }

  // Method untuk selesaikan pengaduan
  Future<void> completePengaduan(int pengaduanId, String catatanPenyelesaian) async {
    try {
      isLoadingCompletePengaduan.value = true;
      
      print('=== DEBUG COMPLETE PENGADUAN ===');
      print('Pengaduan ID: $pengaduanId');
      print('================================');
      
      // Hit API selesaikan pengaduan
      final result = await _service.completePengaduan(pengaduanId, catatanPenyelesaian);
      
      print('Berhasil selesaikan pengaduan');
      print('Response: ${result['message']}');
      
      // Tutup dialog
      Get.back(); // Tutup konfirmasi dialog
      Get.back(); // Tutup detail dialog (jika ada)
      
      // Refresh data pengaduan
      fetchPengaduanData();
      
      // Show success message
      Get.snackbar(
        'Berhasil',
        'Pengaduan telah diselesaikan',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF059669),
        colorText: Colors.white,
      );
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal selesaikan pengaduan: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error complete pengaduan: $e');
    } finally {
      isLoadingCompletePengaduan.value = false;
    }
  }

  // Loading state untuk ajukan approval
  final isLoadingAjukanApproval = false.obs;
  
  // Method untuk ajukan approval pengaduan
  Future<void> ajukanApprovalPengaduan(int pengaduanId) async {
    try {
      print('=== CONTROLLER: START ===');
      isLoadingAjukanApproval.value = true;
      
      print('=== CONTROLLER: CALLING SERVICE ===');
      await _service.ajukanApprovalPengaduan(pengaduanId);
      
      print('=== CONTROLLER: SERVICE DONE, SHOWING SNACKBAR ===');
      Get.snackbar(
        'Berhasil',
        'Pengaduan berhasil diajukan untuk approval',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      
      print('=== CONTROLLER: REFRESHING DATA ===');
      // Refresh data pengaduan setelah berhasil
      await fetchPengaduanData();
      
      print('=== CONTROLLER: REFRESHING DETAIL ===');
      // Refresh detail pengaduan jika ada
      if (detailPengaduan.value?.id == pengaduanId) {
        await fetchDetailPengaduan(pengaduanId);
      }
      
      print('=== CONTROLLER: SUCCESS COMPLETE ===');
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal ajukan approval: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error ajukan approval: $e');
    } finally {
      isLoadingAjukanApproval.value = false;
    }
  }
}
