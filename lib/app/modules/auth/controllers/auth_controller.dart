import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/loading_dialog.dart';
import '../../../../utils/storage_utils.dart';

class AuthController extends GetxController {
  // Service
  final AuthService _authService = AuthService();

  // Observable user data
  final Rx<User?> currentUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Method untuk hapus input login yang disimpan
  void _clearSavedLoginInput() async {
    await StorageUtils.removeKey('input_login');
    print('🗑️ Cleared saved login input');
  }

  // Helper method untuk extract validation errors
  String _getValidationErrorMessage(Map<String, dynamic> result) {
    if (result['errors'] != null) {
      final errors = result['errors'] as Map<String, dynamic>;
      final errorMessages = <String>[];

      errors.forEach((field, messages) {
        if (messages is List) {
          for (var message in messages) {
            errorMessages.add(message.toString());
          }
        }
      });

      if (errorMessages.isNotEmpty) {
        return errorMessages.join('\n');
      }
    }

    return result['message'] ?? 'Terjadi kesalahan';
  }

  // Method untuk login dengan credentials dari parameter
  Future<void> loginWithCredentials({
    required String email,
    required String password,
  }) async {
    try {
      // Save input untuk testing
      final inputData = {'email': email, 'password': password};
      await StorageUtils.setValue('input_login', inputData);
      print('💾 Saved login input');

      // Show loading
      showLoading();

      await Future.delayed(const Duration(seconds: 1));

      // Call API
      final result = await _authService.login(email: email, password: password);

      // Hide loading
      hideLoading();

      if (result['success'] == true) {
        // Parse user data dari response
        final userData = result['data']['user'];
        final user = User.fromJson(userData);

        // Set current user
        currentUser.value = user;

        // Simpen tokens ke GetStorage
        await StorageUtils.setValue(
          'access_token',
          result['data']['access_token'],
        );
        await StorageUtils.setValue(
          'refresh_token',
          result['data']['refresh_token'],
        );

        // Simpen user data juga
        await StorageUtils.setValue('user_data', user.toJson());

        // Hapus saved input login kalo berhasil (comment dulu)
        // _clearSavedLoginInput();

        print('✅ Login berhasil!');
        print('👤 User: ${user.nama} (${user.email})');
        StorageUtils.printAllStorage();

        // Navigate to Dashboard Warga
        print("Coming Soon Navigate to Dashboard Warga");
        if (user.role == 'warga') {
          Get.offNamed(Routes.DASHBOARD_WARGA);
        } else if (user.role == 'pegawai') {
          Get.offNamed(Routes.DASHBOARD_PEGAWAI);
        } else if (user.role == 'kepala_kantor') {
          Get.offNamed(Routes.DASHBOARD_KEPALA_KANTOR);
        }
      } else {
        // Login gagal - extract error messages
        final errorMessage = _getValidationErrorMessage(result);

        print('❌ Login gagal: $errorMessage');
        if (result['errors'] != null) {
          print('📋 Validation errors: ${result['errors']}');
        }

        Get.snackbar(
          'Login Gagal',
          errorMessage,
          backgroundColor: Colors.red[100],
          colorText: Colors.red[800],
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      // Hide loading
      hideLoading();

      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  // Method untuk register (bonus)
  Future<void> register({
    required String nama,
    required String email,
    required String password,
    required String noTelepon,
    required String alamat,
  }) async {
    try {
      // Show loading
      showLoading();

      await Future.delayed(const Duration(seconds: 1));

      // Call API
      final result = await _authService.register(
        nama: nama,
        email: email,
        password: password,
        noTelepon: noTelepon,
        alamat: alamat,
      );

      // Hide loading
      hideLoading();

      if (result['success'] == true) {
        // Parse user data dari response (struktur beda dari login)
        final userData = result['user'];
        final user = User.fromJson(userData);

        // Simpen input email & password ke GetStorage untuk auto login
        final inputData = {'email': email, 'password': password};
        await StorageUtils.setValue('input_login', inputData);

        print('✅ Register berhasil!');
        print('👤 User: ${user.nama} (${user.email})');
        print('💾 Input login tersimpan untuk auto-fill');
        StorageUtils.printAllStorage();

        // Register berhasil
        Get.snackbar(
          'Berhasil',
          result['message'] ?? 'Registrasi berhasil',
          backgroundColor: Colors.green[100],
          colorText: Colors.green[800],
          snackPosition: SnackPosition.TOP,
        );

        // Navigate ke auth view (login screen) dengan input terisi otomatis
        // Gunakan offAllNamed untuk clear semua navigation stack
        Get.offAllNamed(Routes.AUTH);
      } else {
        // Register gagal - extract error messages untuk validation errors
        final errorMessage = _getValidationErrorMessage(result);

        print('❌ Register gagal: $errorMessage');
        if (result['errors'] != null) {
          print('📋 Validation errors: ${result['errors']}');
        }

        Get.snackbar(
          'Registrasi Gagal',
          errorMessage,
          backgroundColor: Colors.red[100],
          colorText: Colors.red[800],
          snackPosition: SnackPosition.TOP,
          duration: const Duration(
            seconds: 4,
          ), // Kasih waktu lebih untuk baca error
        );
      }
    } catch (e) {
      // Hide loading
      hideLoading();

      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  // Method untuk logout
  Future<void> logout() async {
    try {
      // Clear user data
      currentUser.value = null;

      // Clear tokens dan user data dari storage
      await StorageUtils.clearAll();

      print('✅ User logged out');

      // Navigate to auth
      Get.offAllNamed(Routes.AUTH);

      Get.snackbar(
        'Berhasil',
        'Logout berhasil',
        backgroundColor: Colors.green[100],
        colorText: Colors.green[800],
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
