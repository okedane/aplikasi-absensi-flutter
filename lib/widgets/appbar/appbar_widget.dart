import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      backgroundColor: Colors.white,
      foregroundColor: Colors.grey[800],
      elevation: 0,
      centerTitle: true, 
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
