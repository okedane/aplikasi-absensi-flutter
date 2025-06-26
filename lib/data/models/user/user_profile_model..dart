
class UserProfileModel {
  final int id;
  final String nomorKaryawan;
  final String namaKaryawan;
  final String namaJabatan;

  UserProfileModel({
    required this.id,
    required this.nomorKaryawan,
    required this.namaKaryawan,
    required this.namaJabatan,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'],
      nomorKaryawan: json['nomor_karyawan'],
      namaKaryawan: json['nama_karyawan'],
      namaJabatan: json['jabatan']['nama_jabatan'],
    );
  }
}
