class KepalaKantorModel {
  final int? id;
  final String? nama;
  final String? nik;
  final String? nip;
  final String? email;
  final String? noTelepon;
  final String? alamat;
  final String? role;
  final String? fotoProfil;
  final String? jabatan;
  final String? createdAt;
  final String? updatedAt;

  KepalaKantorModel({
    this.id,
    this.nama,
    this.nik,
    this.nip,
    this.email,
    this.noTelepon,
    this.alamat,
    this.role,
    this.fotoProfil,
    this.jabatan,
    this.createdAt,
    this.updatedAt,
  });

  factory KepalaKantorModel.fromJson(Map<String, dynamic> json) => KepalaKantorModel(
        id: json["id"],
        nama: json["nama"],
        nik: json["nik"],
        nip: json["nip"],
        email: json["email"],
        noTelepon: json["no_telepon"],
        alamat: json["alamat"],
        role: json["role"],
        fotoProfil: json["foto_profil"],
        jabatan: json["jabatan"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "nik": nik,
        "nip": nip,
        "email": email,
        "no_telepon": noTelepon,
        "alamat": alamat,
        "role": role,
        "foto_profil": fotoProfil,
        "jabatan": jabatan,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}