import 'package:bookmarkfront/api/utils/api_basic_util.dart';
import 'package:bookmarkfront/models/member.dart';
import 'package:bookmarkfront/provider/auth_provider.dart';
import 'package:bookmarkfront/provider/member_provider.dart';
import 'package:bookmarkfront/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

String base_url = "http://localhost:8081/auth";

Future<void> signup(BuildContext context, Map<String,dynamic> request) async {
  final url = Uri.parse("$base_url/signup");
  final headers = {"Content-Type": "application/json"};
  final body = jsonEncode(request);

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      showSnack(context, "회원가입에 성공했습니다.");
      Navigator.pushNamed(context, "/login");
    } else {
      showSnack(context, errorMessage(response),isError: true);
    }
  } catch (e) {
    print('알 수 없는 오류 발생: $e');
  }
}

Future<bool> isDuplicateNickname(BuildContext context, String nickname) async {
  final url = Uri.parse("$base_url/duplication/nickname?nickname=$nickname");
  final headers = {"Content-Type": "application/json"};
  
  try {
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      showSnack(context, "사용 가능한 닉네임입니다.");
      return false;
    } else {
      showSnack(context, errorMessage(response),isError: true);
      return true;
    }
    
  } catch (e) {
    print('알 수 없는 오류 발생: $e');
    return true;
  }
}

Future<void> login(BuildContext context, Map<String,dynamic> request) async {
  final url = Uri.parse("$base_url/login");
  final headers = {"Content-Type": "application/json"};
  final body = jsonEncode(request);

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final member = Member.fromJson(jsonDecode(response.body));
      context.read<MemberProvider>().setMember(member);
      context.read<AuthProvider>().saveToken(jsonDecode(response.body)['accessToken']);
      context.read<AuthProvider>().saveRefreshToken(jsonDecode(response.body)['refreshToken']);
      showSnack(context, "로그인에 성공했습니다.");
      Navigator.pushNamed(context, "/home");
    } else {
      showSnack(context, errorMessage(response),isError: true);
    }
  } catch (e) {
    print('알 수 없는 오류 발생: $e');
  }
}


Future<String?> findEmail(BuildContext context, Map<String,dynamic> request) async {
  final url = Uri.parse("$base_url/find/email");
  final headers = {"Content-Type": "application/json"};
  final body = jsonEncode(request);

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)["email"];
    } else {
      showSnack(context, errorMessage(response),isError: true);
      return null;
    }
  } catch (e) {
    print('알 수 없는 오류 발생: $e');
    return null;
  }
}

Future<bool> changePassword(BuildContext context, Map<String,dynamic> request) async {
  final url = Uri.parse("$base_url/change/password");
  final headers = {"Content-Type": "application/json"};
  final body = jsonEncode(request);

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 204) {
      showSnack(context, "비밀번호 변경이 완료되었습니다.");
      return true;
    } else {
      showSnack(context, errorMessage(response),isError: true);
      return false;
    }
  } catch (e) {
    print('알 수 없는 오류 발생: $e');
    return false;
  }
}

Future<Map<String,String>?> refreshRequestToServer(Map<String,dynamic> request) async {
  final url = Uri.parse("$base_url/refresh/token");
  final headers = {"Content-Type": "application/json"};
  final body = jsonEncode(request);

  try {
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("토큰 발급 완료 : ${data["accessToken"]}");
      return {
        "accessToken":data["accessToken"],
        "refreshToken":data["refreshToken"]
      };
    } else {
      return null;
    }
  } catch (e) {
    print('알 수 없는 오류 발생: $e');
    return null;
  }
}


