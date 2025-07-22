import 'package:get/get.dart';
import 'package:lapor_md/app/modules/dashboard_kepala_kantor/views/dashboard_kepala_kantor_view.dart';
import 'package:lapor_md/app/modules/dashboard_kepala_kantor/services/dashboard_kepala_kantor_service.dart';
import 'package:lapor_md/app/modules/dashboard_kepala_kantor/views/home/models/kepala_kantor_model.dart';
import 'package:lapor_md/app/modules/dashboard_kepala_kantor/views/home/models/executive_summary_model.dart';
import 'package:lapor_md/app/modules/dashboard_kepala_kantor/views/home/models/pengaduan_bulanan.dart';
import 'package:lapor_md/app/widgets/loading_dialog.dart';
import 'package:lapor_md/utils/storage_utils.dart';
import 'package:lapor_md/app/modules/dashboard_kepala_kantor/views/approval/models/pengaduan_model.dart';
import 'package:lapor_md/app/modules/dashboard_kepala_kantor/views/monitoring/models/pengaduan_list_model.dart';
import 'package:lapor_md/app/modules/dashboard_kepala_kantor/views/profile/models/kepala_kantor_model.dart' as profile;
import 'package:lapor_md/app/modules/dashboard_kepala_kantor/views/laporan/models/laporan_model.dart' as laporan;

class DashboardKepalaKantorController extends GetxController {
  // Service instance
  final DashboardKepalaKantorService _service = DashboardKepalaKantorService();

  // Index untuk bottom navigation
  final selectedIndex = 0.obs;

  // Loading states per page
  final isLoadingHome = false.obs;
  final isLoadingApproval = false.obs;
  final isLoadingLaporan = false.obs;
  final isLoadingMonitoring = false.obs;
  final isLoadingProfile = false.obs;

  // Observable untuk data laporan
  final laporanData = Rxn<laporan.LaporanModel>();

  // User data observables
  final userName = ''.obs;

  // Kepala kantor data observable
  final Rx<KepalaKantorModel?> kepalaKantorData = Rx<KepalaKantorModel?>(null);

  // Executive summary data observable
  final Rx<ExecutiveSummaryModel?> executiveSummaryData =
      Rx<ExecutiveSummaryModel?>(null);

  // Grafik bulanan data observable
  final RxList<PengaduanBulananModel> grafikBulananData =
      <PengaduanBulananModel>[].obs;

  // Approval data observable
  final RxList<Pengaduan> approvalData = <Pengaduan>[].obs;
  
  // Monitoring data observable
  final Rx<MonitoringResponseModel?> monitoringData = Rx<MonitoringResponseModel?>(null);

  // Profile data observable
  final Rx<profile.KepalaKantorModel?> profileData = Rx<profile.KepalaKantorModel?>(null);

  @override
  void onInit() {
    super.onInit();
    loadPageData(0); // Load home data saat init
    loadUserData(); // Load user data sekali
  }

  @override
  void onReady() {
    super.onReady();
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
    DashboardKepalaKantorView.animateToIndex(index);
  }

  // Method untuk load data sesuai page yang aktif
  void loadPageData(int pageIndex) {
    switch (pageIndex) {
      case 0:
        fetchHomeData();
        break;
      case 1:
        fetchApprovalData();
        break;
      case 2:
        fetchLaporanData();
        break;
      case 3:
        fetchMonitoringData();
        break;
      case 4:
        fetchProfileData();
        break;
    }
  }

  // Method untuk load user data dari storage (sekali aja)
  void loadUserData() {
    final userData = StorageUtils.getValue<Map<String, dynamic>>('user_data');
    if (userData != null) {
      userName.value = userData['nama'] ?? 'Kepala Kantor';
    }
  }

  // Fetch methods untuk setiap page
  void fetchHomeData() async {
    isLoadingHome.value = true;
    try {
      // Fetch kepala kantor data
      final kepalaKantor = await _service.fetchKepalaKantorData();
      if (kepalaKantor != null) {
        kepalaKantorData.value = kepalaKantor;
      }

      // Fetch executive summary data
      final executiveSummary = await _service.fetchExecutiveSummaryData();
      if (executiveSummary != null) {
        executiveSummaryData.value = executiveSummary;
      }

      // Fetch grafik bulanan data
      final grafikBulanan = await _service.fetchGrafikBulananData();
      grafikBulananData.assignAll(grafikBulanan);
    } catch (e) {
      print('Error fetching home data: $e');
    } finally {
      isLoadingHome.value = false;
    }
  }

