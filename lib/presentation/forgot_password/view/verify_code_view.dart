import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_getx/core.dart';


class VerifyCodeView extends GetView<ForgotPasswordController> {
  const VerifyCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    final email = Get.arguments['email'];

    return Scaffold(
      appBar: AppBar(title: const Text("Verifikasi Kode")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Masukkan kode 6 digit yang dikirim ke $email"),
            const SizedBox(height: 20),
            TextField(
              controller: controller.codeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: const InputDecoration(
                labelText: "Kode Verifikasi",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() => ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () {
                          final code = controller.codeController.text.trim();
                          if (code.length != 6) {
                            Get.snackbar("Validasi", "Kode harus 6 digit");
                          } else {
                            controller.verifyCode();
                          }
                        },
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text("Verifikasi"),
                )),
          ],
        ),
      ),
    );
  }
}
