import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_getx/core.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: const [HomeView(), IzinView(), HistoryView()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,
          selectedItemColor: primaryColor, // warna saat dipilih
          unselectedItemColor: greyShape700, // warna saat tidak dipilih
          backgroundColor: backgroundColor, // warna background bar
        items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              tooltip: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_turned_in),
              label: "Permission",
              tooltip: "Permission",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: "History",
              tooltip: "History",
            ),
          ],
        ),
      );
    });
  }
}
