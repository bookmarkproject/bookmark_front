import 'dart:convert';

import 'package:bookmarkfront/api/auth_api.dart';
import 'package:bookmarkfront/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:bookmarkfront/provider/auth_provider.dart';
import 'package:provider/provider.dart';

Map<String,String> getHeadersIncludeAuth(BuildContext context) {
  String? accessToken = Provider.of<AuthProvider>(context,listen: false).accessToken;
  return {
    "Content-Type": "application/json",
    "Authorization":"Bearer $accessToken"
  };
}

String getHost() {
  return "https://bookmarkapp.store";
  // return "http://localhost:8082";
}

Uri toPasredUrl(String url) {
  return Uri.parse(url);
}

Future<void> refresh(BuildContext context) async{
  String? token = Provider.of<AuthProvider>(context,listen: false).refreshToken;
  final request = {"refreshToken":token};
  final newTokens = await refreshRequestToServer(request);
  if(newTokens!=null) {
    await Provider.of<AuthProvider>(context,listen: false).saveToken(newTokens["accessToken"]!);
    await Provider.of<AuthProvider>(context,listen: false).saveRefreshToken(newTokens["refreshToken"]!);
  }
  else {
    await Provider.of<AuthProvider>(context,listen: false).clearToken();
    await Provider.of<AuthProvider>(context,listen: false).clearRefreshToken();
    showSnack(context, "다시 로그인 해주세요.",isError: true);
    Navigator.pushReplacementNamed(context, '/login');
  }
}

String errorMessage(response) {
  return jsonDecode(response.body)["message"];
}

