import 'package:bookmarkfront/models/email_response.dart';
import 'package:bookmarkfront/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String base_url = "http://localhost:8081/auth";

Future<void> signup(BuildContext context, Map<String,dynamic> request) async {
  final url = Uri.parse("$base_url/signup");
  final headers = {"Content-Type": "application/json"};
  final body = jsonEncode(request);

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      showSnack(context, "회원가입에 성공했습니다.");
      Navigator.pushNamed(context, "/");
    } else {
      showSnack(context, errorMessage(response),isError: true);
    }
  } catch (e) {
    print('알 수 없는 오류 발생: $e');
  }
}

String errorMessage(response) {
  return jsonDecode(response.body)["message"];
}