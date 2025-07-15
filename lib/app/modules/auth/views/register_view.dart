import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../widgets/w_input_field.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    // Form controllers untuk register
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final phoneController = TextEditingController();
    final addressController = TextEditingController();
    
    // Form key khusus untuk register (pisah dari login)
    final registerFormKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: registerFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Back button
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(), // Back gesture default sudah smooth
                      icon: const Icon(Icons.arrow_back),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Logo aplikasi
                Image.asset(
                  'assets/icons/icon_aplikasi.png',
                  width: 80,
                  height: 80,
                ),
                
                const SizedBox(height: 40),
                
                // Title
                const Text(
                  'Mari Daftar.',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Subtitle
                const Text(
                  'Buat akun baru untuk mulai melaporkan\nmasalah lingkungan di sekitar kamu.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Name field
                CustomInputField(
                  label: 'Nama Lengkap',
                  hintText: 'Masukkan nama lengkap',
                  prefixIcon: Icons.person_outline,
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    if (value.length < 2) {
                      return 'Nama minimal 2 karakter';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 20),
                
                // Email field
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
                
                const SizedBox(height: 20),
                
                // Phone field
                CustomInputField(
                  label: 'Nomor Telepon',
                  hintText: 'Masukkan nomor telepon',
                  prefixIcon: Icons.phone_outlined,
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nomor telepon tidak boleh kosong';
                    }
                    if (value.length < 10) {
                      return 'Nomor telepon minimal 10 digit';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 20),
                
                // Address field
                CustomInputField(
                  label: 'Alamat',
                  hintText: 'Masukkan alamat lengkap',
                  prefixIcon: Icons.location_on_outlined,
                  controller: addressController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Alamat tidak boleh kosong';
                    }
                    if (value.length < 10) {
                      return 'Alamat minimal 10 karakter';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 20),
                
                // Password field
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
                
                const SizedBox(height: 20),
                
                // Confirm Password field (manual TextFormField)
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Konfirmasi Password',
                    hintText: 'Masukkan ulang password kamu...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF6C63FF)),
                    ),
                    prefixIcon: const Icon(Icons.lock_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Konfirmasi password tidak boleh kosong';
                    }
                    if (value != passwordController.text) {
                      return 'Password tidak sama';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 40),
                
                // Register button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      if (registerFormKey.currentState!.validate()) {
                        controller.register(
                          nama: nameController.text.trim(),
                          email: emailController.text.trim(),
                          password: passwordController.text,
                          noTelepon: phoneController.text.trim(),
                          alamat: addressController.text.trim(),
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
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Daftar Sekarang',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, size: 20),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Sign in link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sudah punya akun? ",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(), // Atau bisa pake Get.off dengan animasi
                      child: const Text(
                        'Masuk',
                        style: TextStyle(
                          color: Color(0xFF6C63FF),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
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
