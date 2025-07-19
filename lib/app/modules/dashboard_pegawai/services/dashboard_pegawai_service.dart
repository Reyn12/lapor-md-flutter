import 'package:get/get.dart';
import 'package:lapor_md/app/data/network/endpoints.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/views/home/models/statistic_pegawai_model.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/views/home/models/pengaduan_prioritas_model.dart';
import 'package:lapor_md/app/modules/dashboard_pegawai/views/home/models/pengaduan_saya_tangani_model.dart';
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
}