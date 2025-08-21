import 'package:bookmarkfront/api/utils/api_basic_util.dart';
import 'package:bookmarkfront/api/utils/dio/dio_client.dart';
import 'package:bookmarkfront/models/book_log.dart';
import 'package:bookmarkfront/models/book_record.dart';
import 'package:bookmarkfront/provider/book_record_provider.dart';
import 'package:bookmarkfront/widgets/custom_snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';


String base_url = "${getHost()}/book/log";

Future<void> saveBookLog(BuildContext context, Map<String,dynamic> request) async {
  
  final dioClient = Provider.of<DioClient>(context,listen: false);

  try {
    final response = await dioClient.dio.post(base_url,data: request);
    if(response.statusCode == 200){
      showSnack(context, "기록되었습니다.");
    } 
  } on DioException catch (e) {
      print('Dio 오류 발생: ${e.response?.statusCode}');
      print("Dio 오류 메시지 : ${e.response?.data['message']}");

    } catch (e) {
      print('알 수 없는 오류 발생: $e');
    }
}

Future<List<BookLog>> getBookLog(BuildContext context, int id) async {
  
  List<BookLog> result = [];

  final dioClient = Provider.of<DioClient>(context,listen: false);

  try {
    final response = await dioClient.dio.get("$base_url/$id");
   
    if (response.statusCode == 200) {
      final bookLogs = response.data;
      for (var bookLog in bookLogs) {
        result.add(BookLog.fromJson(bookLog));
      }
      return result;
    } 
    return [];
  } on DioException catch (e) {
      print('Dio 오류 발생: ${e.response?.statusCode}');
      print("Dio 오류 메시지 : ${e.response?.data['message']}");

      return [];
    } catch (e) {
      print('알 수 없는 오류 발생: $e');
      return [];
    }
}