import 'package:flutter/material.dart';

class LoginButtons extends StatelessWidget {
  const LoginButtons({
    super.key,
    required this.callback,
    required this.backgroundColor,
    required this.text,
    required this.textColor,
    required this.borderSide,
  });

  final VoidCallback callback;
  final Color backgroundColor;
  final String text;
  final Color textColor;
  final BorderSide borderSide;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: callback,
      style: FilledButton.styleFrom(
        backgroundColor: backgroundColor,
        fixedSize: Size(361,50),
        shape: RoundedRectangleBorder(
          side: borderSide,
          borderRadius: BorderRadius.circular(56), 
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}