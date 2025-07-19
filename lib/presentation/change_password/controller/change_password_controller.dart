import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:test_getx/core.dart';

class ChangePasswordController extends GetxController {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isLoading = false.obs;

  final ChangePasswordProvider provider = ChangePasswordProvider();

  void changePassword() async {
    isLoading.value = true;

    final result = await provider.changePassword(
      currentPassword: currentPasswordController.text,
      newPassword: newPasswordController.text,
      confirmPassword: confirmPasswordController.text,
    );

    isLoading.value = false;

    final success = result['success'] == true;

    if (success) {
      Get.snackbar(
        "Berhasil",
        result['message'] ?? "Password berhasil diubah.",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      currentPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
    } else {
      // Amankan parsing errors
      final errorsRaw = result['errors'];
      final Map<String, dynamic> errors = errorsRaw is Map
          ? Map<String, dynamic>.from(errorsRaw)
          : {};

      if (errors.isNotEmpty) {
        final firstMessage = errors.values.first is List
            ? errors.values.first[0]
            : errors.values.first;

        Get.snackbar(
          "Gagal",
          firstMessage.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Gagal",
          result['message'] ?? 'Terjadi kesalahan.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
