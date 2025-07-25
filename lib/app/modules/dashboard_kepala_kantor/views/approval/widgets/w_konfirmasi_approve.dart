import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WKonfirmasiApprove extends StatelessWidget {
  final int pengaduanId;
  final String nomorPengaduan;
  final String judul;
  final TextEditingController catatanController;
  
  const WKonfirmasiApprove({
    super.key,
    required this.pengaduanId,
    required this.nomorPengaduan,
    required this.judul,
    required this.catatanController,
  });

  @override
  Widget build(BuildContext context) {
    
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header dengan icon
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle_outline,
                      size: 32,
                      color: Color(0xFF10B981),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Approve Pengaduan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                        height: 1.5,
                      ),
                      children: [
                        const TextSpan(text: 'Kamu yakin mau approve pengaduan\n'),
                        TextSpan(
                          text: nomorPengaduan,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        const TextSpan(text: '?'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Text(
                      judul,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF374151),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Catatan Approval
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Catatan Approval (Wajib):',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF374151),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: catatanController,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            hintText: 'Tambahkan catatan untuk approval...',
                            hintStyle: TextStyle(fontSize: 12),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            border: OutlineInputBorder(),
                          ),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  const Text(
                    'Pengaduan yang diapprove akan dilanjutkan ke tahap implementasi.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF9CA3AF),
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Action Buttons
            Container(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  // Tombol Batal
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF6B7280),
                        side: const BorderSide(color: Color(0xFFE5E7EB)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Batal',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Tombol Approve
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (catatanController.text.trim().isEmpty) {
                          Get.snackbar(
                            'Perhatian',
                            'Catatan approval wajib diisi',
                            backgroundColor: Colors.amber,
                            colorText: Colors.white,
                          );
                          return;
                        }
                        
                        Get.back(result: {
                          'action': 'approve',
                          'id': pengaduanId,
                          'catatan': catatanController.text,
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ).copyWith(
                        backgroundColor: MaterialStateProperty.all(const Color(0xFF10B981)),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                      ),
                      child: const Text(
                        'Ya, Approve',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}