import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:test_getx/core/constants/api/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:test_getx/data/models/izin/izin_model.dart';

class IzinProvider {
  final storage = GetStorage();

  Future<List<IzinModel>> getIzin() async {
    final token = storage.read('token');
    final response = await http.get(
      Uri.parse(ApiConstants.izin),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List izinData = body['data'];
      return izinData.map((item) => IzinModel.fromJson(item)).toList();
    } else {
      throw Exception('Gagal Memuat data Izin');
    }
  }

  Future<void> createIzin({
    required String tanggalMulai,
    required String tanggalSelesai,
    required String jenisIzin,
    required String alasan,
  }) async {
    final token = storage.read('token');

    final response = await http.post(
      Uri.parse(ApiConstants.izinStore),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
      body: {
        'tanggal_mulai': tanggalMulai,
        'tanggal_selesai': tanggalSelesai,
        'jenis_izin': jenisIzin,
        'alasan': alasan,
      },
    );

    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return; // Berhasil
    } else {
      // Tangkap pesan dari server
      throw Exception(body['message'] ?? 'Gagal menyimpan izin');
    }
  }

  Future<void> updateIzin({
    required int id,
    required String tanggalMulai,
    required String tanggalSelesai,
    required String jenisIzin,
    required String alasan,
  }) async {
    final token = storage.read('token');
    final response = await http.put(
      Uri.parse("${ApiConstants.izinUpdate}/$id"),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
      body: {
        'tanggal_mulai': tanggalMulai,
        'tanggal_selesai': tanggalSelesai,
        'jenis_izin': jenisIzin,
        'alasan': alasan,
      },
    );

    final body = jsonDecode(response.body);
    if (response.statusCode != 200 || !(body['success'] ?? false)) {
      throw Exception(body['message'] ?? 'Gagal mengubah izin');
    }
  }

  Future<void> deleteIzin(int id) async {
    final token = storage.read('token');
    final response = await http.delete(
      Uri.parse("${ApiConstants.izinDelete}/$id"),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    final body = jsonDecode(response.body);
    if (response.statusCode != 200 || !(body['success'] ?? false)) {
      throw Exception(body['message'] ?? 'Gagal menghapus izin');
    }
  }
}
