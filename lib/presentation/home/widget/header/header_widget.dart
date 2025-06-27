import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_getx/core/constants/style/app_colors.dart';
import 'package:test_getx/presentation/home/controller/home_controller.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Obx(() {
      final user = controller.user.value;
      return Row(
        children: [
          ClipOval(
            child: Container(
              color: primaryLight,
              child: Image.asset(
                "assets/logo/profile.png",
                width: 40.0,
                height: 40.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi, ${user?.namaKaryawan ?? '...'}",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "hope you're doing well",
                  style: TextStyle(fontSize: 12, color: greyShape700),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: "Keluar Aplikasi?",
                middleText: "Apakah kamu yakin ingin logout?",
                textConfirm: "Ya",
                textCancel: "Batal",
                confirmTextColor: whiteC,
                buttonColor: dangerColor,
                onConfirm: () {
                  controller.logout();
                },
              );
            },
            icon: Icon(Icons.logout_outlined, color: dangerColor),
            tooltip: "Logout",
          ),
        ],
      );
    });
  }
}
