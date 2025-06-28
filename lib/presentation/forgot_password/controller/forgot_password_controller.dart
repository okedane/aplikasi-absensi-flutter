import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_getx/data/providers/forgot/forgot_password_provider.dart';

class ForgotPasswordController extends GetxController {
  final ForgotPasswordProvider provider = ForgotPasswordProvider();

  final emailController = TextEditingController();
  final codeController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  RxBool isLoading = false.obs;

  // Untuk menyimpan data dari arguments
  String email = '';
  String code = '';

  @override
  void onInit() {
    super.onInit();

    // Jika ada argument saat masuk halaman, ambil dan simpan
    if (Get.arguments != null) {
      email = Get.arguments['email'] ?? '';
      code = Get.arguments['code'] ?? '';
      emailController.text = email;
      codeController.text = code;
    }
  }

  // Step 1: Kirim Kode Reset
  Future<void> sendResetCode() async {
    isLoading.value = true;
    try {
      final inputEmail = emailController.text.trim();
      await provider.sendResetCode(inputEmail);
      Get.snackbar("Sukses", "Kode verifikasi dikirim ke email");
      Get.toNamed("/verify-code", arguments: {"email": inputEmail});
    } catch (e) {
      Get.snackbar("Gagal", e.toString(), backgroundColor: Colors.red[100]!);
    } finally {
      isLoading.value = false;
    }
  }

  // Step 2: Verifikasi Kode
  Future<void> verifyCode() async {
    isLoading.value = true;
    try {
      final inputEmail = emailController.text.trim(); // AMBIL DARI CONTROLLER
      final inputCode = codeController.text.trim();

      await provider.verifyCode(inputEmail, inputCode);

      Get.snackbar("Sukses", "Kode valid. Silakan reset password.");

      Get.toNamed(
        '/reset-password',
        arguments: {'email': inputEmail, 'code': inputCode},
      );
    } catch (e) {
      Get.snackbar("Gagal", e.toString(), backgroundColor: Colors.red[100]!);
    } finally {
      isLoading.value = false;
    }
  }

  // Step 3: Reset Password
  Future<void> resetPassword() async {
    isLoading.value = true;
    try {
      final inputEmail = emailController.text.trim(); // ✅ Gunakan controller
      final inputCode = codeController.text.trim(); // ✅ Gunakan controller
      final newPassword = passwordController.text.trim();
      final confirmPassword = confirmPasswordController.text.trim();

      // Validasi lokal
      if (inputEmail.isEmpty ||
          inputCode.isEmpty ||
          newPassword.isEmpty ||
          confirmPassword.isEmpty) {
        Get.snackbar(
          "Error",
          "Semua field wajib diisi",
          backgroundColor: Colors.red[100]!,
        );
        return;
      }

      if (newPassword.length < 8) {
        Get.snackbar(
          "Error",
          "Password minimal 8 karakter",
          backgroundColor: Colors.red[100]!,
        );
        return;
      }

      if (newPassword != confirmPassword) {
        Get.snackbar(
          "Error",
          "Konfirmasi password tidak cocok",
          backgroundColor: Colors.red[100]!,
        );
        return;
      }

      await provider.resetPassword(
        email: inputEmail,
        code: inputCode,
        password: newPassword,
        confirmPassword: confirmPassword,
      );

      Get.snackbar("Sukses", "Password berhasil direset");
      Get.offAllNamed("/login");
    } catch (e) {
      Get.snackbar("Gagal", e.toString(), backgroundColor: Colors.red[100]!);
    } finally {
      isLoading.value = false;
    }
  }
}
