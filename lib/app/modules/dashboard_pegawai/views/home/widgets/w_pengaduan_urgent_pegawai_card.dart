import 'package:flutter/material.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/views/home/models/pengaduan_prioritas_model.dart';

class WPengaduanUrgentPegawaiCard extends StatelessWidget {
  final List<PengaduanPrioritasModel> pengaduanList;
  final Function(PengaduanPrioritasModel)? onTap;

  const WPengaduanUrgentPegawaiCard({
    super.key,
    required this.pengaduanList,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (pengaduanList.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header dengan icon dan title
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFE53E3E), // Red dot
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Pengaduan Prioritas\n(Urgent/Baru)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                  height: 1.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // List pengaduan cards dengan scroll view
          Container(
            constraints: const BoxConstraints(maxHeight: 300),
            child: SingleChildScrollView(
              child: Column(
                children: pengaduanList.take(5).map((pengaduan) => _buildPengaduanCard(pengaduan)).toList(),
              ),
            ),
          ),
          
          // Show more button jika ada lebih dari 5
          if (pengaduanList.length > 5)
            Container(
              margin: const EdgeInsets.only(top: 12),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    // TODO: Navigate to full list
                  },
                  child: Text(
                    'Lihat Semua (${pengaduanList.length})',
                    style: const TextStyle(
                      color: Color(0xFF3182CE),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPengaduanCard(PengaduanPrioritasModel pengaduan) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header card dengan nomor, labels, dan icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Nomor pengaduan dan labels
              Expanded(
                child: Row(
                  children: [
                    // Nomor pengaduan
                    Text(
                      pengaduan.nomorPendek,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    const SizedBox(width: 12),
                    
                    // Label URGENT jika urgent
                    if (pengaduan.isUrgent)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE53E3E),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'URGENT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    
                    const SizedBox(width: 8),
                    
                    // Label status
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(pengaduan.status),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Tambah icon untuk status menunggu
                          if (pengaduan.status.toLowerCase() == 'menunggu')
                            const Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Icon(
                                Icons.warning,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          Text(
                            _getStatusLabel(pengaduan.status),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Icon mata untuk view detail
              GestureDetector(
                onTap: () => onTap?.call(pengaduan),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.visibility_outlined,
                    size: 20,
                    color: Color(0xFF64748B),
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Judul pengaduan
          Text(
            pengaduan.judul,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D3748),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Info pelapor dan lokasi
          Row(
            children: [
              // Icon user
              const Icon(
                Icons.person,
                size: 16,
                color: Color(0xFF64748B),
              ),
              const SizedBox(width: 6),
              Text(
                pengaduan.wargaNama,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                ),
              ),
              const SizedBox(width: 16),
              
              // Icon lokasi
              const Icon(
                Icons.location_on,
                size: 16,
                color: Color(0xFF64748B),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  pengaduan.lokasi,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Tanggal
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                size: 16,
                color: Color(0xFF64748B),
              ),
              const SizedBox(width: 6),
              Text(
                pengaduan.tanggalFormat,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'menunggu':
        return const Color(0xFFE53E3E); // Red
      case 'diproses':
        return const Color(0xFFFF8A00); // Orange
      case 'selesai':
        return const Color(0xFF38A169); // Green
      case 'perlu_approval':
        return const Color(0xFF3182CE); // Blue
      default:
        return const Color(0xFF64748B); // Grey
    }
  }

  String _getStatusLabel(String status) {
    switch (status.toLowerCase()) {
      case 'menunggu':
        return 'Menunggu';
      case 'diproses':
        return 'Diproses';
      case 'selesai':
        return 'Selesai';
      case 'perlu_approval':
        return 'Perlu Approval';
      default:
        return status;
    }
  }
}
