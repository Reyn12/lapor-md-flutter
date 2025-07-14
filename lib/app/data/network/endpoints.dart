class Endpoints {
  static const String baseUrl = 'https://api.example.com';

  // Auth
  static const String login = '$baseUrl/auth/login';
  static const String register = '$baseUrl/auth/register';
  static const String refreshToken = '$baseUrl/auth/refresh-token';
  static const String logout = '$baseUrl/auth/logout';

  // User
  static const String getUser = '$baseUrl/user/me';
  static const String updateUser = '$baseUrl/user/me';
  static const String changePassword = '$baseUrl/user/change-password';
  static const String forgotPassword = '$baseUrl/user/forgot-password';
  
}