  void fetchApprovalData() async {
    print('=== CONTROLLER: FETCHING APPROVAL DATA ===');
    isLoadingApproval.value = true;
    try {
      final result = await _service.fetchApprovalData();
      print('=== CONTROLLER: SERVICE RESULT: $result ===');
      if (result != null) {
        print('=== CONTROLLER: ASSIGNING ${result.length} items ===');
        approvalData.assignAll(result);
        print('=== CONTROLLER: APPROVAL DATA SIZE: ${approvalData.length} ===');
      } else {
        print('=== CONTROLLER: SERVICE RETURNED NULL ===');
      }
    } catch (e) {
      print('Error fetching approval data: $e');
    } finally {
      isLoadingApproval.value = false;
    }
  }

  void fetchLaporanData() async {
    isLoadingLaporan.value = true;
    try {
      final result = await _service.fetchLaporanData();
      if (result != null) {
        laporanData.value = result;
      }
    } catch (e) {
      print('Error fetching laporan data: $e');
    } finally {
      isLoadingLaporan.value = false;
    }
  }

  void fetchMonitoringData() async {
    isLoadingMonitoring.value = true;
    try {
      final result = await _service.fetchMonitoringData();
      if (result != null) {
        monitoringData.value = result;
      }
    } catch (e) {
      print('Error fetching monitoring data: $e');
    } finally {
      isLoadingMonitoring.value = false;
    }
  }

  // Approve pengaduan
  Future<Map<String, dynamic>> approvePengaduan(int id, String? catatan) async {
    showLoading();
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      if (catatan == null || catatan.isEmpty) {
        hideLoading();
        return {'success': false, 'message': 'Catatan approval wajib diisi'};
      }

      final result = await _service.approvePengaduan(id, catatan);

      if (result['success']) {
        // Refresh data setelah approve
        hideLoading();
        fetchApprovalData();
      }

      return result;
    } catch (e) {
      hideLoading();
      print('Error approving pengaduan: $e');
      return {
        'success': false,
        'message': 'Terjadi kesalahan saat menyetujui pengaduan',
      };
    }
  }

  // Reject pengaduan
  Future<Map<String, dynamic>> rejectPengaduan(int id, String? catatan) async {
    showLoading();
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final result = await _service.rejectPengaduan(id, catatan);

      if (result['success']) {
        // Refresh data setelah reject
        hideLoading();
        fetchApprovalData();
      }

      return result;
    } catch (e) {
      hideLoading();
      print('Error rejecting pengaduan: $e');
      return {
        'success': false,
        'message': 'Terjadi kesalahan saat menolak pengaduan',
      };
    }
  }

  void fetchProfileData() async {
    isLoadingProfile.value = true;
    try {
      final result = await _service.fetchProfileData();
      if (result != null) {
        profileData.value = result;
      }
    } catch (e) {
      print('Error fetching profile data: $e');
    } finally {
      isLoadingProfile.value = false;
    }
  }
  
  // Update profile data
  Future<Map<String, dynamic>> updateProfileData({
    required String nama,
    required String email,
    required String noTelepon,
    required String alamat,
    required String password,
  }) async {
    showLoading();
    try {
      final result = await _service.updateProfileData(
        nama: nama,
        email: email,
        noTelepon: noTelepon,
        alamat: alamat,
        password: password,
      );
      
      hideLoading();
      
      if (result['success']) {
        // Refresh profile data setelah update
        fetchProfileData();
        
        // Update juga nama di userName observable
        userName.value = nama;
        
        // Update user_data di storage
        final userData = StorageUtils.getValue<Map<String, dynamic>>('user_data');
        if (userData != null) {
          userData['nama'] = nama;
          userData['email'] = email;
          await StorageUtils.setValue('user_data', userData);
        }
      }
      
      return result;
    } catch (e) {
      hideLoading();
      print('Error updating profile data: $e');
      return {
        'success': false,
        'message': 'Terjadi kesalahan saat update profile',
      };
    }
  }
}
