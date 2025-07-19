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
          // Tab Masuk
          Expanded(
            child: _buildTabItem(
              label: 'Masuk',
              count: tabCounts?.masuk ?? 0,
              isActive: selectedStatus == 'masuk',
              onTap: () => onTabChanged('masuk'),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Tab Diproses
          Expanded(
            child: _buildTabItem(
              label: 'Diproses',
              count: tabCounts?.diproses ?? 0,
              isActive: selectedStatus == 'diproses',
              onTap: () => onTabChanged('diproses'),
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
