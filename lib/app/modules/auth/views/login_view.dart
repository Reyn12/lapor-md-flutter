import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../widgets/w_input_field.dart';
import 'register_view.dart';
import '../../../../utils/storage_utils.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});
  
  @override
  Widget build(BuildContext context) {
    // Form key lokal untuk login (pisah dari register)
    final loginFormKey = GlobalKey<FormState>();
    
    // Controllers lokal untuk login (pisah dari AuthController)
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    
    // Load saved input saat build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final savedInput = StorageUtils.getValue<Map<String, dynamic>>('input_login');
      if (savedInput != null) {
        emailController.text = savedInput['email'] ?? '';
        passwordController.text = savedInput['password'] ?? '';
        print('✅ Loaded saved login input to local controllers');
      }
    });
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                
                // Logo aplikasi
                Image.asset(
                  'assets/icons/icon_aplikasi.png',
                  width: 80,
                  height: 80,
                ),
                
                const SizedBox(height: 40),
                
                // Title
                const Text(
                  'Mari Masuk.',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Subtitle
                const Text(
                  'Laporkan masalah lingkungan di sekitar kamu\nuntuk Mangga Dua Ternate yang lebih baik.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
                
                const SizedBox(height: 50),
                
                // Email field dengan local controller
                EmailInputField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email tidak boleh kosong';
                    }
                    if (!GetUtils.isEmail(value)) {
                      return 'Format email tidak valid';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 24),
                
                // Password field dengan local controller
                PasswordInputField(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    if (value.length < 6) {
                      return 'Password minimal 6 karakter';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 40),
                
                // Sign In button dengan loading state
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // Validasi lokal dulu sebelum call controller.login()
                      if (loginFormKey.currentState!.validate()) {
                        // Pass email & password ke controller
                        controller.loginWithCredentials(
                          email: emailController.text.trim(),
                          password: passwordController.text,
                        );
                      } else {
                        Get.snackbar(
                          'Error',
                          'Mohon isi semua field dengan benar',
                          backgroundColor: Colors.red[100],
                          colorText: Colors.red[800],
                          snackPosition: SnackPosition.TOP,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(Icons.arrow_forward, size: 20),
                            ],
                          ),
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Sign up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Belum punya akun? ",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => const RegisterView(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 300),
                        );
                      },
                      child: const Text(
                        'Daftar',
                        style: TextStyle(
                          color: Color(0xFF6C63FF),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Forgot password
                GestureDetector(
                  onTap: () {
                    // TODO: Navigate to forgot password
                  },
                  child: const Text(
                    'Lupa Password',
                    style: TextStyle(
                      color: Color(0xFF6C63FF),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
