import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_getx/core/constants/api/api_constants.dart';

class ForgotPasswordProvider {
  // Kirim kode verifikasi ke email
  Future<void> sendResetCode(String email) async {
    final response = await http.post(
      Uri.parse(ApiConstants.forgot),
      headers: {'Accept': 'application/json'},
      body: {'email': email},
    );

    final data = jsonDecode(response.body);
    if (response.statusCode != 200 || data['success'] != true) {
      throw Exception(data['message'] ?? 'Gagal mengirim kode');
    }
  }

  // Verifikasi kode dari email
  Future<void> verifyCode(String email, String code) async {
    final response = await http.post(
      Uri.parse(ApiConstants.verify),
      headers: {'Accept': 'application/json'},
      body: {'email': email, 'code': code},
    );

    if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  // Reset password baru
  Future<void> resetPassword({
    required String email,
    required String code,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await http.post(
      Uri.parse(ApiConstants.reset),
      headers: {'Accept': 'application/json'},
      body: {
        'email': email,
        'code': code,
        'password': password,
        'password_confirmation': confirmPassword,
      },
    );

    final data = jsonDecode(response.body);
    if (response.statusCode != 200 || data['success'] != true) {
      throw Exception(data['message'] ?? 'Reset password gagal');
    }
  }
}
