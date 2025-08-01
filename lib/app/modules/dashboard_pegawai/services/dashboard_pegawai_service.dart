import 'package:get/get.dart';
import 'package:lapor_md/app/data/network/endpoints.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/views/home/models/statistic_pegawai_model.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/views/home/models/pengaduan_prioritas_model.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/views/home/models/pengaduan_saya_tangani_model.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/views/pengaduan/models/pengaduan_pegawai_response_model.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/views/pengaduan/models/detail_pengaduan_model.dart';
import 'package:lapor_md/utils/storage_utils.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/views/profile/models/profile_pegawai_model.dart';

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
      if (response.body != null) {
        final bodyStr = response.body.toString();
        print('Body (first 300 chars): ${bodyStr.length > 300 ? bodyStr.substring(0, 300) : bodyStr}...');
      }
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
            print('Tab counts types: menunggu=${data['tab_counts']['masuk'].runtimeType}, diproses=${data['tab_counts']['diproses'].runtimeType}');
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

  // Method untuk fetch detail pengaduan by ID
  Future<DetailPengaduanModel> fetchDetailPengaduan(int pengaduanId) async {
    try {
      // Ambil token dari storage
      final token = StorageUtils.getValue<String>('access_token');
      
      if (token == null) {
        throw Exception('Token tidak ditemukan');
      }

      // Debug request
      print('=== DEBUG DETAIL PENGADUAN API REQUEST ===');
      print('URL: ${Endpoints.dashboardPegawaiPengaduanDetail}$pengaduanId');
      print('Pengaduan ID: $pengaduanId');
      print('Token (first 20 chars): ${token.substring(0, 20)}...');
      print('==========================================');

      // Hit API endpoint detail pengaduan
      final response = await GetConnect().get(
        '${Endpoints.dashboardPegawaiPengaduanDetail}$pengaduanId',
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      print('=== DEBUG DETAIL RESPONSE ===');
      print('Status: ${response.statusCode}');
      if (response.body != null) {
        final bodyStr = response.body.toString();
        print('Body (first 500 chars): ${bodyStr.length > 500 ? bodyStr.substring(0, 500) : bodyStr}...');
      }
      print('=============================');

      if (response.statusCode == 200) {
        final responseData = response.body;
        
        if (responseData['success'] == true) {
          return DetailPengaduanModel.fromJson(responseData['data']);
        } else {
          throw Exception('Response tidak sukses');
        }
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
      
    } catch (e) {
      throw Exception('Gagal fetch detail pengaduan: $e');
    }
  }

  // Method untuk terima pengaduan by ID
  Future<Map<String, dynamic>> acceptPengaduan(int pengaduanId) async {
    try {
      // Ambil token dari storage
      final token = StorageUtils.getValue<String>('access_token');
      
      if (token == null) {
        throw Exception('Token tidak ditemukan');
      }

      // Debug request
      print('=== DEBUG ACCEPT PENGADUAN API REQUEST ===');
      print('URL: ${Endpoints.dashboardPegawaiPengaduanAccept(pengaduanId)}');
      print('Pengaduan ID: $pengaduanId');
      print('Token (first 20 chars): ${token.substring(0, 20)}...');
      print('==========================================');

      // Hit API endpoint accept pengaduan dengan POST method
      final response = await GetConnect().post(
        Endpoints.dashboardPegawaiPengaduanAccept(pengaduanId),
        {},
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      print('=== DEBUG ACCEPT RESPONSE ===');
      print('Status: ${response.statusCode}');
      if (response.body != null) {
        final bodyStr = response.body.toString();
        print('Body (first 500 chars): ${bodyStr.length > 500 ? bodyStr.substring(0, 500) : bodyStr}...');
      }
      print('=============================');

      if (response.statusCode == 200) {
        final responseData = response.body;
        
        if (responseData['success'] == true) {
          return responseData;
        } else {
          throw Exception(responseData['message'] ?? 'Response tidak sukses');
        }
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
      
    } catch (e) {
      throw Exception('Gagal terima pengaduan: $e');
    }
  }

  // Method untuk selesaikan pengaduan by ID
  Future<Map<String, dynamic>> completePengaduan(int pengaduanId, String catatanPenyelesaian) async {
    try {
      // Ambil token dari storage
      final token = StorageUtils.getValue<String>('access_token');
      
      if (token == null) {
        throw Exception('Token tidak ditemukan');
      }

      // Debug request
      print('=== DEBUG COMPLETE PENGADUAN API REQUEST ===');
      print('URL: ${Endpoints.dashboardPegawaiPengaduanSelesaikan(pengaduanId)}');
      print('Pengaduan ID: $pengaduanId');
      print('Token (first 20 chars): ${token.substring(0, 20)}...');
      print('============================================');

      // Hit API endpoint complete pengaduan dengan POST method
      final response = await GetConnect().post(
        Endpoints.dashboardPegawaiPengaduanSelesaikan(pengaduanId),
        {
          'catatan_penyelesaian': catatanPenyelesaian,
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      print('=== DEBUG COMPLETE RESPONSE ===');
      print('Status: ${response.statusCode}');
      if (response.body != null) {
        final bodyStr = response.body.toString();
        print('Body (first 500 chars): ${bodyStr.length > 500 ? bodyStr.substring(0, 500) : bodyStr}...');
      }
      print('===============================');

      if (response.statusCode == 200) {
        final responseData = response.body;
        
        if (responseData['success'] == true) {
          return responseData;
        } else {
          throw Exception(responseData['message'] ?? 'Response tidak sukses');
        }
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
      
    } catch (e) {
      throw Exception('Gagal selesaikan pengaduan: $e');
    }
  }

  // Fetch profile pegawai
  Future<ProfilePegawaiModel> fetchProfilePegawai() async {
    try {
      final token = StorageUtils.getValue<String>('access_token');
      if (token == null) throw Exception('Token tidak ditemukan');
      final response = await GetConnect().get(
        Endpoints.dashboardPegawaiProfile,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200 && response.body['success'] == true) {
        return ProfilePegawaiModel.fromJson(response.body['data']);
      } else {
        throw Exception('Gagal ambil profile pegawai');
      }
    } catch (e) {
      throw Exception('Gagal fetch profile pegawai: $e');
    }
  }

  // Update profile pegawai
  Future<ProfilePegawaiModel> updateProfilePegawai(Map<String, dynamic> data) async {
    try {
      final token = StorageUtils.getValue<String>('access_token');
      if (token == null) throw Exception('Token tidak ditemukan');
      final response = await GetConnect().put(
        Endpoints.dashboardPegawaiProfile,
        data,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200 && response.body['success'] == true) {
        return ProfilePegawaiModel.fromJson(response.body['data']);
      } else {
        throw Exception(response.body['message'] ?? 'Gagal update profile pegawai');
      }
    } catch (e) {
      throw Exception('Gagal update profile pegawai: $e');
    }
  }

  // Method untuk ajukan approval pengaduan
  Future<Map<String, dynamic>> ajukanApprovalPengaduan(int pengaduanId) async {
    try {
      // Ambil token dari storage
      final token = StorageUtils.getValue<String>('access_token');
      
      if (token == null) {
        throw Exception('Token tidak ditemukan');
      }

      // Debug request
      print('=== DEBUG AJUKAN APPROVAL API REQUEST ===');
      print('URL: ${Endpoints.dashboardPegawaiAjukanApproval(pengaduanId)}');
      print('Pengaduan ID: $pengaduanId');
      print('Token (first 20 chars): ${token.substring(0, 20)}...');
      print('==========================================');

      // Hit API endpoint ajukan approval dengan POST method
      final response = await GetConnect().post(
        Endpoints.dashboardPegawaiAjukanApproval(pengaduanId),
        {},
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      print('=== DEBUG AJUKAN APPROVAL RESPONSE ===');
      print('Status: ${response.statusCode}');
      if (response.body != null) {
        final bodyStr = response.body.toString();
        print('Body (first 500 chars): ${bodyStr.length > 500 ? bodyStr.substring(0, 500) : bodyStr}...');
      }
      print('======================================');

      if (response.statusCode == 200) {
        final responseData = response.body;
        
        if (responseData['success'] == true) {
          return responseData;
        } else {
          throw Exception(responseData['message'] ?? 'Response tidak sukses');
        }
      } else {
        final errorBody = response.body;
        throw Exception(errorBody['message'] ?? 'HTTP Error: ${response.statusCode}');
      }
      
    } catch (e) {
      throw Exception('Gagal ajukan approval pengaduan: $e');
    }
  }
}