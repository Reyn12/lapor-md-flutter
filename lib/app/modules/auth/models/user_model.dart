class User {
  final int id;
  final String nama;
  final String email;
  final String? emailVerifiedAt;
  final String noTelepon;
  final String alamat;
  final String role;
  final String? fotoProfil;
  final String? accessExpiresAt;
  final String? refreshExpiresAt;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.nama,
    required this.email,
    this.emailVerifiedAt,
    required this.noTelepon,
    required this.alamat,
    required this.role,
    this.fotoProfil,
    this.accessExpiresAt,
    this.refreshExpiresAt,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor untuk parsing dari JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nama: json['nama'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      noTelepon: json['no_telepon'],
      alamat: json['alamat'],
      role: json['role'],
      fotoProfil: json['foto_profil'],
      accessExpiresAt: json['access_expires_at'],
      refreshExpiresAt: json['refresh_expires_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  // Method untuk convert ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'no_telepon': noTelepon,
      'alamat': alamat,
      'role': role,
      'foto_profil': fotoProfil,
      'access_expires_at': accessExpiresAt,
      'refresh_expires_at': refreshExpiresAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}