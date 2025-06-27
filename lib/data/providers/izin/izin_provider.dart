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
}
