import 'package:get/get.dart';
import 'package:lapor_md/app/data/network/endpoints.dart';
import 'package:lapor_md/app/modules/dashboard_kepala_kantor/views/home/models/kepala_kantor_model.dart';
import 'package:lapor_md/app/modules/dashboard_kepala_kantor/views/home/models/executive_summary_model.dart';
import 'package:lapor_md/app/modules/dashboard_kepala_kantor/views/home/models/pengaduan_bulanan.dart';
import 'package:lapor_md/app/modules/dashboard_kepala_kantor/views/approval/models/pengaduan_model.dart';
import 'package:lapor_md/utils/storage_utils.dart';

class DashboardKepalaKantorService extends GetxService {
  
  Future<Map<String, dynamic>> fetchDataHome() async {
    try {
      // Ambil token dari storage
      final token = StorageUtils.getValue<String>('access_token');
      
      if (token == null) {
        throw Exception('Token tidak ditemukan');
      }

      // Hit API endpoint
      final response = await GetConnect().get(
        Endpoints.dashboardKepalaKantorHome,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = response.body;
        if (data['success'] == true && data['data'] != null) {
          return data['data'];
        }
      }
      return {};
    } catch (e) {
      print('Error fetching home data: $e');
      return {};
    }
  }
  
  Future<KepalaKantorModel?> fetchKepalaKantorData() async {
    try {
      final data = await fetchDataHome();
      final kepalaKantorData = data['kepala_kantor'];
      if (kepalaKantorData != null) {
        return KepalaKantorModel.fromJson(kepalaKantorData);
      }
      return null;
    } catch (e) {
      print('Error parsing kepala kantor data: $e');
      return null;
    }
  }
  
  Future<ExecutiveSummaryModel?> fetchExecutiveSummaryData() async {
    try {
      final data = await fetchDataHome();
      final executiveData = data['executive_summary'];
      if (executiveData != null) {
        return ExecutiveSummaryModel.fromJson(executiveData);
      }
      return null;
    } catch (e) {
      print('Error parsing executive summary data: $e');
      return null;
    }
  }
  
  Future<List<PengaduanBulananModel>> fetchGrafikBulananData() async {
    try {
      final data = await fetchDataHome();
      final grafikData = data['grafik_bulanan'];
      print('Debug Grafik Bulanan Data: $grafikData');
      if (grafikData != null && grafikData is List) {
        return grafikData
            .map((item) => PengaduanBulananModel.fromJson(item))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error parsing grafik bulanan data: $e');
      return [];
    }
  }

  Future<List<Pengaduan>?> fetchApprovalData() async {
    try {
      final token = StorageUtils.getValue<String>('access_token');

      if (token == null) {
        throw Exception('Token tidak ditemukan');
      }

      final response = await GetConnect().get(
        Endpoints.dashboardKepalaKantorApprovalData,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return pengaduanListFromJson(response.bodyString!);
      }
      return null;
    } catch (e) {
      print('Error fetching approval data: $e');
      return null;
    }
  }

  // Approve pengaduan
  Future<Map<String, dynamic>> approvePengaduan(int id, String catatan) async {
    try {
      final token = StorageUtils.getValue<String>('access_token');

      if (token == null) {
        throw Exception('Token tidak ditemukan');
      }

      final response = await GetConnect().post(
        Endpoints.dashboardKepalaKantorApprovalAction(id),
        {
          'catatan': catatan,
        },
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': response.body['message'] ?? 'Pengaduan berhasil disetujui',
        };
      }
      return {
        'success': false,
        'message': response.body['message'] ?? 'Gagal menyetujui pengaduan',
      };
    } catch (e) {
      print('Error approving pengaduan: $e');
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }

  // Reject pengaduan
  Future<Map<String, dynamic>> rejectPengaduan(int id, String? catatan) async {
    try {
      final token = StorageUtils.getValue<String>('access_token');

      if (token == null) {
        throw Exception('Token tidak ditemukan');
      }

      final response = await GetConnect().post(
        Endpoints.dashboardKepalaKantorApprovalReject(id),
        catatan != null && catatan.isNotEmpty ? {
          'catatan': catatan,
        } : {},
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': response.body['message'] ?? 'Pengaduan berhasil ditolak',
        };
      }
      return {
        'success': false,
        'message': response.body['message'] ?? 'Gagal menolak pengaduan',
      };
    } catch (e) {
      print('Error rejecting pengaduan: $e');
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }
}