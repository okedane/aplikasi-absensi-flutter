import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_getx/core/constants/api/api_constants.dart';
import '../../models/auth/user_model.dart';

class AuthProvider {
  Future<UserModel> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(ApiConstants.login),
      body: {'email': email, 'password': password},
    );

    final data = json.decode(response.body);
    if (data['success'] == true) {
      return UserModel.fromJson(data['data']);
    } else {
      throw Exception(data['message']);
    }
  }
}
