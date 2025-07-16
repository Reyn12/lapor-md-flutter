class KategoriModel {
  final int id;
  final String namaKategori;
  final String? deskripsi;

  KategoriModel({
    required this.id,
    required this.namaKategori,
    this.deskripsi,
  });

  factory KategoriModel.fromJson(Map<String, dynamic> json) {
    return KategoriModel(
      id: json['id'],
      namaKategori: json['nama_kategori'],
      deskripsi: json['deskripsi'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_kategori': namaKategori,
      'deskripsi': deskripsi,
    };
  }
}