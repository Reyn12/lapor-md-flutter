class ProfilePegawaiModel {
  final int id;
  final String nama;
  final String nik;
  final String nip;
  final String email;
  final String noTelepon;
  final String alamat;
  final String role;
  final String? fotoProfil;
  final String tanggalBergabung;
  final String waktuBergabung;

  ProfilePegawaiModel({
    required this.id,
    required this.nama,
    required this.nik,
    required this.nip,
    required this.email,
    required this.noTelepon,
    required this.alamat,
    required this.role,
    required this.fotoProfil,
    required this.tanggalBergabung,
    required this.waktuBergabung,
  });

  factory ProfilePegawaiModel.fromJson(Map<String, dynamic> json) {
    return ProfilePegawaiModel(
      id: json['id'],
      nama: json['nama'] ?? '',
      nik: json['nik'] ?? '',
      nip: json['nip'] ?? '',
      email: json['email'] ?? '',
      noTelepon: json['no_telepon'] ?? '',
      alamat: json['alamat'] ?? '',
      role: json['role'] ?? '',
      fotoProfil: json['foto_profil'],
      tanggalBergabung: json['tanggal_bergabung'] ?? '',
      waktuBergabung: json['waktu_bergabung'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'nik': nik,
      'nip': nip,
      'email': email,
      'no_telepon': noTelepon,
      'alamat': alamat,
      'role': role,
      'foto_profil': fotoProfil,
      'tanggal_bergabung': tanggalBergabung,
      'waktu_bergabung': waktuBergabung,
    };
  }
}
