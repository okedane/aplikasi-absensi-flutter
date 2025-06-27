import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_getx/data/providers/auth/auth_provider.dart';
import 'package:test_getx/routes/app_pages.dart';

import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final isLoading = false.obs;
  final isObscure = true.obs;
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
    if (!(formKey.currentState?.validate() ?? false)) return;

    isLoading.value = true;
    try {
      final user = await authProvider.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      storage.write('token', user.token);
      Get.offAllNamed(AppRoutes.main);
    } catch (e) {
      final msg = e.toString();
      final errorMessage = msg.startsWith("Exception:")
          ? msg.replaceFirst("Exception:", "").trim()
          : msg;
      Get.snackbar(
        "Login Gagal",
        errorMessage, // ⬅️ Snackbar hanya untuk kesalahan dari server
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.error, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void toggleObscure() {
    isObscure.value = !isObscure.value;
  }

  @override
  void refresh() {
    login();
  }

  void logout() {
    final storage = GetStorage();
    storage.remove('token');
    Get.offAllNamed(AppRoutes.login);
  }
}
