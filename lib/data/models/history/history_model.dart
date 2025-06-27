class AbsensiHistoryModel {
  final int id;
  final int karyawanId;
  final int? jadwalKerjaId;
  final int? izinId;
  final String tanggal;
  final String shift;
  final String jamAbsen;
  final String status;
  final String? keterlambatan;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic jadwalKerja;
  final dynamic izin;

  AbsensiHistoryModel({
    required this.id,
    required this.karyawanId,
    this.jadwalKerjaId,
    this.izinId,
    required this.tanggal,
    required this.shift,
    required this.jamAbsen,
    required this.status,
    this.keterlambatan,
    required this.createdAt,
    required this.updatedAt,
    this.jadwalKerja,
    this.izin,
  });

  factory AbsensiHistoryModel.fromJson(Map<String, dynamic> json) {
    return AbsensiHistoryModel(
      id: json['id'],
      karyawanId: json['karyawan_id'],
      jadwalKerjaId: json['jadwal_kerja_id'],
      izinId: json['izin_id'],
      tanggal: json['tanggal'] ?? '',
      shift: json['shift'] ?? '',
      jamAbsen: json['jam_absen'] ?? '',
      status: json['status'] ?? '',
      keterlambatan: json['keterlambatan']?.toString(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      jadwalKerja: json['jadwal_kerja'],
      izin: json['izin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'karyawan_id': karyawanId,
      'jadwal_kerja_id': jadwalKerjaId,
      'izin_id': izinId,
      'tanggal': tanggal,
      'shift': shift,
      'jam_absen': jamAbsen,
      'status': status,
      'keterlambatan': keterlambatan,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'jadwal_kerja': jadwalKerja,
      'izin': izin,
    };
  }
}
