import 'package:flutter/material.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/views/home/models/pengaduan_saya_tangani_model.dart';

class WAktifitasTerbaruPegawaiCard extends StatelessWidget {
  final List<PengaduanSayaTanganiModel> aktivitasList;
  final Function(PengaduanSayaTanganiModel)? onTap;

  const WAktifitasTerbaruPegawaiCard({
    super.key,
    required this.aktivitasList,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (aktivitasList.isEmpty) {
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
              // Icon trending up
              const Icon(
                Icons.trending_up,
                color: Color(0xFF3182CE),
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'Aktivitas Terbaru',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // List aktivitas dengan scroll view
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxHeight: 200),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: aktivitasList.take(5).map((aktivitas) => _buildAktivitasCard(aktivitas)).toList(),
              ),
            ),
          ),
          
          // Show more button jika ada lebih dari 5
          if (aktivitasList.length > 5)
            Container(
              margin: const EdgeInsets.only(top: 12),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    // TODO: Navigate to full list
                  },
                  child: Text(
                    'Lihat Semua (${aktivitasList.length})',
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

  Widget _buildAktivitasCard(PengaduanSayaTanganiModel aktivitas) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () => onTap?.call(aktivitas),
        child: Container(
          decoration: BoxDecoration(
            color: _getBackgroundColor(aktivitas.statusColor),
            borderRadius: BorderRadius.circular(8),
            border: Border(
              left: BorderSide(
                color: _getBorderColor(aktivitas.statusColor),
                width: 4,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title dengan nomor pengaduan dan status
                Text(
                  'Pengaduan ${aktivitas.nomorPendek} ${aktivitas.statusLabel}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _getTextColor(aktivitas.statusColor),
                  ),
                ),
                const SizedBox(height: 4),
                
                // Subtitle dengan judul dan waktu
                Text(
                  '${aktivitas.judul} - ${aktivitas.waktuRelatif}',
                  style: TextStyle(
                    fontSize: 12,
                    color: _getSubtitleColor(aktivitas.statusColor),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper methods untuk warna
  Color _getBackgroundColor(String statusColor) {
    switch (statusColor) {
      case 'green':
        return const Color(0xFFE8F5E8); // Light green
      case 'blue':
        return const Color(0xFFE3F2FD); // Light blue
      case 'red':
        return const Color(0xFFFEE8E8); // Light red
      default:
        return const Color(0xFFF7FAFC); // Light grey
    }
  }

  Color _getBorderColor(String statusColor) {
    switch (statusColor) {
      case 'green':
        return const Color(0xFF38A169); // Green
      case 'blue':
        return const Color(0xFF3182CE); // Blue
      case 'red':
        return const Color(0xFFE53E3E); // Red
      default:
        return const Color(0xFF64748B); // Grey
    }
  }

  Color _getTextColor(String statusColor) {
    switch (statusColor) {
      case 'green':
        return const Color(0xFF2D5530); // Dark green
      case 'blue':
        return const Color(0xFF2A4A6B); // Dark blue
      case 'red':
        return const Color(0xFF822727); // Dark red
      default:
        return const Color(0xFF2D3748); // Dark grey
    }
  }

  Color _getSubtitleColor(String statusColor) {
    switch (statusColor) {
      case 'green':
        return const Color(0xFF4A5D4F); // Medium green
      case 'blue':
        return const Color(0xFF4A5D7A); // Medium blue
      case 'red':
        return const Color(0xFF7A4A4A); // Medium red
      default:
        return const Color(0xFF64748B); // Medium grey
    }
  }
}
