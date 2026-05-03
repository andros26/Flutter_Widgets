import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[300],
      elevation: 0,
      leading: const Icon(Icons.menu, color: Colors.black54, size: 35),
      actions: const [
        Icon(Icons.search, color: Colors.black54, size: 35),
        SizedBox(width: 15),
      ],
    );
  }
}
