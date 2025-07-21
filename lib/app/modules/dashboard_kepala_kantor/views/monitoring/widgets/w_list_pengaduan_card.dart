import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../views/monitoring/models/pengaduan_list_model.dart';

class WListPengaduanCard extends StatelessWidget {
  final MonitoringPengaduan pengaduan;

  const WListPengaduanCard({super.key, required this.pengaduan});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.withOpacity(0.1), width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // Header section with status & priority badges
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nomor Pengaduan
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pengaduan.nomorPengaduan,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        pengaduan.judul,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                // Status Badge
                _buildStatusBadge(pengaduan.status),
              ],
            ),
            const SizedBox(height: 12),
            
            // Detail information
            _buildInfoRow(
              Icons.category, 
              'Kategori: ${pengaduan.kategori}',
              Colors.purple.shade700
            ),
            const SizedBox(height: 8),
            
            _buildInfoRow(
              Icons.person, 
              'Pelapor: ${pengaduan.wargaNama}',
              Colors.blue.shade700
            ),
            const SizedBox(height: 8),
            
            _buildInfoRow(
              Icons.assignment_ind, 
              'Petugas: ${pengaduan.pegawaiNama ?? "Belum ditugaskan"}',
              Colors.orange
            ),
            const SizedBox(height: 8),
            
            _buildInfoRow(
              Icons.location_on, 
              pengaduan.lokasi,
              Colors.green.shade700
            ),
            const SizedBox(height: 8),
            
            _buildInfoRow(
              Icons.date_range, 
              'Tanggal Laporan: ${DateFormat('dd MMM yyyy').format(pengaduan.tanggalPengaduan)}',
              Colors.indigo
            ),
            
            // Progress bar
            const SizedBox(height: 16),
            _buildProgressSection(
              pengaduan.progress.persentase,
              pengaduan.progress.statusText
            ),
            
            // Bottom section - Priority badge
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPriorityBadge(pengaduan.prioritas),
                Text(
                  'Dibuat: ${DateFormat('dd MMM yyyy').format(pengaduan.createdAt)}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color badgeColor;
    
    switch (status.toLowerCase()) {
      case 'menunggu':
        badgeColor = Colors.amber;
        break;
      case 'diproses':
        badgeColor = Colors.blue;
        break;
      case 'selesai':
        badgeColor = Colors.green;
        break;
      case 'ditolak':
        badgeColor = Colors.red;
        break;
      default:
        badgeColor = Colors.grey;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: badgeColor, width: 1),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: badgeColor,
        ),
      ),
    );
  }
  
  Widget _buildPriorityBadge(String priority) {
    Color badgeColor;
    
    switch (priority.toLowerCase()) {
      case 'high':
        badgeColor = Colors.red;
        break;
      case 'medium':
        badgeColor = Colors.orange;
        break;
      case 'low':
        badgeColor = Colors.green;
        break;
      default:
        badgeColor = Colors.grey;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: badgeColor, width: 1),
      ),
      child: Text(
        'Prioritas: ${priority[0].toUpperCase() + priority.substring(1).toLowerCase()}',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: badgeColor,
        ),
      ),
    );
  }
  
  Widget _buildInfoRow(IconData icon, String text, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: color,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildProgressSection(int percentage, String statusText) {
    Color progressColor;
    
    if (percentage < 30) {
      progressColor = Colors.red;
    } else if (percentage < 70) {
      progressColor = Colors.orange;
    } else {
      progressColor = Colors.green;
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            Text(
              '$percentage%',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: progressColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            minHeight: 8,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          statusText,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}