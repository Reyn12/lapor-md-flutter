import 'package:get/get.dart';
import 'package:lapor_md/app/data/network/endpoints.dart';
import 'package:lapor_md/utils/storage_utils.dart';
import '../models/kategori_model.dart';

class BuatPengaduanWargaService {
  
  Future<List<KategoriModel>?> fetchKategori() async {
    try {
      final accessToken = StorageUtils.getValue<String>('access_token');
      
      final response = await GetConnect().get(
        Endpoints.dashboardWargaAmbilKategori,
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final responseData = response.body;
        if (responseData['success'] == true) {
          final List<dynamic> kategoris = responseData['data']['kategoris'];
          return kategoris.map((json) => KategoriModel.fromJson(json)).toList();
        }
      }
      return null;
    } catch (e) {
      print('Error fetching kategori: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> fetchBuatPengaduan({
    required int kategoriId,
    required String judul,
    required String deskripsi,
    required String lokasi,
    String? foto,
  }) async {
    try {
      final accessToken = StorageUtils.getValue<String>('access_token');
      
      final formData = FormData({
        'kategori_id': kategoriId.toString(),
        'judul': judul,
        'deskripsi': deskripsi,
        'lokasi': lokasi,
      });

      // Add foto if provided
      if (foto != null) {
        formData.files.add(
          MapEntry(
            'foto_pengaduan',
            MultipartFile(foto, filename: foto.split('/').last),
          ),
        );
      }

      final response = await GetConnect().post(
        Endpoints.dashboardWargaBuatPengaduan,
        formData,
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      }
      return null;
    } catch (e) {
      print('Error buat pengaduan: $e');
      return null;
    }
  }
}