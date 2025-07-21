import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lapor_md/app/modules/dashboard_kepala_kantor/controllers/dashboard_kepala_kantor_controller.dart';
import 'package:lapor_md/app/modules/dashboard_kepala_kantor/views/profile/models/kepala_kantor_model.dart'
    as profile;

class EditProfileButton extends StatelessWidget {
  final profile.KepalaKantorModel? profileData;

  const EditProfileButton({Key? key, this.profileData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton.icon(
        onPressed: () => _showEditProfileModal(context),
        icon: const Icon(Icons.edit, size: 20, color: Colors.white),
        label: const Text(
          'Edit Profil',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 2,
        ),
      ),
    );
  }

  void _showEditProfileModal(BuildContext context) {
    final controller = Get.find<DashboardKepalaKantorController>();

    // Controllers untuk form fields
    final namaController = TextEditingController(text: profileData?.nama ?? '');
    final emailController = TextEditingController(
      text: profileData?.email ?? '',
    );
    final noTeleponController = TextEditingController(
      text: profileData?.noTelepon ?? '',
    );
    final alamatController = TextEditingController(
      text: profileData?.alamat ?? '',
    );
    final passwordController = TextEditingController();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text(
                  'Edit Profil',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField('Nama Lengkap', namaController, Icons.person),
              _buildTextField('Email', emailController, Icons.email),
              _buildTextField('No. Telepon', noTeleponController, Icons.phone),
              _buildTextField(
                'Alamat',
                alamatController,
                Icons.location_on,
                maxLines: 3,
              ),
              _buildTextField(
                'Password',
                passwordController,
                Icons.lock,
                isPassword: true,
                hintText: 'Masukkan password untuk konfirmasi',
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black87,
                      ),
                      child: const Text('Batal'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed:
                          () => _updateProfile(
                            controller,
                            namaController.text,
                            emailController.text,
                            noTeleponController.text,
                            alamatController.text,
                            passwordController.text,
                          ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text(
                        'Simpan',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    IconData icon, {
    bool isPassword = false,
    int maxLines = 1,
    String? hintText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            obscureText: isPassword,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: Icon(icon, color: Colors.blue),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateProfile(
    DashboardKepalaKantorController controller,
    String nama,
    String email,
    String noTelepon,
    String alamat,
    String password,
  ) async {
    // Validasi fields
    if (nama.isEmpty ||
        email.isEmpty ||
        noTelepon.isEmpty ||
        alamat.isEmpty ||
        password.isEmpty) {
      Get.snackbar(
        'Error',
        'Semua field harus diisi',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Close modal first
    Get.back();

    // Call update API
    final result = await controller.updateProfileData(
      nama: nama,
      email: email,
      noTelepon: noTelepon,
      alamat: alamat,
      password: password,
    );

    // Show result
    Get.snackbar(
      result['success'] ? 'Berhasil' : 'Error',
      result['message'],
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: result['success'] ? Colors.green : Colors.red,
      colorText: Colors.white,
    );
  }
}
