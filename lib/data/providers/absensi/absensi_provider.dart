import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:test_getx/core/constants/api/api_constants.dart';

class AbsensiProvider {
  Future<Map<String, dynamic>> submitAbsensi({
    required double latitude,
    required double longitude,
  }) async {
    final token = "Bearer ${GetStorage().read('token')}";

    final response = await http.post(
      Uri.parse(ApiConstants.absensi),
      headers: {"Authorization": token, "Accept": "application/json"},
      body: {
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode != 200 || data['success'] != true) {
      throw Exception(data['message'] ?? 'Gagal absen');
    }

    return data;
  }
}
