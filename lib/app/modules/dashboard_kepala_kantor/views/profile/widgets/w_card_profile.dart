import 'package:flutter/material.dart';
import 'package:lapor_md/app/modules/dashboard_kepala_kantor/views/profile/models/kepala_kantor_model.dart' as profile;

class CardProfile extends StatelessWidget {
  final profile.KepalaKantorModel? profileData;
  final bool isLoading;

  const CardProfile({
    Key? key,
    required this.profileData,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    profileData?.nama ?? 'Nama tidak tersedia',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    profileData?.jabatan ?? 'Jabatan tidak tersedia',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _buildProfileItem(Icons.badge, 'NIP', profileData?.nip),
                _buildProfileItem(Icons.credit_card, 'NIK', profileData?.nik),
                _buildProfileItem(Icons.email, 'Email', profileData?.email),
                _buildProfileItem(Icons.phone, 'No Telepon', profileData?.noTelepon),
                _buildProfileItem(Icons.location_on, 'Alamat', profileData?.alamat),
              ],
            ),
    );
  }

  Widget _buildProfileItem(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue, size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  value ?? 'Tidak tersedia',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}