import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lapor_md/app/data/network/endpoints.dart';
import 'package:lapor_md/app/modules/dashboard_warga/views/home/models/statistics_model.dart';
import 'package:lapor_md/app/modules/dashboard_warga/views/home/models/recent_pengaduan_model.dart';
import 'package:lapor_md/app/modules/dashboard_warga/views/home/models/recent_notifikasi_model.dart';
import 'package:lapor_md/utils/storage_utils.dart';

class DashboardWargaService {
  static Future<Map<String, dynamic>> fetchDataHome() async {
    try {
      // Ambil access token dari storage
      final accessToken = StorageUtils.getValue<String>('access_token');
      
      final response = await http.get(
        Uri.parse(Endpoints.dashboardWargaHome),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        
        if (jsonData['success'] == true) {
          final data = jsonData['data'];
          
          // Parse statistics
          final statistics = StatisticsModel.fromJson(data['statistics']);
          
          // Parse recent pengaduan
          final List<RecentPengaduanModel> recentPengaduan = 
              (data['recent_pengaduan'] as List)
                  .map((item) => RecentPengaduanModel.fromJson(item))
                  .toList();
          
          // Parse recent notifikasi
          final List<RecentNotifikasiModel> recentNotifikasi = 
              (data['recent_notifikasi'] as List)
                  .map((item) => RecentNotifikasiModel.fromJson(item))
                  .toList();

          return {
            'success': true,
            'statistics': statistics,
            'recent_pengaduan': recentPengaduan,
            'recent_notifikasi': recentNotifikasi,
          };
        } else {
          return {
            'success': false,
            'message': 'Data tidak berhasil dimuat',
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  static Future<Map<String, dynamic>> fetchDataRiwayat({String? status}) async {
    try {
      // Ambil access token dari storage
      final accessToken = StorageUtils.getValue<String>('access_token');
      
      // Build URL dengan query params kalau ada status
      String url = Endpoints.dashboardWargaRiwayat;
      if (status != null && status != 'semua') {
        url += '?status=$status';
      }
      
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        
        if (jsonData['success'] == true) {
          return {
            'success': true,
            'data': jsonData['data'],
          };
        } else {
          return {
            'success': false,
            'message': 'Data riwayat tidak berhasil dimuat',
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  static Future<Map<String, dynamic>> fetchNotifikasiData({
    String? status,
    int? page,
    int? limit,
  }) async {
    try {
      // Ambil access token dari storage
      final accessToken = StorageUtils.getValue<String>('access_token');
      
      // Build URL dengan query params
      String url = Endpoints.dashboardWargaNotifikasi;
      List<String> queryParams = [];
      
      if (status != null && status != 'semua') {
        queryParams.add('status=$status');
      }
      if (page != null) {
        queryParams.add('page=$page');
      }
      if (limit != null) {
        queryParams.add('limit=$limit');
      }
      
      if (queryParams.isNotEmpty) {
        url += '?${queryParams.join('&')}';
      }
      
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        
        if (jsonData['success'] == true) {
          return {
            'success': true,
            'data': jsonData['data'],
          };
        } else {
          return {
            'success': false,
            'message': 'Data notifikasi tidak berhasil dimuat',
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }
}
