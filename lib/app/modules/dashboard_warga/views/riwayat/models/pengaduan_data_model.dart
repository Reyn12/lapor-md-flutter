class PengaduanDataModel {
  final int id;
  final String nomorPengaduan;
  final String judul;
  final String deskripsi;
  final String status;
  final String lokasi;
  final String? fotoPengaduan;
  final KategoriData kategori;
  final DateTime tanggalPengaduan;
  final DateTime? tanggalProses;
  final DateTime? tanggalSelesai;
  final WargaData warga;
  final PegawaiData? pegawai;
  final KepalaKantorData? kepalaKantor;

  PengaduanDataModel({
    required this.id,
    required this.nomorPengaduan,
    required this.judul,
    required this.deskripsi,
    required this.status,
    required this.lokasi,
    this.fotoPengaduan,
    required this.kategori,
    required this.tanggalPengaduan,
    this.tanggalProses,
    this.tanggalSelesai,
    required this.warga,
    this.pegawai,
    this.kepalaKantor,
  });

  factory PengaduanDataModel.fromJson(Map<String, dynamic> json) {
    return PengaduanDataModel(
      id: json['id'] ?? 0,
      nomorPengaduan: json['nomor_pengaduan'] ?? '',
      judul: json['judul'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      status: json['status'] ?? '',
      lokasi: json['lokasi'] ?? '',
      fotoPengaduan: json['foto_pengaduan'],
      kategori: KategoriData.fromJson(json['kategori'] ?? {}),
      tanggalPengaduan: DateTime.parse(json['tanggal_pengaduan'] ?? DateTime.now().toIso8601String()),
      tanggalProses: json['tanggal_proses'] != null ? DateTime.parse(json['tanggal_proses']) : null,
      tanggalSelesai: json['tanggal_selesai'] != null ? DateTime.parse(json['tanggal_selesai']) : null,
      warga: WargaData.fromJson(json['warga'] ?? {}),
      pegawai: json['pegawai'] != null ? PegawaiData.fromJson(json['pegawai']) : null,
      kepalaKantor: json['kepala_kantor'] != null ? KepalaKantorData.fromJson(json['kepala_kantor']) : null,
    );
  }
}

class KategoriData {
  final int id;
  final String namaKategori;

  KategoriData({required this.id, required this.namaKategori});

  factory KategoriData.fromJson(Map<String, dynamic> json) {
    return KategoriData(
      id: json['id'] ?? 0,
      namaKategori: json['nama_kategori'] ?? '',
    );
  }
}

class WargaData {
  final int id;
  final String nama;

  WargaData({required this.id, required this.nama});

  factory WargaData.fromJson(Map<String, dynamic> json) {
    return WargaData(
      id: json['id'] ?? 0,
      nama: json['nama'] ?? '',
    );
  }
}

class PegawaiData {
  final int id;
  final String nama;

  PegawaiData({required this.id, required this.nama});

  factory PegawaiData.fromJson(Map<String, dynamic> json) {
    return PegawaiData(
      id: json['id'] ?? 0,
      nama: json['nama'] ?? '',
    );
  }
}

class KepalaKantorData {
  final int id;
  final String nama;

  KepalaKantorData({required this.id, required this.nama});

  factory KepalaKantorData.fromJson(Map<String, dynamic> json) {
    return KepalaKantorData(
      id: json['id'] ?? 0,
      nama: json['nama'] ?? '',
    );
  }
}