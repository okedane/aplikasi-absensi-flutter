import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:test_getx/core/constants/api/api_constants.dart';

class ChangePasswordProvider {
  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final token = GetStorage().read('token');

    try {
      final response = await http.post(
        Uri.parse(ApiConstants.changePassword),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: {
          'current_password': currentPassword,
          'new_password': newPassword,
          'new_password_confirmation': confirmPassword,
        },
      );

      final data = jsonDecode(response.body);

      return {
        'success': data['success'],
        'message': data['message'] ?? 'Terjadi kesalahan',
        'errors': data['errors'] ?? {},
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Gagal menghubungkan ke server.',
        'errors': {},
      };
    }
  }
}
