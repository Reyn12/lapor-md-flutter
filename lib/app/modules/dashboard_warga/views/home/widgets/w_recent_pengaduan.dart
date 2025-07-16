import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lapor_md/app/modules/dashboard_warga/controllers/dashboard_warga_controller.dart';

class WRecentPengaduan extends StatelessWidget {
  final DashboardWargaController controller;
  
  const WRecentPengaduan({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Section
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF4F46E5),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Status Pengaduan Terbaru',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
                     // Content
           SizedBox(
             height: 300,
             child: Obx(() {
               if (controller.isLoadingHome.value) {
                 return _buildLoadingList();
               }
               
               if (controller.recentPengaduan.isEmpty) {
                 return _buildEmptyState();
               }
               
               return _buildPengaduanList();
             }),
           ),
        ],
      ),
    );
  }

  Widget _buildPengaduanList() {
    // Limit maksimal 10 items
    final limitedPengaduan = controller.recentPengaduan.take(10).toList();
    
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: limitedPengaduan
              .map((pengaduan) => _buildPengaduanCard(pengaduan))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildPengaduanCard(dynamic pengaduan) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: _getCardBackgroundColor(pengaduan.status),
        borderRadius: BorderRadius.circular(12),
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.05),
        child: InkWell(
          onTap: () {
            print('Pengaduan ${pengaduan.nomorPengaduan} diklik');
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
          children: [
            // Left Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nomor Pengaduan + Status
                  Row(
                    children: [
                      Text(
                        pengaduan.nomorPengaduan,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF374151),
                        ),
                      ),
                      const SizedBox(width: 12),
                      _buildStatusBadge(pengaduan.status),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Judul
                  Text(
                    pengaduan.judul,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF111827),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Waktu Relatif
                  Text(
                    pengaduan.waktuRelatif,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
            // Arrow Icon
            const Icon(
              Icons.chevron_right,
              color: Color(0xFF9CA3AF),
              size: 20,
            ),
          ],
        ),
      ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color backgroundColor;
    Color textColor;
    IconData icon;
    
    switch (status.toLowerCase()) {
      case 'selesai':
        backgroundColor = const Color(0xFF10B981); // Green
        textColor = Colors.white;
        icon = Icons.check_circle;
        break;
      case 'disetujui':
        backgroundColor = const Color(0xFF34D399); // Light Green
        textColor = Colors.white;
        icon = Icons.verified;
        break;
      case 'diproses':
        backgroundColor = const Color(0xFFF59E0B); // Orange
        textColor = Colors.white;
        icon = Icons.schedule;
        break;
      case 'perlu_approval':
        backgroundColor = const Color(0xFF3B82F6); // Blue
        textColor = Colors.white;
        icon = Icons.approval;
        break;
      case 'ditolak':
        backgroundColor = const Color(0xFFEF4444); // Red
        textColor = Colors.white;
        icon = Icons.cancel;
        break;
      case 'menunggu':
        backgroundColor = const Color(0xFF6B7280); // Gray
        textColor = Colors.white;
        icon = Icons.pending;
        break;
      default:
        backgroundColor = const Color(0xFF6B7280);
        textColor = Colors.white;
        icon = Icons.help;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: textColor,
          ),
          const SizedBox(width: 4),
          Text(
            status,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getCardBackgroundColor(String status) {
    switch (status.toLowerCase()) {
      case 'selesai':
        return const Color(0xFFECFDF5); // Light green
      case 'disetujui':
        return const Color(0xFFD1FAE5); // Very light green
      case 'diproses':
        return const Color(0xFFFEF3C7); // Light orange
      case 'perlu_approval':
        return const Color(0xFFDBEAFE); // Light blue
      case 'ditolak':
        return const Color(0xFFFEE2E2); // Light red
      case 'menunggu':
        return const Color(0xFFF3F4F6); // Light gray
      default:
        return const Color(0xFFF9FAFB); // Very light gray
    }
  }

  Widget _buildLoadingList() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: List.generate(3, (index) => _buildLoadingCard()),
      ),
    );
  }

  Widget _buildLoadingCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 70,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 18,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: 80,
            height: 14,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.description_outlined,
              size: 48,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Belum Ada Pengaduan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Belum ada pengaduan yang dibuat.\nSilakan buat pengaduan baru.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
