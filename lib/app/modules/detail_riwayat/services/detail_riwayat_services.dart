import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lapor_md/app/data/network/endpoints.dart';
import 'package:lapor_md/utils/storage_utils.dart';

class DetailRiwayatServices {
  static Future<Map<String, dynamic>> fetchDetailRiwayat(int pengaduanId) async {
    try {
      // Ambil access token dari storage
      final accessToken = StorageUtils.getValue<String>('access_token');
      
      final response = await http.get(
        Uri.parse('${Endpoints.dashboardWargaRiwayatDetail}$pengaduanId'),
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
            'message': 'Detail pengaduan tidak berhasil dimuat',
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
