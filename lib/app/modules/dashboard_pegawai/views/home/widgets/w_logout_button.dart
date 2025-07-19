import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lapor_md/app/data/network/endpoints.dart';
import 'package:lapor_md/utils/storage_utils.dart';
import 'package:lapor_md/app/routes/app_pages.dart';

class WLogoutButton extends StatelessWidget {
  const WLogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton.icon(
        onPressed: () => _showLogoutDialog(context),
        icon: const Icon(
          Icons.logout,
          size: 20,
          color: Colors.white,
        ),
        label: const Text(
          'Logout',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE53E3E), // Red color
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text(
          'Konfirmasi Logout',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3748),
          ),
        ),
        content: const Text(
          'Apakah kamu yakin ingin keluar dari akun ini?',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF64748B),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Batal',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back(); // Close dialog
              _performLogout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53E3E),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Logout',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _performLogout() async {
    try {
      // Show loading
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );

      // Ambil token dari storage
      final token = StorageUtils.getValue<String>('access_token');
      
      if (token == null) {
        throw Exception('Token tidak ditemukan');
      }

      // Hit logout API
      final response = await GetConnect().post(
        Endpoints.logout,
        null,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      // Close loading dialog
      Get.back();

      if (response.statusCode == 200 || response.statusCode == 401) {
        // Logout berhasil atau token sudah invalid
        await _clearTokensAndNavigate();
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }

    } catch (e) {
      // Close loading dialog if still open
      if (Get.isDialogOpen == true) {
        Get.back();
      }

      print('Error logout: $e');
      
      // Meskipun ada error, tetap clear tokens dan logout
      // karena kemungkinan token sudah expired
      await _clearTokensAndNavigate();
    }
  }

  Future<void> _clearTokensAndNavigate() async {
    try {
      // Hapus tokens dari storage
      await StorageUtils.removeKey('access_token');
      await StorageUtils.removeKey('refresh_token');
      await StorageUtils.removeKey('user_data');
      
      // Print storage untuk debug
      StorageUtils.printAllStorage();
      
      // Navigate ke halaman auth
      Get.offAllNamed(Routes.AUTH);
      
      // Show success message
      Get.snackbar(
        'Logout Berhasil',
        'Kamu telah logout dari aplikasi',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF38A169),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      
    } catch (e) {
      print('Error clearing storage: $e');
      
      // Force navigate meskipun ada error clear storage
      Get.offAllNamed(Routes.AUTH);
    }
  }
}
