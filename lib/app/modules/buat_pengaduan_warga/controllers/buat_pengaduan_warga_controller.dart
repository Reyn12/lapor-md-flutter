import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/kategori_model.dart';
import '../services/buat_pengaduan_warga_service.dart';
import '../widgets/preview_pengaduan.dart';
import '../widgets/sukses_pengaduan.dart';
import '../../../widgets/loading_dialog.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:lapor_md/app/routes/app_pages.dart';

class BuatPengaduanWargaController extends GetxController {
  final BuatPengaduanWargaService _service = BuatPengaduanWargaService();
  final ImagePicker _picker = ImagePicker();

  // Form controllers
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController judulController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController lokasiController = TextEditingController();

  // Observable variables
  final RxList<KategoriModel> listKategori = <KategoriModel>[].obs;
  final Rx<KategoriModel?> selectedKategori = Rx<KategoriModel?>(null);
  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchKategori();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    judulController.dispose();
    deskripsiController.dispose();
    lokasiController.dispose();
    super.onClose();
  }

  Future<void> fetchKategori() async {
    try {
      isLoading.value = true;
      final result = await _service.fetchKategori();
      
      if (result != null) {
        listKategori.value = result;
      } else {
        Get.snackbar(
          'Error',
          'Gagal mengambil data kategori',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    try {
      // Tampilkan dialog untuk memilih sumber gambar
      Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Pilih Sumber Foto',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildImageSourceOption(
                      icon: Icons.camera_alt,
                      label: 'Kamera',
                      onTap: () => _getImage(ImageSource.camera),
                    ),
                    _buildImageSourceOption(
                      icon: Icons.photo_library,
                      label: 'Galeri',
                      onTap: () => _getImage(ImageSource.gallery),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memilih foto',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Widget _buildImageSourceOption({
    required IconData icon, 
    required String label, 
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF8B5CF6).withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xFF8B5CF6).withOpacity(0.3)),
            ),
            child: Icon(icon, color: Color(0xFF8B5CF6), size: 32),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
  
  Future<void> _getImage(ImageSource source) async {
    try {
      Get.back(); // Tutup dialog
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      
      if (image != null) {
        selectedImage.value = File(image.path);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mengambil foto',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void removeImage() {
    selectedImage.value = null;
  }

  Future<void> submitPengaduan() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (selectedKategori.value == null) {
      Get.snackbar(
        'Error',
        'Pilih kategori pengaduan',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      // Show loading dialog
      showLoading();

      await Future.delayed(const Duration(milliseconds: 500));
      
      final result = await _service.fetchBuatPengaduan(
        kategoriId: selectedKategori.value!.id,
        judul: judulController.text.trim(),
        deskripsi: deskripsiController.text.trim(),
        lokasi: lokasiController.text.trim(),
        foto: selectedImage.value?.path,
      );

      // Hide loading dialog
      hideLoading();

      if (result != null) {
        // Show success dialog
        SuksesPengaduan.show(
          message: 'Pengaduan berhasil dikirim!',
          onSelesai: () {
            // Reset form
            resetForm();
            // Navigate back to dashboard
            Get.offAllNamed(Routes.DASHBOARD_WARGA);
          },
        );
      } else {
        Get.snackbar(
          'Error',
          'Gagal membuat pengaduan',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      // Hide loading dialog if error occurs
      hideLoading();
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void resetForm() {
    judulController.clear();
    deskripsiController.clear();
    lokasiController.clear();
    selectedKategori.value = null;
    selectedImage.value = null;
  }

  void previewPengaduan() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (selectedKategori.value == null) {
      Get.snackbar(
        'Error',
        'Pilih kategori pengaduan',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Show preview dialog with custom widget
    Get.dialog(
      PreviewPengaduan(
        kategori: selectedKategori.value!.namaKategori,
        judul: judulController.text.trim(),
        deskripsi: deskripsiController.text.trim(),
        lokasi: lokasiController.text.trim(),
        foto: selectedImage.value,
        onKirim: () {
          submitPengaduan(); // Submit pengaduan
        },
      ),
      barrierDismissible: false,
    );
  }
}
