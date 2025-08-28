import 'dart:io';

import 'package:bookmarkfront/api/utils/api_basic_util.dart';
import 'package:bookmarkfront/api/utils/dio/dio_client.dart';
import 'package:bookmarkfront/main.dart';
import 'package:bookmarkfront/models/member.dart';
import 'package:bookmarkfront/provider/member_provider.dart';
import 'package:bookmarkfront/widgets/custom_snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String base_url = "${getHost()}/member";

Future<bool> getMemberInfo(BuildContext context) async {
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
    print('Dio 오류 발생: ${e.response?.statusCode}');
    print("Dio 오류 메시지 : ${e.response?.data['message']}");

    return false;
  } catch (e) {
    print('알 수 없는 오류 발생: $e');
    return false;
  }
}

Future<void> deleteMemberInfo(BuildContext context,int id) async {
  try {
    final dioClient = Provider.of<DioClient>(context,listen: false);
    final response = await dioClient.dio.delete("$base_url/$id");
    
    if (response.statusCode == 204) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil('/login', (route) => false);
      showSnack(context, "회원탈퇴가 완료되었습니다.");
    } 
  } on DioException catch (e) {
    print('Dio 오류 발생: ${e.response?.statusCode}');
    print("Dio 오류 메시지 : ${e.response?.data['message']}");

  } catch (e) {
    print('알 수 없는 오류 발생: $e');
  }
}


Future<void> uploadProfileImage(BuildContext context,File image) async {
  try {
    final dioClient = Provider.of<DioClient>(context,listen: false);
    
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        image.path, 
        filename: image.path.split('/').last
      ),
    });

    final response = await dioClient.dio.post(
      "$base_url/profile/upload",
      data: formData,
    );

    if (response.statusCode == 200) {
      showSnack(context, "저장되었습니다.");
      await getMemberInfo(context);
    } 
  } on DioException catch (e) {
    print('Dio 오류 발생: ${e.response?.statusCode}');
    print("Dio 오류 메시지 : ${e.response?.data['message']}");

  } catch (e) {
    print('알 수 없는 오류 발생: $e');
  }
}


Future<String?> getPresignedProfileImageUrl(BuildContext context) async {
  try {
    final dioClient = Provider.of<DioClient>(context,listen: false);
  
    final response = await dioClient.dio.get("$base_url/profile");

    if (response.statusCode == 200) {
      print("presignedUrl : ${response.data}");
      return response.data;
    } 
  } on DioException catch (e) {
    print('Dio 오류 발생: ${e.response?.statusCode}');
    print("Dio 오류 메시지 : ${e.response?.data['message']}");
    return null;
  } catch (e) {
    print('알 수 없는 오류 발생: $e');
    return null;
  }
  return null;
}


