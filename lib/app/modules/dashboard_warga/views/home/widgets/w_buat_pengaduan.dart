import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lapor_md/app/routes/app_pages.dart';

class WBuatPengaduan extends StatelessWidget {
  const WBuatPengaduan({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF6366F1), // Indigo
            Color(0xFF8B5CF6), // Purple
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {
            Get.toNamed(Routes.BUAT_PENGADUAN_WARGA);
          },
          borderRadius: BorderRadius.circular(16),
          splashColor: Colors.white.withOpacity(0.3),
          highlightColor: Colors.white.withOpacity(0.1),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Plus Icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                // Text Content
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Buat Pengaduan Baru',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Laporkan masalah di lingkungan Anda',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                // Arrow Icon
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white70,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
