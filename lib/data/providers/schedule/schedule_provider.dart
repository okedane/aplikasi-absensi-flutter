import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:test_getx/core/constants/api/api_constants.dart';
import 'package:test_getx/data/models/schedule/ScheduleTodayModel.dart';

class ScheduleProvider {
  final storage = GetStorage();

  Future<ScheduleTodayModel> getTodaySchedule() async {
    final token = storage.read('token');

    final response = await http.get(
      Uri.parse(ApiConstants.schedule),
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return ScheduleTodayModel.fromJson(body['data']);
    } else {
      throw Exception('Gagal Memuat jadwal hari ini');
    }
  }
}
