import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/buat_pengaduan_warga_controller.dart';

class BuatPengaduanWargaView extends GetView<BuatPengaduanWargaController> {
  const BuatPengaduanWargaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 24, right: 24, top: MediaQuery.of(context).padding.top + 10,
            bottom: 20,),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF8B5CF6), Color(0xFFA855F7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  textAlign: TextAlign.center,
                  'Form Pengaduan Baru',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Form Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kategori Pengaduan
                    Text(
                      'Kategori Pengaduan *',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 8),
                    Obx(() => Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          isExpanded: true,
                          hint: Text(
                            'Pilih kategori pengaduan',
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                          value: controller.selectedKategori.value?.id,
                          items: controller.listKategori.map((kategori) {
                            return DropdownMenuItem<int>(
                              value: kategori.id,
                              child: Text(kategori.namaKategori),
                            );
                          }).toList(),
                          onChanged: (value) {
                            final selected = controller.listKategori
                                .firstWhere((k) => k.id == value);
                            controller.selectedKategori.value = selected;
                          },
                        ),
                      ),
                    )),
                    
                    SizedBox(height: 24),
                    
                    // Judul Pengaduan
                    Text(
                      'Judul Pengaduan *',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: controller.judulController,
                      decoration: InputDecoration(
                        hintText: 'Masukkan judul pengaduan yang jelas',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFF8B5CF6), width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Judul pengaduan wajib diisi';
                        }
                        return null;
                      },
                    ),
                    
                    SizedBox(height: 24),
                    
                    // Deskripsi Detail
                    Text(
                      'Deskripsi Detail *',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: controller.deskripsiController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Jelaskan detail pengaduan Anda dengan lengkap...',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFF8B5CF6), width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Deskripsi detail wajib diisi';
                        }
                        return null;
                      },
                    ),
                    
                    SizedBox(height: 24),
                    
                    // Lokasi Kejadian
                    Text(
                      'Lokasi Kejadian *',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller.lokasiController,
                            decoration: InputDecoration(
                              hintText: 'Masukkan alamat lengkap lokasi',
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Color(0xFF8B5CF6), width: 2),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Lokasi kejadian wajib diisi';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 12),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Color(0xFF8B5CF6).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Color(0xFF8B5CF6).withOpacity(0.3)),
                          ),
                          child: Icon(
                            Icons.location_on,
                            color: Color(0xFF8B5CF6),
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 24),
                    
                    // Upload Foto
                    Text(
                      'Upload Foto Pendukung',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 8),
                    Obx(() => GestureDetector(
                      onTap: controller.pickImage,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        width: double.infinity,
                        height: controller.selectedImage.value != null ? 200 : 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Color(0xFF8B5CF6).withOpacity(0.3),
                            style: BorderStyle.solid,
                            width: 2,
                          ),
                        ),
                        child: controller.selectedImage.value != null
                            ? Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      controller.selectedImage.value!,
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: controller.removeImage,
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cloud_upload_outlined,
                                    color: Color(0xFF8B5CF6),
                                    size: 40,
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    'Pilih Foto',
                                    style: TextStyle(
                                      color: Color(0xFF8B5CF6),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'PNG, JPG hingga 5MB',
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      'Browse Files',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    )),
                    
                    SizedBox(height: 32),
                    
                    // Preview Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: controller.previewPengaduan,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF8B5CF6),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.visibility, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Preview Pengaduan',
                              style: TextStyle(
                                fontSize: 16,
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
            ),
          ),
        ],
      ),
    );
  }
}
