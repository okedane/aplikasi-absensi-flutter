import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_getx/core.dart';

class LemburView extends StatelessWidget {
  const LemburView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LemburController());

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
        appBar: AppBar(title: const Text("Lembur"), actions: const []),
        body: SingleChildScrollView(padding: const EdgeInsets.all(20.0)),
      );
    });
  }
}
