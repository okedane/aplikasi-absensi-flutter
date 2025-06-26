import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:test_getx/core/constants/api/api_constants.dart';
import 'package:test_getx/data/models/user/user_profile_model..dart';

class UserProvider {
  final storage = GetStorage();

  Future<UserProfileModel> fetchUser() async {
    final token = storage.read('token');

    final response = await http.get(
      Uri.parse(ApiConstants.user),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final karyawanJson = json['data']['karyawan'];
      return UserProfileModel.fromJson(karyawanJson);
    } else {
      throw Exception('Failed to fetch user: ${response.statusCode}');
    }
  }
}
