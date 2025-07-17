import 'dart:convert';
import 'package:bookmarkfront/api/utils/api_basic_util.dart';
import 'package:bookmarkfront/models/member.dart';
import 'package:bookmarkfront/provider/auth_provider.dart';
import 'package:bookmarkfront/provider/member_provider.dart';
import 'package:bookmarkfront/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

String base_url = "${getHost()}/member";

Future<bool> getMemberInfo(BuildContext context) async {
  try {
    final response = await http.get(
      toPasredUrl("$base_url/me"), 
      headers: getHeadersIncludeAuth(context)
    );

    if (response.statusCode == 200) {
      Provider.of<MemberProvider>(context,listen: false).setMember(Member.fromJson(jsonDecode(response.body)));
      return true;
    } else if(response.statusCode == 401){
      await refresh(context);
      if(Provider.of<AuthProvider>(context,listen: false).accessToken != null) {
        await getMemberInfo(context);
        return true;
      } else {
        return false;
      }
    } else {
      showSnack(context, "다시 로그인해주세요.",isError: true);
      return false;
    }
  } catch (e) {
    print('알 수 없는 오류 발생: $e');
    return false;
  }
}