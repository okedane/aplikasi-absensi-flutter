import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:test_getx/core/constants/api/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:test_getx/data/models/history/history_model.dart';

class HistoryProvider {
  final storage = GetStorage();
  Future<List<AbsensiHistoryModel>> getHistory() async {
    final token = storage.read('token');
    final response = await http.get(
      Uri.parse(ApiConstants.history),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List historyData = body['data'];
      return historyData
          .map((item) => AbsensiHistoryModel.fromJson(item))
          .toList();
    } else {
      throw Exception('Gagal Memuat data history');
    }
  }
}
