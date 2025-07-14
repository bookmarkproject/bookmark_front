import 'package:bookmarkfront/utils/global_util.dart';
import 'package:flutter/material.dart';

SnackBar getCustomSnackBar(String message) {
  return SnackBar(
    content: Text(
      message,
      style: TextStyle(
        color: Colors.white
      ),
    ),
    duration: Duration(seconds: 2),
    backgroundColor: getMainColor(),
  );
}