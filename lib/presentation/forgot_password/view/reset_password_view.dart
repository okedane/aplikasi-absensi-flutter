import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_getx/core.dart';

class ResetPasswordView extends GetView<ForgotPasswordController> {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller.passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password Baru",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Konfirmasi Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: whiteC,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: controller.isLoading.value
                    ? null
                    : () {
                        final pass = controller.passwordController.text.trim();
                        final confirm = controller
                            .confirmPasswordController
                            .text
                            .trim();

                        if (pass.length < 8) {
                          Get.snackbar(
                            "Validasi",
                            "Password minimal 8 karakter",
                          );
                        } else if (pass != confirm) {
                          Get.snackbar(
                            "Validasi",
                            "Konfirmasi password tidak cocok",
                          );
                        } else {
                          controller.resetPassword();
                        }
                      },
                child: controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text("Reset Password"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
