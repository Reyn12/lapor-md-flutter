class Endpoints {
  static const String baseUrl = 'http://192.168.18.77:8000';

  // ifconfig en0
  // 192.168.18.77

  // laravel server
  // php artisan serve --host=0.0.0.0

  // Auth
  static String get login => '$baseUrl/api/auth/login';
  static String get register => '$baseUrl/api/auth/register';

  // Dashboard Warga
  static String get dashboardWargaHome => '$baseUrl/api/warga/home';

  static String get refreshToken => '$baseUrl/api/auth/refresh-token';
  static String get logout => '$baseUrl/api/auth/logout';

  // User
  static String get getUser => '$baseUrl/api/user/me';
  static String get updateUser => '$baseUrl/api/user/me';
  static String get changePassword => '$baseUrl/api/user/change-password';
  static String get forgotPassword => '$baseUrl/api/user/forgot-password';
  
}