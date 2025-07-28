import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/controllers/dashboard_pegawai_controller.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/views/pengaduan/models/detail_pengaduan_model.dart';
import 'konfirmasiPopup/w_konfirmasi_terima_pengaduan.dart';
import 'konfirmasiPopup/w_konfirmasi_selesai_pengaduan.dart';
import 'konfirmasiPopup/w_konfirmasi_ajukan_approval.dart';

class WDetailPengaduan extends StatelessWidget {
  final int pengaduanId;
  
  const WDetailPengaduan({
    super.key,
    required this.pengaduanId,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardPegawaiController>();
    
    // Fetch detail pengaduan saat dialog dibuka
    controller.fetchDetailPengaduan(pengaduanId);
    
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFF1E293B),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Detail Pengaduan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Flexible(
              child: Obx(() {
                if (controller.isLoadingDetailPengaduan.value) {
                  return const SizedBox(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF10B981),
                      ),
                    ),
                  );
                }
                
                final detail = controller.detailPengaduan.value;
                if (detail == null) {
                  return const SizedBox(
                    height: 200,
                    child: Center(
                      child: Text(
                        'Data tidak ditemukan',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                }
                
                return _buildContent(detail);
              }),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildContent(DetailPengaduanModel detail) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status dan Prioritas
          Row(
            children: [
              _buildStatusChip(detail.status),
              const SizedBox(width: 8),
              if (detail.isUrgent) _buildUrgentChip(),
            ],
          ),
          const SizedBox(height: 16),
          
          // Nomor Pengaduan
          _buildInfoRow(
            'Nomor Pengaduan',
            detail.nomorPengaduan,
            Icons.confirmation_number,
          ),
          
          // Judul
          _buildInfoRow(
            'Judul',
            detail.judul,
            Icons.title,
          ),
          
          // Kategori
          _buildInfoRow(
            'Kategori',
            detail.kategoriNama,
            Icons.category,
          ),
          
          // Pelapor
          _buildInfoRow(
            'Pelapor',
            detail.pelaporNama,
            Icons.person,
          ),
          
          // Tanggal
          _buildInfoRow(
            'Tanggal Pengaduan',
            detail.tanggalPengaduan,
            Icons.calendar_today,
          ),
          
          // Lokasi
          _buildInfoRow(
            'Lokasi',
            detail.lokasi,
            Icons.location_on,
          ),
          
          // Deskripsi
          const SizedBox(height: 8),
          const Text(
            'Deskripsi',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF374151),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Text(
              detail.deskripsi,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
                height: 1.5,
              ),
            ),
          ),
          
          // Foto jika ada
          if (detail.fotoPengaduan != null) ...[
            const SizedBox(height: 16),
            const Text(
              'Foto Pengaduan',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  detail.fotoPengaduan!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
          
          const SizedBox(height: 20),
          
          // Action Buttons
          _buildActionButtons(detail),
        ],
      ),
    );
  }
  
  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;
    
    switch (status.toLowerCase()) {
      case 'menunggu':
      case 'masuk':
        backgroundColor = const Color(0xFFDDD6FE);
        textColor = const Color(0xFF7C3AED);
        break;
      case 'diproses':
        backgroundColor = const Color(0xFFDCFCE7);
        textColor = const Color(0xFF059669);
        break;
      case 'selesai':
        backgroundColor = const Color(0xFFD1FAE5);
        textColor = const Color(0xFF10B981);
        break;
      default:
        backgroundColor = const Color(0xFFF3F4F6);
        textColor = const Color(0xFF6B7280);
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
  
  Widget _buildUrgentChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFEE2E2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.priority_high,
            size: 14,
            color: Color(0xFFDC2626),
          ),
          SizedBox(width: 4),
          Text(
            'URGENT',
            style: TextStyle(
              color: Color(0xFFDC2626),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: const Color(0xFF6B7280),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF374151),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildActionButtons(DetailPengaduanModel detail) {
    return Column(
      children: [
        if (detail.canAccept) ...[
          SizedBox(
            width: double.infinity,
                         child: ElevatedButton(
               onPressed: () {
                 // Buka konfirmasi popup
                 Get.dialog(
                   WKonfirmasiTerimaPengaduan(
                     pengaduanId: detail.id,
                     nomorPengaduan: detail.nomorPengaduan,
                     judul: detail.judul,
                   ),
                 );
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
                'Terima Pengaduan',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
        

        
        if (detail.canComplete) ...[
          SizedBox(
            width: double.infinity,
                         child: ElevatedButton(
               onPressed: () {
                 // Buka konfirmasi popup selesai
                 Get.dialog(
                   WKonfirmasiSelesaiPengaduan(
                     pengaduanId: detail.id,
                     nomorPengaduan: detail.nomorPengaduan,
                     judul: detail.judul,
                   ),
                 );
               },
                             style: ElevatedButton.styleFrom(
                 padding: const EdgeInsets.symmetric(vertical: 14),
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(8),
                 ),
               ).copyWith(
                 backgroundColor: MaterialStateProperty.all(const Color(0xFF059669)),
                 foregroundColor: MaterialStateProperty.all(Colors.white),
               ),
              child: const Text(
                'Selesaikan Pengaduan',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
        
        if (detail.canRequestApproval) ...[
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Buka konfirmasi popup ajukan approval
                Get.dialog(
                  WKonfirmasiAjukanApproval(
                    pengaduanId: detail.id,
                    nomorPengaduan: detail.nomorPengaduan,
                    judul: detail.judul,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ).copyWith(
                backgroundColor: MaterialStateProperty.all(Colors.orange),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: const Text(
                'Ajukan Approval',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
        
        // Tombol Tutup
        SizedBox(
          width: double.infinity,
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
              'Tutup',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
