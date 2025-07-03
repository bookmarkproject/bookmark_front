import 'package:flutter/material.dart';

AppBar getSignUpAppBar() {
  return AppBar(
    title: Text(
      "회원가입",
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}