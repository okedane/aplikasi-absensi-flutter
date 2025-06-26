import 'package:test_getx/data/models/user/jabatan_model.dart';

class KaryawanModel {
  final int id;
  final String nomorKaryawan;
  final String namaKaryawan;
  final JabatanModel jabatan;

  KaryawanModel({
    required this.id,
    required this.nomorKaryawan,
    required this.namaKaryawan,
    required this.jabatan,
  });

  factory KaryawanModel.fromJson(Map<String, dynamic> json) {
    return KaryawanModel(
      id: json['id'],
      nomorKaryawan: json['nomor_karyawan'],
      namaKaryawan: json['nama_karyawan'],
      jabatan: JabatanModel.fromJson(json['jabatan']),
    );
  }
}
