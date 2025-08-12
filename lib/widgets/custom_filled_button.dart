import 'package:bookmarkfront/utils/global_util.dart';
import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    super.key,
    required this.callback,
    required this.text,
    required this.fontsize,
    required this.width,
    this.backgroundColor,
    this.fontColor,
    this.height,
    this.borderRadius,
  });

  final VoidCallback callback;
  final String text;
  final double fontsize;
  final double width;
  final Color? backgroundColor;
  final Color? fontColor;
  final double? height;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: callback,
      style: FilledButton.styleFrom(
        backgroundColor: backgroundColor ?? getMainColor(),
        fixedSize: Size(width,height ?? 50),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 16), 
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: fontColor ?? Colors.white,
          fontSize: fontsize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}