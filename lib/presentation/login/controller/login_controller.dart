import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_getx/data/providers/auth/auth_provider.dart';
import 'package:test_getx/routes/app_pages.dart';

import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final email = ''.obs;
  final password = ''.obs;
  final isLoading = false.obs;
  final isObscure = true.obs;
  final formKey = GlobalKey<FormState>();

  final authProvider = AuthProvider();
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();

    // ⬇️ Cek token saat controller pertama kali jalan
    final token = storage.read('token');
    if (token != null) {
      // Jika token ada, langsung ke Main
      Future.microtask(() {
        Get.offAllNamed(AppRoutes.main);
      });
    }
  }

  void login() async {
    if (email.value.isEmpty || password.value.isEmpty) {
      Get.snackbar(
        "Login Gagal",
        "Email dan Password wajib diisi.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.warning, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Optional: validasi email
    if (!email.value.contains('@') || !email.value.contains('.')) {
      Get.snackbar(
        "Email Tidak Valid",
        "Masukkan email yang benar.",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        icon: const Icon(Icons.email, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;
    try {
      final user = await authProvider.login(email.value, password.value);
      storage.write('token', user.token);
      Get.offAllNamed(AppRoutes.main);
    } catch (e) {
      Get.snackbar(
        "Login Gagal",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.error, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    final storage = GetStorage();
    storage.remove('token');
    Get.offAllNamed(AppRoutes.login);
  }
}
