import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailPengaduanCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailPengaduanCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // Judul Pengaduan
          Text(
            data['judul'] ?? 'Judul tidak tersedia',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          
          // Status dan Kategori Row
          Row(
            children: [
              _buildStatusBadge(data['status'] ?? 'unknown'),
              const SizedBox(width: 12),
              _buildKategoriBadge(data['kategori']?['nama_kategori'] ?? 'Tidak ada kategori'),
            ],
          ),
          const SizedBox(height: 24),
          
          // Info Row (Tanggal Submit & Estimasi Selesai)
          Row(
            children: [
              // Tanggal Submit
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Tanggal Submit',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDate(data['tanggal_pengaduan']),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              // Estimasi Selesai
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Estimasi Selesai',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data['estimasi_selesai'] != null 
                          ? _formatDate(data['estimasi_selesai'])
                          : 'Belum ditentukan',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Lokasi
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Lokasi',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                data['lokasi'] ?? 'Lokasi tidak tersedia',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          
          // Nomor Pengaduan (di bawah)
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.receipt_long,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Text(
                  'No. Pengaduan: ',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  data['nomor_pengaduan'] ?? 'Tidak tersedia',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4F46E5),
                  ),
                ),
              ],
            ),
          ),
        ],
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
        backgroundColor = const Color(0xFF6B7280);
        textColor = Colors.white;
        icon = Icons.pending;
        displayText = 'Menunggu';
        break;
      case 'diproses':
        backgroundColor = const Color(0xFFF59E0B);
        textColor = Colors.white;
        icon = Icons.schedule;
        displayText = 'Diproses';
        break;
      case 'selesai':
        backgroundColor = const Color(0xFF10B981);
        textColor = Colors.white;
        icon = Icons.check_circle;
        displayText = 'Selesai';
        break;
      case 'perlu_approval':
        backgroundColor = const Color(0xFF3B82F6);
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: textColor,
          ),
          const SizedBox(width: 6),
          Text(
            displayText,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKategoriBadge(String kategori) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        kategori,
        style: TextStyle(
          color: Colors.grey[700],
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'Tidak tersedia';
    
    try {
      final date = DateTime.parse(dateString);
      // Gunakan format tanpa locale spesifik
      return DateFormat('dd MMMM yyyy').format(date);
    } catch (e) {
      // Debug: print error untuk troubleshooting
      print('Error parsing date: $dateString, Error: $e');
      return 'Format tanggal salah';
    }
  }
}
