import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class PreviewPengaduan extends StatelessWidget {
  final String kategori;
  final String judul;
  final String deskripsi;
  final String lokasi;
  final File? foto;
  final VoidCallback onKirim;

  const PreviewPengaduan({
    Key? key,
    required this.kategori,
    required this.judul,
    required this.deskripsi,
    required this.lokasi,
    this.foto,
    required this.onKirim,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF8B5CF6), Color(0xFFA855F7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.visibility,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Preview Pengaduan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kategori
                    _buildPreviewItem(
                      icon: Icons.category,
                      title: 'Kategori',
                      content: kategori,
                    ),
                    SizedBox(height: 16),

                    // Judul
                    _buildPreviewItem(
                      icon: Icons.title,
                      title: 'Judul Pengaduan',
                      content: judul,
                    ),
                    SizedBox(height: 16),

                    // Deskripsi
                    _buildPreviewItem(
                      icon: Icons.description,
                      title: 'Deskripsi Detail',
                      content: deskripsi,
                      isMultiline: true,
                    ),
                    SizedBox(height: 16),

                    // Lokasi
                    _buildPreviewItem(
                      icon: Icons.location_on,
                      title: 'Lokasi Kejadian',
                      content: lokasi,
                    ),
                    
                    // Foto jika ada
                    if (foto != null) ...[
                      SizedBox(height: 16),
                      _buildFotoPreview(),
                    ],
                  ],
                ),
              ),
            ),

            // Actions
            Container(
              padding: EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.grey[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                      ),
                      child: Text(
                        'Edit Kembali',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: onKirim,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF8B5CF6),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.send, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'Kirim Pengaduan',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewItem({
    required IconData icon,
    required String title,
    required String content,
    bool isMultiline = false,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Color(0xFF8B5CF6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  icon,
                  color: Color(0xFF8B5CF6),
                  size: 16,
                ),
              ),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
              height: isMultiline ? 1.4 : 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFotoPreview() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Color(0xFF8B5CF6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  Icons.image,
                  color: Color(0xFF8B5CF6),
                  size: 16,
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Foto Pendukung',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              foto!,
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
