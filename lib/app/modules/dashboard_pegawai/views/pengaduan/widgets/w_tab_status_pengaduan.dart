import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/tab_counts_model.dart';

class WTabStatusPengaduan extends StatelessWidget {
  final String selectedStatus;
  final TabCountsModel? tabCounts;
  final Function(String) onTabChanged;

  const WTabStatusPengaduan({
    super.key,
    required this.selectedStatus,
    this.tabCounts,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          // Tab Menunggu  
          Expanded(
            child: _buildTabItem(
              label: 'Menunggu',
              count: tabCounts?.masuk ?? 0, // API return field 'masuk' untuk status menunggu
              isActive: selectedStatus == 'masuk',
              onTap: () => onTabChanged('masuk'), // Kirim 'masuk' ke API, bukan 'menunggu'
            ),
          ),
          
          const SizedBox(width: 8),
          
          // Tab Diproses
          Expanded(
            child: _buildTabItem(
              label: 'Diproses',
              count: tabCounts?.diproses ?? 0,
              isActive: selectedStatus == 'diproses',
              onTap: () => onTabChanged('diproses'),
            ),
          ),

          const SizedBox(width: 8),
          
          // Tab Selesai
          Expanded(
            child: _buildTabItem(
              label: 'Selesai', 
              count: tabCounts?.selesai ?? 0, // Dari API response selesai field
              isActive: selectedStatus == 'selesai',
              onTap: () => onTabChanged('selesai'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem({
    required String label,
    required int count,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFEF4444) : Colors.grey[300],
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            '$label ($count)',
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey[600],
              fontSize: 14,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
