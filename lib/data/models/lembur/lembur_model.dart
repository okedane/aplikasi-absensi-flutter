class LemburModel {
  final int id;
  final int karyawanId;
  final DateTime tanggal;
  final String jamMulai;
  final String jamSelesai;
  final int totalJam;

  LemburModel({
    required this.id,
    required this.karyawanId,
    required this.tanggal,
    required this.jamMulai,
    required this.jamSelesai,
    required this.totalJam,
  });

  factory LemburModel.fromJson(Map<String, dynamic> json) {
    return LemburModel(
      id: json['id'],
      karyawanId: json['karyawan_id'],
      tanggal: DateTime.parse(json['tanggal']),
      jamMulai: json['jam_mulai'],
      jamSelesai: json['jam_selesai'],
      totalJam: json['total_jam'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'karyawan_id': karyawanId,
      'tanggal': tanggal.toIso8601String(),
      'jam_mulai': jamMulai,
      'jam_selesai': jamSelesai,
      'total_jam': totalJam,
    };
  }
}
