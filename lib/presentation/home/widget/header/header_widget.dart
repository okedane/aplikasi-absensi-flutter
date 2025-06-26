import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              color: Colors.amber,
              child: Image.asset(
                "assets/logo/profile.png",
                width: 40.0,
                height: 40.0,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(width: 5.0), 
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hi, ${user?.namaKaryawan ?? '...'}"),
                Text("hope you're doing well", style: TextStyle(fontSize: 10)),
              ],
            ),
          ),
          const Icon(Icons.more_vert_outlined),
        ],
      );
    });
  }
}
