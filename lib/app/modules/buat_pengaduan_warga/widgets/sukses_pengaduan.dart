import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuksesPengaduan extends StatelessWidget {
  final String message;
  final VoidCallback? onSelesai;

  const SuksesPengaduan({
    Key? key,
    this.message = 'Pengaduan berhasil dikirim!',
    this.onSelesai,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 40),
            
            // Success Icon with Animation
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 40,
                ),
              ),
            ),
            
            SizedBox(height: 24),
            
            // Title
            Text(
              'Berhasil!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            
            SizedBox(height: 12),
            
            // Message
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),
            ),
            
            SizedBox(height: 8),
            
            // Sub message
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Pengaduan kamu akan segera diproses oleh tim kami.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                  height: 1.3,
                ),
              ),
            ),
            
            SizedBox(height: 32),
            
            // Info Card
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF8B5CF6).withOpacity(0.1), Color(0xFFA855F7).withOpacity(0.05)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFF8B5CF6).withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xFF8B5CF6).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.info_outline,
                      color: Color(0xFF8B5CF6),
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Status Pengaduan',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF8B5CF6),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Kamu bisa cek status di menu Riwayat',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 32),
            
            // Actions
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back(); // Close dialog
                        if (onSelesai != null) {
                          onSelesai!();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.grey[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                      ),
                      child: Text(
                        'Tutup',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back(); // Close dialog
                        // Navigate to riwayat page
                        Get.offAllNamed('/dashboard-warga', arguments: {'tab': 'riwayat'});
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF8B5CF6),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.history, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'Lihat Riwayat',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // Static method untuk mudah dipanggil
  static void show({
    String? message,
    VoidCallback? onSelesai,
  }) {
    Get.dialog(
      SuksesPengaduan(
        message: message ?? 'Pengaduan berhasil dikirim!',
        onSelesai: onSelesai,
      ),
      barrierDismissible: false,
    );
  }
}
