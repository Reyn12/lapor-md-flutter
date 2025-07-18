class ProfileModel {
  final int id;
  final String nama;
  final String email;
  final String? emailVerifiedAt;
  final bool isVerified;
  final String? nik; // bisa null
  final String noTelepon;
  final String alamat;
  final String? fotoProfil; // bisa null
  final String role;
  final String createdAt;
  final String updatedAt;

  ProfileModel({
    required this.id,
    required this.nama,
    required this.email,
    this.emailVerifiedAt,
    required this.isVerified,
    this.nik,
    required this.noTelepon,
    required this.alamat,
    this.fotoProfil,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? 0,
      nama: json['nama'] ?? '',
      email: json['email'] ?? '',
      emailVerifiedAt: json['email_verified_at'],
      isVerified: json['is_verified'] ?? false,
      nik: json['nik'], // bisa null
      noTelepon: json['no_telepon'] ?? '',
      alamat: json['alamat'] ?? '',
      fotoProfil: json['foto_profil'], // bisa null
      role: json['role'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'is_verified': isVerified,
      'nik': nik,
      'no_telepon': noTelepon,
      'alamat': alamat,
      'foto_profil': fotoProfil,
      'role': role,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
} 