import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_getx/core.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    
    return Obx(() {
      if (controller.isLoading.value) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      if (controller.hasError.value) {
        return Scaffold(
          body: Center(
            child: Text("Error: ${controller.errorMessage.value}"),
          ),
        );
      }

      return Scaffold(
        appBar: AppBar(
          title: const Text("Auth"),
          actions: const [],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                "UniqueID: ${UniqueKey()}",
                style: const TextStyle(
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => controller.decrement(),
                    icon: const Icon(Icons.remove, color: Colors.grey),
                  ),
                  Obx(() => Text(
                    "${controller.counter.value}",
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey,
                    ),
                  )),
                  IconButton(
                    onPressed: () => controller.increment(),
                    icon: const Icon(Icons.add, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(
                height: 12.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => controller.initializeData(),
                child: const Text("Reload"),
              ),
            ],
          ),
        ),
      );
    });
  }
}
