class Endpoints {
  static const String baseUrl = 'http://192.168.1.8:8000';

  // ifconfig en0
  // 192.168.18.77

  // laravel server
  // php artisan serve --host=0.0.0.0

  // Auth
  static String get login => '$baseUrl/api/auth/login';
  static String get register => '$baseUrl/api/auth/register';
  static String get refreshToken => '$baseUrl/api/auth/refresh-token';
  static String get logout => '$baseUrl/api/auth/logout';

  // Dashboard Warga
  static String get dashboardWargaHome => '$baseUrl/api/warga/home';
  static String get dashboardWargaBuatPengaduan =>
      '$baseUrl/api/warga/pengaduan';
  static String get dashboardWargaAmbilKategori => '$baseUrl/api/kategori';

  // Dashboard Warga - Riwayat
  static String get dashboardWargaRiwayat => '$baseUrl/api/warga/riwayat';
  static String get dashboardWargaRiwayatDetail =>
      '$baseUrl/api/warga/pengaduan/';

  // Dashboard Warga - Notifikasi
  static String get dashboardWargaNotifikasi => '$baseUrl/api/warga/notifikasi';

  // Dashboard Warga - Profile
  static String get dashboardWargaProfile => '$baseUrl/api/warga/profile';
  static String get dashboardWargaProfileUpdate =>
      '$baseUrl/api/warga/profile/';

  // Dashboard Pegawai
  static String get dashboardPegawaiHome => '$baseUrl/api/pegawai/home';
  static String get dashboardPegawaiPengaduan =>
      '$baseUrl/api/pegawai/pengaduan';
  static String get dashboardPegawaiPengaduanDetail =>
      '$baseUrl/api/pegawai/pengaduan/';
  static String dashboardPegawaiPengaduanAccept(int id) =>
      '$baseUrl/api/pegawai/pengaduan/$id/terima';
  static String dashboardPegawaiAjukanApproval(int id) =>
      '$baseUrl/api/pegawai/pengaduan/$id/ajukan-approval';
  static String dashboardPegawaiPengaduanSelesaikan(int id) =>
      '$baseUrl/api/pegawai/pengaduan/$id/selesai';
  static String get dashboardPegawaiProfile => '$baseUrl/api/pegawai/profile';

  // Dashboard Kepala Kantor - Home
  static String get dashboardKepalaKantorHome =>
      '$baseUrl/api/kepala-kantor/home';

  // Dashboard Kepala Kantor - Approval Data
  static String get dashboardKepalaKantorApprovalData =>
      '$baseUrl/api/kepala-kantor/approval';

  // Dashboard Kepala Kantor - Approval Action
  static String dashboardKepalaKantorApprovalAction(int id) =>
      '$baseUrl/api/kepala-kantor/pengaduan/$id/approve';
  static String dashboardKepalaKantorApprovalReject(int id) =>
      '$baseUrl/api/kepala-kantor/pengaduan/$id/reject';

  // Dashboard Kepala Kantor - Monitoring Data
  static String get dashboardKepalaKantorMonitoringData =>
      '$baseUrl/api/kepala-kantor/monitoring';

  // Dashboard Kepala Kantor - Laporan
  static String get dashboardKepalaKantorLaporan =>
      '$baseUrl/api/kepala-kantor/laporan';

  // Dashboard Kepala Kantor - Profile
  static String get dashboardKepalaKantorProfile =>
      '$baseUrl/api/kepala-kantor/profile';
}
