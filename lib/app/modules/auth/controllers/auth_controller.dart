import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/loading_dialog.dart';

class AuthController extends GetxController {
  // Service
  final AuthService _authService = AuthService();

  // Form controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Form key untuk validation
  final formKey = GlobalKey<FormState>();

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
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Method untuk login
  Future<void> login() async {
    // Validate form
    if (!formKey.currentState!.validate()) {
      Get.snackbar(
        'Error',
        'Mohon isi semua field dengan benar',
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    try {
      // Show loading
      showLoading();

      await Future.delayed(const Duration(seconds: 1));

      // Call API
      final result = await _authService.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      // Hide loading
      hideLoading();

      if (result.success) {
        // Login berhasil
        Get.snackbar(
          'Berhasil',
          result.message,
          backgroundColor: Colors.green[100],
          colorText: Colors.green[800],
          snackPosition: SnackPosition.TOP,
        );

        // Navigate to home
        Get.offNamed(Routes.HOME);
      } else {
        // Login gagal
        Get.snackbar(
          'Login Gagal',
          result.message,
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
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Show loading
      showLoading();

      // Call API
      final result = await _authService.register(
        name: name,
        email: email,
        password: password,
      );

      // Hide loading
      hideLoading();

      if (result.success) {
        // Register berhasil
        Get.snackbar(
          'Berhasil',
          result.message,
          backgroundColor: Colors.green[100],
          colorText: Colors.green[800],
          snackPosition: SnackPosition.TOP,
        );


        // Navigate to home
        Get.offNamed(Routes.HOME);
      } else {
        // Register gagal
        Get.snackbar(
          'Registrasi Gagal',
          result.message,
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

  // Method untuk logout
  Future<void> logout() async {
    try {
      // Clear user data
      // currentUser.value = null;
      // accessToken.value = '';
      // refreshToken.value = '';
      
      // Clear form
      emailController.clear();
      passwordController.clear();
      
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

  // Validation methods
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 6) {
      return 'Password minimal 6 karakter';
    }
    return null;
  }
}
