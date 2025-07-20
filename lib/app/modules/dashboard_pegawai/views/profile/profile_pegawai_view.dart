import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/dashboard_pegawai_controller.dart';
import '../home/widgets/w_logout_button.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/views/profile/models/profile_pegawai_model.dart';

class ProfilePegawaiView extends StatelessWidget {
  const ProfilePegawaiView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardPegawaiController>();
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 20,
              left: 20,
              right: 20,
              bottom: 24,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1E293B), // Dark blue-gray
                  Color(0xFF334155), // Slightly lighter dark gray
                ],
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile Pegawai',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Kelola profil kamu',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: Obx(() {
              if (controller.isLoadingProfile.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final profile = controller.profilePegawai.value;
              if (profile == null) {
                return const Center(child: Text('Data profile tidak ada'));
              }
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.07),
                            blurRadius: 16,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 32,
                                backgroundColor: Colors.grey[300],
                                child: Icon(Icons.person, size: 40, color: Colors.grey[700]),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(profile.nama, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                    Text(profile.email, style: TextStyle(color: Colors.grey[700])),
                                    Text('NIP: ${profile.nip}', style: TextStyle(color: Colors.grey[700], fontSize: 12)),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  showDialog(
                                    context: Get.context!,
                                    builder: (ctx) => _EditProfileDialog(profile: profile, onSave: (data) {
                                      controller.updateProfilePegawai(data);
                                    }),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          _ProfileItem(label: 'NIK', value: profile.nik),
                          _ProfileItem(label: 'No Telepon', value: profile.noTelepon),
                          _ProfileItem(label: 'Alamat', value: profile.alamat),
                          _ProfileItem(label: 'Role', value: profile.role),
                          _ProfileItem(label: 'Tanggal Bergabung', value: profile.tanggalBergabung),
                          _ProfileItem(label: 'Waktu Bergabung', value: profile.waktuBergabung),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Center(child: WLogoutButton()),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// Tambah widget item profile
class _ProfileItem extends StatelessWidget {
  final String label;
  final String value;
  const _ProfileItem({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label, style: TextStyle(color: Colors.grey[600]))),
          Expanded(child: Text(value, style: TextStyle(fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}

// Tambah dialog edit profile
class _EditProfileDialog extends StatefulWidget {
  final ProfilePegawaiModel profile;
  final Function(Map<String, dynamic>) onSave;
  const _EditProfileDialog({required this.profile, required this.onSave});
  @override
  State<_EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<_EditProfileDialog> {
  late TextEditingController namaC;
  late TextEditingController nipC;
  late TextEditingController noTelpC;
  late TextEditingController alamatC;

  @override
  void initState() {
    super.initState();
    namaC = TextEditingController(text: widget.profile.nama);
    nipC = TextEditingController(text: widget.profile.nip);
    noTelpC = TextEditingController(text: widget.profile.noTelepon);
    alamatC = TextEditingController(text: widget.profile.alamat);
  }

  @override
  void dispose() {
    namaC.dispose();
    nipC.dispose();
    noTelpC.dispose();
    alamatC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.edit, color: Colors.blue, size: 22),
                  const SizedBox(width: 8),
                  Text('Edit Profile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ],
              ),
            ),
            const SizedBox(height: 18),
            _CustomTextField(controller: namaC, label: 'Nama', icon: Icons.person),
            const SizedBox(height: 12),
            _CustomTextField(controller: nipC, label: 'NIP', icon: Icons.badge),
            const SizedBox(height: 12),
            _CustomTextField(controller: noTelpC, label: 'No Telepon', icon: Icons.phone),
            const SizedBox(height: 12),
            _CustomTextField(controller: alamatC, label: 'Alamat', icon: Icons.home),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close, color: Colors.grey[700]),
                    label: Text('Batal', style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w600)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      elevation: 1,
                      shadowColor: Colors.grey[100],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.18),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        widget.onSave({
                          'nama': namaC.text,
                          'nip': nipC.text,
                          'no_telepon': noTelpC.text,
                          'alamat': alamatC.text,
                        });
                      },
                      icon: Icon(Icons.save, color: Colors.white),
                      label: Text('Simpan', style: TextStyle(fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Custom TextField biar lebih konsisten style
class _CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  const _CustomTextField({required this.controller, required this.label, required this.icon});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blue),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
