class IzinModel {
  final int id;
  final int karyawanId;
  final String tanggalMulai;
  final String tanggalSelesai;
  final String jenisIzin;
  final String alasan;
  final String status;
  final String? dokumen;
  final String createdAt;
  final String updatedAt;

  IzinModel({
    required this.id,
    required this.karyawanId,
    required this.tanggalMulai,
    required this.tanggalSelesai,
    required this.jenisIzin,
    required this.alasan,
    required this.status,
    this.dokumen,
    required this.createdAt,
    required this.updatedAt,
  });

  factory IzinModel.fromJson(Map<String, dynamic> json) {
    return IzinModel(
      id: json['id'],
      karyawanId: json['karyawan_id'],
      tanggalMulai: json['tanggal_mulai'],
      tanggalSelesai: json['tanggal_selesai'],
      jenisIzin: json['jenis_izin'],
      alasan: json['alasan'],
      status: json['status'],
      dokumen: json['dokumen'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'karyawan_id': karyawanId,
      'tanggal_mulai': tanggalMulai,
      'tanggal_selesai': tanggalSelesai,
      'jenis_izin': jenisIzin,
      'alasan': alasan,
      'status': status,
      'dokumen': dokumen,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
