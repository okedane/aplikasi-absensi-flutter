import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_getx/core.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lupa Password")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Masukkan email akun Anda untuk mendapatkan kode verifikasi.",
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 48,
                child: ElevatedButton(
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
                          final email = controller.emailController.text.trim();
                          if (!GetUtils.isEmail(email)) {
                            Get.snackbar(
                              "Validasi",
                              "Masukkan email yang valid",
                            );
                          } else {
                            controller.sendResetCode();
                          }
                        },
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text("Kirim Kode Verifikasi"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
