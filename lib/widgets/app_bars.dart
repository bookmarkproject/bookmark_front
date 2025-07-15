import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.text,
    this.backButton,
  });

  final String text;
  final bool? backButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: backButton ?? true,
      title: Text(
        text,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    ); 
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
