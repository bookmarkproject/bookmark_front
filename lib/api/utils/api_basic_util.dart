import 'dart:convert';

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

Uri toPasredUrl(String url) {
  return Uri.parse(url);
}

String errorMessage(response) {
  return jsonDecode(response.body)["message"];
}

