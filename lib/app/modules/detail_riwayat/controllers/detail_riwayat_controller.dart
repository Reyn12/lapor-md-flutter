import 'package:get/get.dart';
import 'package:lapor_md/app/modules/detail_riwayat/services/detail_riwayat_services.dart';

class DetailRiwayatController extends GetxController {
  // Loading state
  final isLoading = false.obs;
  
  // Detail data
  final Rxn<Map<String, dynamic>> detailData = Rxn<Map<String, dynamic>>();
  
  // Error message
  final errorMessage = ''.obs;
  
  // Pengaduan ID
  late int pengaduanId;

  @override
  void onInit() {
    super.onInit();
    // Get pengaduan ID dari arguments
    if (Get.arguments != null && Get.arguments is Map) {
      pengaduanId = Get.arguments['pengaduan_id'] ?? 0;
      if (pengaduanId > 0) {
        fetchDetailRiwayat();
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Method untuk fetch detail riwayat
  Future<void> fetchDetailRiwayat() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final result = await DetailRiwayatServices.fetchDetailRiwayat(pengaduanId);
      
      if (result['success'] == true) {
        detailData.value = result['data'];
      } else {
        errorMessage.value = result['message'] ?? 'Gagal memuat detail pengaduan';
        Get.snackbar(
          'Error',
          errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan: $e';
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Method untuk refresh data
  Future<void> refreshData() async {
    await fetchDetailRiwayat();
  }
}
