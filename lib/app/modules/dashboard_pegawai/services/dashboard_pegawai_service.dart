import 'package:get/get.dart';
import 'package:lapor_md/app/data/network/endpoints.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/views/home/models/statistic_pegawai_model.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/views/home/models/pengaduan_prioritas_model.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/views/home/models/pengaduan_saya_tangani_model.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/views/pengaduan/models/pengaduan_pegawai_response_model.dart';
import 'package:lapor_md/utils/storage_utils.dart';

class DashboardPegawaiService extends GetxService {
  
  // Method untuk fetch home data dari API
  Future<Map<String, dynamic>> fetchHomeData() async {
    try {
      // Ambil token dari storage
      final token = StorageUtils.getValue<String>('access_token');
      
      if (token == null) {
        throw Exception('Token tidak ditemukan');
      }

      // Hit API endpoint
      final response = await GetConnect().get(
        Endpoints.dashboardPegawaiHome,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = response.body;
        
        if (responseData['success'] == true) {
          return responseData['data'];
        } else {
          throw Exception('Response tidak sukses');
        }
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
      
    } catch (e) {
      throw Exception('Gagal fetch home data: $e');
    }
  }

  // Method khusus untuk ambil statistics aja
  Future<StatisticPegawaiModel> fetchStatistics() async {
    try {
      final homeData = await fetchHomeData();
      final statisticsData = homeData['statistics'];
      
      return StatisticPegawaiModel.fromJson(statisticsData);
    } catch (e) {
      throw Exception('Gagal fetch statistics: $e');
    }
  }

  // Method khusus untuk ambil pengaduan prioritas
  Future<List<PengaduanPrioritasModel>> fetchPengaduanPrioritas() async {
    try {
      final homeData = await fetchHomeData();
      final pengaduanPrioritasData = homeData['pengaduan_prioritas'] as List;
      
      return pengaduanPrioritasData
          .map((json) => PengaduanPrioritasModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Gagal fetch pengaduan prioritas: $e');
    }
  }

  // Method khusus untuk ambil pengaduan saya tangani
  Future<List<PengaduanSayaTanganiModel>> fetchPengaduanSayaTangani() async {
    try {
      final homeData = await fetchHomeData();
      final pengaduanSayaTanganiData = homeData['pengaduan_saya_tangani'] as List;
      
      return pengaduanSayaTanganiData
          .map((json) => PengaduanSayaTanganiModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Gagal fetch pengaduan saya tangani: $e');
    }
  }

  // Method untuk fetch pengaduan data dengan filter
  Future<PengaduanPegawaiResponseModel> fetchPengaduanData({
    String status = 'masuk',
    String search = '',
    int? kategoriId,
    String? prioritas,
    String? tanggalDari,
    String? tanggalSampai,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      // Ambil token dari storage
      final token = StorageUtils.getValue<String>('access_token');
      
      if (token == null) {
        throw Exception('Token tidak ditemukan');
      }

      // Build query parameters
      final queryParams = <String, dynamic>{
        'status': status,
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (search.isNotEmpty) {
        queryParams['search'] = search;
      }
      
      if (kategoriId != null) {
        queryParams['kategori_id'] = kategoriId.toString();
      }
      
      if (prioritas != null && prioritas.isNotEmpty) {
        queryParams['prioritas'] = prioritas;
      }
      
      if (tanggalDari != null && tanggalDari.isNotEmpty) {
        queryParams['tanggal_dari'] = tanggalDari;
      }
      
      if (tanggalSampai != null && tanggalSampai.isNotEmpty) {
        queryParams['tanggal_sampai'] = tanggalSampai;
      }

      // Debug request
      print('=== DEBUG PENGADUAN API REQUEST ===');
      print('URL: ${Endpoints.dashboardPegawaiPengaduan}');
      print('Query params: $queryParams');
      print('kategori_id filter: ${queryParams['kategori_id']}');
      print('status filter: ${queryParams['status']}');
      print('search filter: ${queryParams['search']}');
      print('Token (first 20 chars): ${token.substring(0, 20)}...');
      print('===============================');

      // Hit API endpoint dengan query params
      final response = await GetConnect().get(
        Endpoints.dashboardPegawaiPengaduan,
        query: queryParams,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      print('=== DEBUG RESPONSE ===');
      print('Status: ${response.statusCode}');
      print('Headers: ${response.headers}');
      print('Body: ${response.body.toString().substring(0, 200)}...');
      print('======================');

      if (response.statusCode == 200) {
        final responseData = response.body;
        
        if (responseData['success'] == true) {
          // Debug JSON structure sebelum parsing
          print('=== DEBUG JSON STRUCTURE ===');
          final data = responseData['data'];
          print('Data keys: ${data.keys.toList()}');
          if (data['pengaduan'] != null && data['pengaduan'].isNotEmpty) {
            print('First pengaduan: ${data['pengaduan'][0]}');
          }
          if (data['tab_counts'] != null) {
            print('Tab counts: ${data['tab_counts']}');
            print('Tab counts types: masuk=${data['tab_counts']['masuk'].runtimeType}, diproses=${data['tab_counts']['diproses'].runtimeType}');
          }
          print('===========================');
          
          return PengaduanPegawaiResponseModel.fromJson(responseData['data']);
        } else {
          throw Exception('Response tidak sukses');
        }
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
      
    } catch (e) {
      throw Exception('Gagal fetch pengaduan data: $e');
    }
  }
}