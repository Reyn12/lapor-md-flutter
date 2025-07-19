import 'package:flutter/material.dart';
import '../models/pengaduan_pegawai_model.dart';

class WCardListPengaduan extends StatelessWidget {
  final List<PengaduanPegawaiModel> pengaduanList;
  final String currentStatus;
  final Function(PengaduanPegawaiModel) onDetailTap;
  final Function(PengaduanPegawaiModel, String) onActionTap; // Tambah action type

  const WCardListPengaduan({
    super.key,
    required this.pengaduanList,
    required this.currentStatus,
    required this.onDetailTap,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    if (pengaduanList.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.inbox_outlined,
                size: 64,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Text(
                'Tidak ada pengaduan',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: pengaduanList.length,
      itemBuilder: (context, index) {
        final pengaduan = pengaduanList[index];
        return _buildPengaduanCard(context, pengaduan);
      },
    );
  }

  Widget _buildPengaduanCard(BuildContext context, PengaduanPegawaiModel pengaduan) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                // Nomor Pengaduan
                Text(
                  _formatNomorPengaduan(pengaduan.nomorPengaduan),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 8),
                
                // Priority Badge
                _buildPriorityBadge(pengaduan),
                const SizedBox(width: 8),
                
                // Kategori
                _buildKategoriBadge(pengaduan.kategori.namaKategori),
                
                const Spacer(),
                
                // View Icon Only
                GestureDetector(
                  onTap: () => onDetailTap(pengaduan),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.visibility_outlined,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Judul
            Text(
              pengaduan.judul,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Info Row
            Row(
              children: [
                const Icon(Icons.person_outline, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  pengaduan.warga.nama,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.calendar_today_outlined, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  _formatDate(pengaduan.tanggalPengaduan),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            
            const SizedBox(height: 4),
            
            // Lokasi
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    pengaduan.lokasi,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
                         // Deskripsi
             Text(
               pengaduan.deskripsi.length > 120 
                   ? '${pengaduan.deskripsi.substring(0, 120)}...'
                   : pengaduan.deskripsi,
               style: const TextStyle(
                 fontSize: 14,
                 color: Colors.black54,
                 height: 1.4,
               ),
             ),
             
             // Action Button untuk status masuk (menunggu)
             if (currentStatus == 'masuk')
               _buildMenungguActionSection(pengaduan),
             
             // Catatan Pegawai (hanya untuk status diproses)
             if (currentStatus == 'diproses' && pengaduan.catatanPegawai != null && pengaduan.catatanPegawai!.isNotEmpty)
               _buildCatatanPegawai(pengaduan.catatanPegawai!),
             
             // Update Status Section (untuk status diproses)
             if (currentStatus == 'diproses')
               _buildUpdateStatusSection(pengaduan),
               
             // Status Selesai - hanya info 
             if (currentStatus == 'selesai')
               _buildSelesaiStatusSection(pengaduan),
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityBadge(PengaduanPegawaiModel pengaduan) {
    // Tentukan prioritas berdasarkan isUrgent dan kategori
    String priority;
    
    if (pengaduan.isUrgent) {
      priority = 'URGENT';
    } else if (pengaduan.kategori.namaKategori.toLowerCase().contains('infrastruktur') ||
               pengaduan.kategori.namaKategori.toLowerCase().contains('keamanan')) {
      priority = 'HIGH';
    } else if (pengaduan.kategori.namaKategori.toLowerCase().contains('kebersihan') ||
               pengaduan.kategori.namaKategori.toLowerCase().contains('lingkungan')) {
      priority = 'MEDIUM';
    } else {
      priority = 'LOW';
    }
    
    Color bgColor;
    String label;
    
    switch (priority.toLowerCase()) {
      case 'urgent':
        bgColor = const Color(0xFFEF4444);
        label = 'URGENT';
        break;
      case 'high':
        bgColor = const Color(0xFFF97316);
        label = 'HIGH';
        break;
      case 'medium':
        bgColor = const Color(0xFFF59E0B);
        label = 'MEDIUM';
        break;
      case 'low':
        bgColor = const Color(0xFF10B981);
        label = 'LOW';
        break;
      default:
        bgColor = const Color(0xFF6B7280);
        label = 'NORMAL';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }



  Widget _buildCatatanPegawai(String catatan) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEBF8FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Catatan: ',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E40AF),
            ),
          ),
          Text(
            catatan,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF1E40AF),
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenungguActionSection(PengaduanPegawaiModel pengaduan) {
    // Debug permissions untuk status menunggu
    print('=== DEBUG MENUNGGU PERMISSIONS ===');
    print('Pengaduan: ${pengaduan.nomorPengaduan}');
    print('canAccept: ${pengaduan.canAccept}');
    print('canUpdateProgress: ${pengaduan.canUpdateProgress}');
    print('canComplete: ${pengaduan.canComplete}');
    print('=================================');
    
    // Untuk status menunggu, show button Terima atau Tolak
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          // Button Tolak
          Expanded(
            child: OutlinedButton(
              onPressed: () => onActionTap(pengaduan, 'reject'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFEF4444),
                side: const BorderSide(color: Color(0xFFEF4444)),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Tolak',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Button Terima
          Expanded(
            child: ElevatedButton(
              onPressed: pengaduan.canAccept 
                  ? () => onActionTap(pengaduan, 'accept')
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: pengaduan.canAccept 
                    ? const Color(0xFF4F46E5)
                    : Colors.grey[400],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Terima',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelesaiStatusSection(PengaduanPegawaiModel pengaduan) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFECFDF5), // Light green background
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF10B981), width: 1),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Color(0xFF10B981),
            size: 20,
          ),
          const SizedBox(width: 8),
          const Text(
            'Pengaduan telah selesai',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF047857),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateStatusSection(PengaduanPegawaiModel pengaduan) {
    // Debug permissions
    print('=== DEBUG PERMISSIONS ===');
    print('Pengaduan: ${pengaduan.nomorPengaduan}');
    print('canUpdateProgress: ${pengaduan.canUpdateProgress}');
    print('canComplete: ${pengaduan.canComplete}');
    print('canAccept: ${pengaduan.canAccept}');
    print('========================');
    
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Update Status:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              // Button Update Progress - hanya jika canUpdateProgress
              if (pengaduan.canUpdateProgress)
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => onActionTap(pengaduan, 'update_progress'),
                    icon: const Icon(Icons.edit_outlined, size: 16),
                    label: const Text('Update Progress'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      side: const BorderSide(color: Colors.grey),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              
              // Spacing jika ada kedua button
              if (pengaduan.canUpdateProgress)
                const SizedBox(width: 12),
              
              // Button Selesai - selalu muncul untuk status diproses
              Expanded(
                child: ElevatedButton(
                  onPressed: pengaduan.canComplete 
                      ? () => onActionTap(pengaduan, 'complete')
                      : null, // Disable jika tidak bisa complete
                  style: ElevatedButton.styleFrom(
                    backgroundColor: pengaduan.canComplete 
                        ? const Color(0xFF10B981)
                        : Colors.grey[400],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Selesai',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: pengaduan.canComplete ? Colors.white : Colors.grey[600],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
    } catch (e) {
      return isoDate.substring(0, 10); // Fallback
    }
  }

  String _formatNomorPengaduan(String nomorPengaduan) {
    try {
      // Format: PGD-20250716-0001 → #001
      if (nomorPengaduan.contains('PGD-')) {
        final parts = nomorPengaduan.split('-');
        if (parts.length >= 3) {
          return '#${parts.last}';
        }
      }
      // Fallback: ambil 4 karakter terakhir sebagai nomor
      return '#${nomorPengaduan.substring(nomorPengaduan.length - 4)}';
    } catch (e) {
      return '#${nomorPengaduan.hashCode.abs().toString().substring(0, 3).padLeft(3, '0')}';
    }
  }

  Widget _buildKategoriBadge(String kategori) {
    Color backgroundColor;
    Color textColor;
    
    // Assign warna berdasarkan kategori
    switch (kategori.toLowerCase()) {
      case 'infrastruktur':
        backgroundColor = const Color(0xFF3B82F6); // Biru
        textColor = Colors.white;
        break;
      case 'keamanan':
        backgroundColor = const Color(0xFFEF4444); // Merah
        textColor = Colors.white;
        break;
      case 'kebersihan':
        backgroundColor = const Color(0xFF10B981); // Hijau
        textColor = Colors.white;
        break;
      case 'fasilitas umum':
        backgroundColor = const Color(0xFF8B5CF6); // Ungu
        textColor = Colors.white;
        break;
      case 'lingkungan':
        backgroundColor = const Color(0xFF059669); // Hijau tua
        textColor = Colors.white;
        break;
      default:
        backgroundColor = const Color(0xFF6B7280); // Abu-abu
        textColor = Colors.white;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        kategori,
        style: TextStyle(
          fontSize: 12,
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
