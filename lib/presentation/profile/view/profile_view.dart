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
              CircleAvatar(
                radius: 64,
                backgroundImage: NetworkImage(
                  "https://res.cloudinary.com/dotz74j1p/raw/upload/v1716044979/nr7gt66alfhmu9vaxu2u.png",
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                "Romadani",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Desainer at KK UI Store",
                style: TextStyle(fontSize: 14),
              ),
              const ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text("Other Information"),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text("Edit Profile"),
                trailing: const Icon(Icons.chevron_right, size: 24.0),
                onTap: () {},
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text("Ubah Password"),
                trailing: const Icon(Icons.chevron_right, size: 24.0),
                onTap: () {},
              ),
            ],
          ),
        ),
      );
    });
  }
}
