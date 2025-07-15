import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    required this.width,
    this.type,
    this.maxLen,
    this.enabled,
  });

  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final double width;

  final int? maxLen;
  final TextInputType? type;

  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 47,
      child: TextField(
        keyboardType: type,
        obscureText: obscureText,
        controller: controller,
        enabled: enabled != null ? !enabled! : true,
        inputFormatters: [
          LengthLimitingTextInputFormatter(maxLen)
        ],
        style: TextStyle(
          fontSize: 12.0,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromRGBO(0, 0, 0, 0.04),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(16),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: Color.fromRGBO(0, 0, 0, 0.3)
          )
        ),
      ),
    );
  }
}