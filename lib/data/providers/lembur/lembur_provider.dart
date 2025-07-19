import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:test_getx/core/constants/api/api_constants.dart';
import 'package:test_getx/data/models/lembur/lembur_model.dart';
import 'package:http/http.dart' as http;

class LemburProvider {
  final storage = GetStorage();
  Future<List<LemburModel>> getLembur() async {
    final token = storage.read('token');

    final response = await http.get(
      Uri.parse(ApiConstants.lembur),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final data = body['data'];

      if (data == null || data is! List) {
        return [];
      }

      return data
          .map<LemburModel>((item) => LemburModel.fromJson(item))
          .toList();
    } else {
      throw Exception('Gagal Memuat data Lembur');
    }
  }
}
