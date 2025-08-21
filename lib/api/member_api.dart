import 'dart:convert';
import 'package:bookmarkfront/api/utils/api_basic_util.dart';
import 'package:bookmarkfront/models/member.dart';
import 'package:bookmarkfront/provider/auth_provider.dart';
import 'package:bookmarkfront/provider/member_provider.dart';
import 'package:bookmarkfront/utils/dio/dio_client.dart';
import 'package:bookmarkfront/widgets/custom_snackbar.dart';
import 'package:dio/dio.dart';
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

Future<bool> getMemberInfoDio(BuildContext context) async {
  try {
    final dioClient = Provider.of<DioClient>(context,listen: false);
    final response = await dioClient.dio.get("$base_url/me");
    
    if (response.statusCode == 200) {
      Provider.of<MemberProvider>(context,listen: false).setMember(Member.fromJson(response.data));
      return true;
    } else {
      showSnack(context, "다시 로그인해주세요.", isError: true);
      return false;
    } 
  } on DioException catch (e) {
    if (e.response?.statusCode == 401) {
      // TokenInterceptor에서 Refresh Token 재발급 처리됨
      showSnack(context, "로그인이 필요합니다.", isError: true);
    } else {
      print('알 수 없는 오류 발생: $e');
    }
    return false;
  } catch (e) {
    print('알 수 없는 오류 발생: $e');
    return false;
  }
}