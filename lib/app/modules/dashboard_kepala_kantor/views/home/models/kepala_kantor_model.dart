class KepalaKantorModel {
  final String nama;
  final String jabatan;
  final String? fotoProfil;

  KepalaKantorModel({
    required this.nama,
    required this.jabatan,
    this.fotoProfil,
  });

  factory KepalaKantorModel.fromJson(Map<String, dynamic> json) {
    return KepalaKantorModel(
      nama: json['nama'] ?? '',
      jabatan: json['jabatan'] ?? '',
      fotoProfil: json['foto_profil'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'jabatan': jabatan,
      'foto_profil': fotoProfil,
    };
  }
}