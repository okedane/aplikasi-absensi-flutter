import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_getx/core.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Obx(() {
      if (controller.isLoading.value) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      if (controller.hasError.value) {
        return Scaffold(
          body: Center(child: Text("Error: ${controller.errorMessage.value}")),
        );
      }

      return Scaffold(
        appBar: AppBar(title: const Text("Profile"), actions: const []),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 12.0),
              const Text("Profile Information"),
              const SizedBox(height: 20.0),],
          ),
        ),
      );
    });
  }
}
