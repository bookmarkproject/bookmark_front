import 'package:bookmarkfront/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';

Color getMainColor() {
  return Color.fromRGBO(78, 60, 219, 1.0);
}

EdgeInsets getMainPadding() {
  return const EdgeInsets.symmetric(horizontal: 16.0,vertical: 20.0);
}

bool isEmptyField(BuildContext context,TextEditingController controller,String fieldtype) {
  bool isEmpty = controller.text.isEmpty;
  if(isEmpty) {
    showSnack(context,"$fieldtype을 입력해주세요.",isError: true);
  }
  return isEmpty;
}