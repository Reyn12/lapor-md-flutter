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

  // Form controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Form key untuk validation
  final formKey = GlobalKey<FormState>();

  // Observable user data
  final Rx<User?> currentUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    _loadSavedLoginInput();
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

  // Method untuk load input login yang disimpan
  void _loadSavedLoginInput() {
    final savedInput = StorageUtils.getValue<Map<String, dynamic>>('input_login');
    if (savedInput != null) {
      emailController.text = savedInput['email'] ?? '';
      passwordController.text = savedInput['password'] ?? '';
      print('✅ Loaded saved login input');
    }
  }

  // Method untuk save input login
  void _saveLoginInput() async {
    final inputData = {
      'email': emailController.text.trim(),
      'password': passwordController.text,
    };
    await StorageUtils.setValue('input_login', inputData);
    print('💾 Saved login input');
  }

  // Method untuk hapus input login yang disimpan
  void _clearSavedLoginInput() async {
    await StorageUtils.removeKey('input_login');
    print('🗑️ Cleared saved login input');
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
      // Save input untuk testing
      _saveLoginInput();
      
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

      if (result['success'] == true) {
        // Parse user data dari response
        final userData = result['data']['user'];
        final user = User.fromJson(userData);
        
        // Set current user
        currentUser.value = user;
        
        // Simpen tokens ke GetStorage
        await StorageUtils.setValue('access_token', result['data']['access_token']);
        await StorageUtils.setValue('refresh_token', result['data']['refresh_token']);
        
        // Simpen user data juga
        await StorageUtils.setValue('user_data', user.toJson());
        
        // Hapus saved input login kalo berhasil (comment dulu)
        // _clearSavedLoginInput();
        
        print('✅ Login berhasil!');
        print('👤 User: ${user.nama} (${user.email})');
        StorageUtils.printAllStorage();

        // Login berhasil
        Get.snackbar(
          'Berhasil',
          result['message'] ?? 'Login berhasil',
          backgroundColor: Colors.green[100],
          colorText: Colors.green[800],
          snackPosition: SnackPosition.TOP,
        );

        // Navigate to Dashboard Warga
        print("Coming Soon Navigate to Dashboard Warga");
        // Get.offNamed(Routes.HOME);
      } else {
        // Login gagal
        Get.snackbar(
          'Login Gagal',
          result['message'] ?? 'Login gagal',
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

      if (result['success'] == true) {
        // Register berhasil
        Get.snackbar(
          'Berhasil',
          result['message'] ?? 'Registrasi berhasil',
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
          result['message'] ?? 'Registrasi gagal',
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
      currentUser.value = null;
      
      // Clear tokens dan user data dari storage
      await StorageUtils.clearAll();
      
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
