// ignore_for_file: file_names

class ScheduleTodayModel {
  final String tanggal;
  final String shift;
  final String jamMasuk;
  final String jamKeluar;
  final Lokasi lokasi;

  ScheduleTodayModel({
    required this.tanggal,
    required this.shift,
    required this.jamMasuk,
    required this.jamKeluar,
    required this.lokasi,
  });

  factory ScheduleTodayModel.fromJson(Map<String, dynamic> json) {
    return ScheduleTodayModel(
      tanggal: json['tanggal'],
      shift: json['shift'],
      jamMasuk: json['jam_masuk'],
      jamKeluar: json['jam_keluar'],
      lokasi: Lokasi.fromJson(json['lokasi']),
    );
  }
}

class Lokasi {
  final String namaLokasi;
  final String latitude;
  final String longitude;
  final int radiusMeter;

  Lokasi({
    required this.namaLokasi,
    required this.latitude,
    required this.longitude,
    required this.radiusMeter,
  });

  factory Lokasi.fromJson(Map<String, dynamic> json) {
    return Lokasi(
      namaLokasi: json['nama_lokasi'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      radiusMeter: json['radius_meter'],
    );
  }
}
