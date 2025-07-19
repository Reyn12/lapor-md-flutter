import 'package:flutter/material.dart';

class WSearchFilterBar extends StatefulWidget {
  final String searchQuery;
  final int? selectedKategoriId;
  final String? selectedPrioritas;
  final String? tanggalDari;
  final String? tanggalSampai;
  final Function(String) onSearchChanged;
  final Function({
    int? kategoriId,
    String? prioritas,
    String? tanggalDari,
    String? tanggalSampai,
  }) onFilterApplied;

  const WSearchFilterBar({
    super.key,
    required this.searchQuery,
    this.selectedKategoriId,
    this.selectedPrioritas,
    this.tanggalDari,
    this.tanggalSampai,
    required this.onSearchChanged,
    required this.onFilterApplied,
  });

  @override
  State<WSearchFilterBar> createState() => _WSearchFilterBarState();
}

class _WSearchFilterBarState extends State<WSearchFilterBar> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.searchQuery);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          // Search Field
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: widget.onSearchChanged,
                decoration: const InputDecoration(
                  hintText: 'Cari pengaduan...',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Filter Button
          GestureDetector(
            onTap: _showFilterDialog,
            child: Container(
              padding: const EdgeInsets.all(12),
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
              child: const Icon(
                Icons.filter_list,
                color: Colors.grey,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => _FilterDialog(
        selectedKategoriId: widget.selectedKategoriId,
        selectedPrioritas: widget.selectedPrioritas,
        tanggalDari: widget.tanggalDari,
        tanggalSampai: widget.tanggalSampai,
        onFilterApplied: widget.onFilterApplied,
      ),
    );
  }
}

class _FilterDialog extends StatefulWidget {
  final int? selectedKategoriId;
  final String? selectedPrioritas;
  final String? tanggalDari;
  final String? tanggalSampai;
  final Function({
    int? kategoriId,
    String? prioritas,
    String? tanggalDari,
    String? tanggalSampai,
  }) onFilterApplied;

  const _FilterDialog({
    this.selectedKategoriId,
    this.selectedPrioritas,
    this.tanggalDari,
    this.tanggalSampai,
    required this.onFilterApplied,
  });

  @override
  State<_FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<_FilterDialog> {
  int? _selectedKategoriId;
  String? _selectedPrioritas;
  String? _tanggalDari;
  String? _tanggalSampai;

  // Data kategori (sesuai dengan API)
  final List<Map<String, dynamic>> _kategoriList = [
    {'id': null, 'nama': 'Semua Kategori'},
    {'id': 1, 'nama': 'Infrastruktur'},
    {'id': 2, 'nama': 'Fasilitas Umum'},
    {'id': 3, 'nama': 'Keamanan'}, // Sesuai API response
    {'id': 4, 'nama': 'Kebersihan'},
    {'id': 5, 'nama': 'Lingkungan'},
  ];

  // Data prioritas
  final List<Map<String, dynamic>> _prioritasList = [
    {'value': null, 'label': 'Semua Prioritas'},
    {'value': 'urgent', 'label': 'Urgent'},
    {'value': 'high', 'label': 'High'},
    {'value': 'medium', 'label': 'Medium'},
    {'value': 'low', 'label': 'Low'},
  ];

  @override
  void initState() {
    super.initState();
    _selectedKategoriId = widget.selectedKategoriId;
    _selectedPrioritas = widget.selectedPrioritas;
    _tanggalDari = widget.tanggalDari;
    _tanggalSampai = widget.tanggalSampai;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.filter_list, color: Colors.black87),
                    SizedBox(width: 8),
                    Text(
                      'Filter Pengaduan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.grey),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Kategori Dropdown
            const Text(
              'Kategori',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            _buildKategoriDropdown(),
            
            const SizedBox(height: 20),
            
            // Prioritas Dropdown
            const Text(
              'Prioritas',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            _buildPrioritasDropdown(),
            
            const SizedBox(height: 20),
            
            // Rentang Tanggal
            const Text(
              'Rentang Tanggal',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                // Tanggal Dari
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Dari', style: TextStyle(fontSize: 14, color: Colors.grey)),
                      const SizedBox(height: 4),
                      _buildDateField(
                        value: _tanggalDari,
                        hint: 'dd/mm/yyyy',
                        onTap: () => _selectDate(true),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Tanggal Sampai
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Sampai', style: TextStyle(fontSize: 14, color: Colors.grey)),
                      const SizedBox(height: 4),
                      _buildDateField(
                        value: _tanggalSampai,
                        hint: 'dd/mm/yyyy',
                        onTap: () => _selectDate(false),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // Buttons
            Row(
              children: [
                // Reset Button
                Expanded(
                  child: OutlinedButton(
                    onPressed: _resetFilter,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Reset',
                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Apply Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: _applyFilter,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4F46E5),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Terapkan Filter',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKategoriDropdown() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int?>(
          value: _selectedKategoriId,
          hint: const Text('Semua Kategori', style: TextStyle(color: Colors.grey)),
          isExpanded: true,
          items: _kategoriList.map((kategori) {
            return DropdownMenuItem<int?>(
              value: kategori['id'],
              child: Text(kategori['nama']),
            );
          }).toList(),
          onChanged: (value) {
            print('Kategori dropdown changed to: $value');
            setState(() {
              _selectedKategoriId = value;
            });
            print('_selectedKategoriId updated to: $_selectedKategoriId');
          },
        ),
      ),
    );
  }

  Widget _buildPrioritasDropdown() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String?>(
          value: _selectedPrioritas,
          hint: const Text('Pilih prioritas', style: TextStyle(color: Colors.grey)),
          isExpanded: true,
          items: _prioritasList.map((prioritas) {
            return DropdownMenuItem<String?>(
              value: prioritas['value'],
              child: Text(prioritas['label']),
            );
          }).toList(),
          onChanged: (value) {
            print('Prioritas dropdown changed to: $value');
            setState(() {
              _selectedPrioritas = value;
            });
            print('_selectedPrioritas updated to: $_selectedPrioritas');
          },
        ),
      ),
    );
  }

  Widget _buildDateField({
    required String? value,
    required String hint,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value ?? hint,
              style: TextStyle(
                color: value != null ? Colors.black87 : Colors.grey,
              ),
            ),
            Icon(Icons.calendar_today, color: Colors.grey[600], size: 20),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final formattedDate = '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
      setState(() {
        if (isFromDate) {
          _tanggalDari = formattedDate;
        } else {
          _tanggalSampai = formattedDate;
        }
      });
    }
  }

  void _resetFilter() {
    print('=== RESET FILTER ===');
    setState(() {
      _selectedKategoriId = null;
      _selectedPrioritas = null;
      _tanggalDari = null;
      _tanggalSampai = null;
    });
    print('After reset - kategoriId: $_selectedKategoriId');
    print('After reset - prioritas: $_selectedPrioritas');
    print('==================');
  }

  void _applyFilter() {
    print('=== APPLY FILTER ===');
    print('Selected kategoriId: $_selectedKategoriId');
    print('Selected prioritas: $_selectedPrioritas');
    print('Selected tanggalDari: $_tanggalDari');
    print('Selected tanggalSampai: $_tanggalSampai');
    print('==================');
    
    widget.onFilterApplied(
      kategoriId: _selectedKategoriId,
      prioritas: _selectedPrioritas,
      tanggalDari: _tanggalDari,
      tanggalSampai: _tanggalSampai,
    );
    Navigator.pop(context);
  }
}
