import 'package:flutter/material.dart';
import 'package:lapor_md/app/modules/dashboard_warga/views/riwayat/models/pengaduan_data_model.dart';
import 'package:intl/intl.dart';

class RiwayatPengaduanCard extends StatelessWidget {
  final PengaduanDataModel pengaduan;
  final VoidCallback? onTap;

  const RiwayatPengaduanCard({
    super.key,
    required this.pengaduan,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _getCardBackgroundColor(pengaduan.status),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header (nomor + status)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  pengaduan.nomorPengaduan,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4F46E5),
                  ),
                ),
                _buildStatusBadge(pengaduan.status),
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
            
            // Kategori dan tanggal
            Row(
              children: [
                Icon(
                  Icons.category_outlined,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  pengaduan.kategori.namaKategori,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.schedule,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  _formatDate(pengaduan.tanggalPengaduan),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            // Lokasi
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    pengaduan.lokasi,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            
            // Arrow icon
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color backgroundColor;
    Color textColor;
    IconData icon;
    String displayText;

    switch (status.toLowerCase()) {
      case 'menunggu':
        backgroundColor = const Color(0xFF6B7280); // Gray
        textColor = Colors.white;
        icon = Icons.pending;
        displayText = 'Menunggu';
        break;
      case 'diproses':
        backgroundColor = const Color(0xFFF59E0B); // Orange
        textColor = Colors.white;
        icon = Icons.schedule;
        displayText = 'Diproses';
        break;
      case 'selesai':
        backgroundColor = const Color(0xFF10B981); // Green
        textColor = Colors.white;
        icon = Icons.check_circle;
        displayText = 'Selesai';
        break;
      case 'perlu_approval':
        backgroundColor = const Color(0xFF3B82F6); // Blue
        textColor = Colors.white;
        icon = Icons.approval;
        displayText = 'Perlu Approval';
        break;
      default:
        backgroundColor = const Color(0xFF6B7280);
        textColor = Colors.white;
        icon = Icons.help;
        displayText = status;
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
            displayText,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
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
      case 'diproses':
        return const Color(0xFFFEF3C7); // Light orange
      case 'perlu_approval':
        return const Color(0xFFDBEAFE); // Light blue
      case 'menunggu':
        return const Color(0xFFF3F4F6); // Light gray
      default:
        return const Color(0xFFF9FAFB); // Very light gray
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Hari ini';
    } else if (difference.inDays == 1) {
      return '1 hari lalu';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} hari lalu';
    } else {
      return DateFormat('dd MMM yyyy').format(date);
    }
  }
}
