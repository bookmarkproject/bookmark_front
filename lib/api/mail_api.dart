import 'package:bookmarkfront/api/utils/api_basic_util.dart';
import 'package:bookmarkfront/models/email_response.dart';
import 'package:bookmarkfront/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String base_url = "${getHost()}/mail";

Future<void> sendMail(BuildContext context,String email) async {
  final url = Uri.parse("$base_url/send");
  final headers = {"Content-Type": "application/json"};
  final body = jsonEncode({
    "email" : email
  });

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      showSnack(context, "인증번호 발송에 성공했습니다.");
    } else {
      showSnack(context, "인증번호 발송에 실패했습니다.",isError: true);
    }
  } catch (e) {
    print('알 수 없는 오류 발생: $e');
  }
}


Future<EmailResponse?> authNumCheck(BuildContext context,String email,String authNum,{String? passwordChange}) async {
  final url = Uri.parse("$base_url/check");
  final headers = {"Content-Type": "application/json"};
  final body = jsonEncode({
    "email" : email,
    "authNum": authNum,
    "type" : passwordChange
  });

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      showSnack(context, "인증되었습니다.");
      return EmailResponse.fromJson(data);
    } else {
      showSnack(context,errorMessage(response),isError: true);
      return null;
    }
  } catch (e) {
    print('알 수 없는 오류 발생: $e');
    return null;
  }
}
