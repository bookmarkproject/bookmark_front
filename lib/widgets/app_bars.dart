import 'package:bookmarkfront/utils/global_util.dart';
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
      backgroundColor: getMainColor(),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ); 
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
