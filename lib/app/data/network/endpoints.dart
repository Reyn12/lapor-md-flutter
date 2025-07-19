class Endpoints {
  static const String baseUrl = 'http://192.168.18.77:8000';

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
  static String get dashboardWargaBuatPengaduan => '$baseUrl/api/warga/pengaduan';
  static String get dashboardWargaAmbilKategori => '$baseUrl/api/kategori';

  // Dashboard Warga - Riwayat
  static String get dashboardWargaRiwayat => '$baseUrl/api/warga/riwayat';
  static String get dashboardWargaRiwayatDetail => '$baseUrl/api/warga/pengaduan/';

  // Dashboard Warga - Notifikasi
  static String get dashboardWargaNotifikasi => '$baseUrl/api/warga/notifikasi';

  // Dashboard Warga - Profile
  static String get dashboardWargaProfile => '$baseUrl/api/warga/profile';
  static String get dashboardWargaProfileUpdate => '$baseUrl/api/warga/profile/';

  // Dashboard Pegawai
  static String get dashboardPegawaiHome => '$baseUrl/api/pegawai/home';

  // Dashboard Pegawai - Laporan
  
}