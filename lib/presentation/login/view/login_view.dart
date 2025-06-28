import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_getx/core.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                const SizedBox(height: 80),
                Image.asset(
                  "assets/logo/logo.png",
                  width: 150,
                  height: 150,
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Masukkan untuk melanjutkan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryColor,
                      ), // warna border normal
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryColor,
                      ), // warna border saat tidak fokus
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryLight,
                        width: 2.0,
                      ), // warna border saat fokus
                    ),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                  validator: LoginValidator.validateEmail,
                ),
                const SizedBox(height: 10),
                Obx(
                  () => TextFormField(
                    controller: controller.passwordController,
                    obscureText: controller.isObscure.value,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: primaryColor,
                        ), // warna border normal
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: primaryColor,
                        ), // warna border saat tidak fokus
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: primaryLight,
                          width: 2.0,
                        ), // warna border saat fokus
                      ),
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isObscure.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: controller.toggleObscure,
                      ),
                    ),
                    validator: LoginValidator.validatePassword,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: whiteC,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      controller.login();
                    },
                    child: Obx(
                      () => controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Login"),
                    ),
                  ),
                ),
                const SizedBox(height: 200.0),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.forgotPassword);
                  },
                  child: const Text("Forgot Password"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
