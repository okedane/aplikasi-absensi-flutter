import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_getx/core.dart';
// import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubah Password")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildPasswordField(
              label: "Password Lama",
              controller: controller.currentPasswordController,
              id: "current",
            ),
            const SizedBox(height: 16),
            _buildPasswordField(
              label: "Password Baru",
              controller: controller.newPasswordController,
              id: "new",
            ),
            const SizedBox(height: 16),
            _buildPasswordField(
              label: "Konfirmasi Password Baru",
              controller: controller.confirmPasswordController,
              id: "confirm",
            ),
            const SizedBox(height: 24),
            Obx(
              () => ElevatedButton.icon(
                onPressed: controller.isLoading.value
                    ? null
                    : controller.changePassword,
                icon: controller.isLoading.value
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.lock_reset),
                label: Text(
                  controller.isLoading.value
                      ? "Menyimpan..."
                      : "Simpan Password",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required String id,
  }) {
    final isObscure = true.obs;

    return Obx(
      () => TextFormField(
        controller: controller,
        obscureText: isObscure.value,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: IconButton(
            icon: Icon(
              isObscure.value ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () => isObscure.value = !isObscure.value,
          ),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
