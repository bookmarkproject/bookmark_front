import 'package:flutter/material.dart';

class LoginTextfield extends StatelessWidget {
  
  const LoginTextfield({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    this.type
  });

  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType? type;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 361,
      height: 50,
      child: TextField(
        keyboardType: type,
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromRGBO(0, 0, 0, 0.04),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
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