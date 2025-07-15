import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../data/network/endpoints.dart';
import '../models/user_model.dart';

class AuthService {
  // Method untuk login
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      print('📤 Login Request to: ${Endpoints.login}');
      print('📤 Data: {"email": "$email", "password": "***"}');

      final response = await http.post(
        Uri.parse(Endpoints.login),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      print('📥 Response: ${response.statusCode} ${response.body}');

      if (response.statusCode == 200) {
        // Parse response langsung dari API
        final data = jsonDecode(response.body);
        return data;
      } else if (response.statusCode == 401) {
        // Parse error response dari API
        final data = jsonDecode(response.body);
        return data;
      } else if (response.statusCode == 422) {
        return {
          'success': false,
          'message': 'Data tidak valid',
        };
      } else if (response.statusCode == 500) {
        return {
          'success': false,
          'message': 'Server error, coba lagi nanti',
        };
      } else {
        return {
          'success': false,
          'message': 'Login gagal: ${response.reasonPhrase}',
        };
      }
    } catch (e) {
      print('❌ Error: $e');
      String errorMessage = 'Terjadi kesalahan koneksi';
      
      if (e.toString().contains('SocketException')) {
        errorMessage = 'Tidak ada koneksi internet';
      } else if (e.toString().contains('TimeoutException')) {
        errorMessage = 'Koneksi timeout, coba lagi';
      }

      return {
        'success': false,
        'message': errorMessage,
      };
    }
  }

  // Method untuk register (bonus)
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      print('📤 Register Request to: ${Endpoints.register}');
      print('📤 Data: {"name": "$name", "email": "$email", "password": "***"}');

      final response = await http.post(
        Uri.parse(Endpoints.register),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
        }),
      );

      print('📥 Response: ${response.statusCode} ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse response langsung dari API
        final data = jsonDecode(response.body);
        return data;
      } else if (response.statusCode == 422) {
        // Parse error response dari API
        final data = jsonDecode(response.body);
        return data;
      } else if (response.statusCode == 400) {
        return {
          'success': false,
          'message': 'Data tidak valid',
        };
      } else {
        return {
          'success': false,
          'message': 'Registrasi gagal: ${response.reasonPhrase}',
        };
      }
    } catch (e) {
      print('❌ Error: $e');
      return {
        'success': false,
        'message': 'Terjadi kesalahan koneksi',
      };
    }
  }
}
