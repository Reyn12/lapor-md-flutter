import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimelineStatusPengaduan extends StatelessWidget {
  final Map<String, dynamic> data;

  const TimelineStatusPengaduan({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final timeline = data['timeline'] as List<dynamic>? ?? [];
    
    // Jangan tampilkan widget jika timeline kosong
    if (timeline.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header dengan icon
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.check_circle_outline,
                  color: Color(0xFF10B981),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Timeline Status',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Timeline items
          ...timeline.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isLast = index == timeline.length - 1;
            
            return _buildTimelineItem(
              item: item,
              isLast: isLast,
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required Map<String, dynamic> item,
    required bool isLast,
  }) {
    final status = item['status']?.toString().toLowerCase() ?? '';
    final timelineData = _getTimelineData(status);
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline indicator
        Column(
          children: [
            // Icon circle
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: timelineData['color'].withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: timelineData['color'],
                  width: 2,
                ),
              ),
              child: Icon(
                timelineData['icon'],
                color: timelineData['color'],
                size: 20,
              ),
            ),
            // Vertical line (jika bukan item terakhir)
            if (!isLast)
              Container(
                width: 2,
                height: 60,
                color: Colors.grey[300],
                margin: const EdgeInsets.only(top: 8),
              ),
          ],
        ),
        const SizedBox(width: 16),
        
        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                timelineData['title'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              
              // Timestamp
              Text(
                _formatDateTime(item['tanggal']),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              
              // Description
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Text(
                  item['keterangan'] ?? 'Tidak ada keterangan',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
              ),
              
              // Dibuat oleh (jika ada)
              if (item['dibuat_oleh'] != null) ...[
                const SizedBox(height: 6),
                Text(
                  'oleh ${item['dibuat_oleh']}',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
              
              // Bottom spacing
              if (!isLast) const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Map<String, dynamic> _getTimelineData(String status) {
    switch (status) {
      case 'menunggu':
        return {
          'title': 'Pengaduan Dibuat',
          'icon': Icons.calendar_today,
          'color': const Color(0xFF6B7280),
        };
      case 'diterima':
        return {
          'title': 'Diterima oleh Pegawai',
          'icon': Icons.assignment_turned_in,
          'color': const Color(0xFF3B82F6),
        };
      case 'diproses':
        return {
          'title': 'Sedang Diproses',
          'icon': Icons.flash_on,
          'color': const Color(0xFFF59E0B),
        };
      case 'selesai':
        return {
          'title': 'Pengaduan Selesai',
          'icon': Icons.check_circle,
          'color': const Color(0xFF10B981),
        };
      case 'ditolak':
        return {
          'title': 'Pengaduan Ditolak',
          'icon': Icons.cancel,
          'color': const Color(0xFFEF4444),
        };
      case 'perlu_approval':
        return {
          'title': 'Menunggu Persetujuan',
          'icon': Icons.pending,
          'color': const Color(0xFF8B5CF6),
        };
      default:
        return {
          'title': 'Status Update',
          'icon': Icons.info,
          'color': const Color(0xFF6B7280),
        };
    }
  }

  String _formatDateTime(String? dateTimeString) {
    if (dateTimeString == null) return 'Waktu tidak tersedia';
    
    try {
      final dateTime = DateTime.parse(dateTimeString);
      // Gunakan format tanpa locale spesifik
      final dateFormat = DateFormat('dd MMMM yyyy, HH:mm');
      return dateFormat.format(dateTime);
    } catch (e) {
      // Debug: print error untuk troubleshooting
      print('Error parsing date: $dateTimeString, Error: $e');
      return 'Format waktu salah';
    }
  }
}
