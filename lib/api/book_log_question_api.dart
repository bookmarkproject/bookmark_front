import 'package:bookmarkfront/api/utils/api_basic_util.dart';
import 'package:bookmarkfront/api/utils/dio/dio_client.dart';
import 'package:bookmarkfront/models/book_log_question.dart';
import 'package:bookmarkfront/widgets/custom_snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

String base_url = "${getHost()}/book/log/question";

Future<List<BookLogQuestion>> getBookLogQuestion(BuildContext context,int id) async {
  List<BookLogQuestion> result = [];
  
  final dioClient = Provider.of<DioClient>(context,listen: false);

  try {
    final response = await dioClient.dio.get("$base_url/$id");
    if (response.statusCode == 200) {
      final bookLogQuestions = response.data;
      for (var bookLogQuestion in bookLogQuestions) {
        result.add(BookLogQuestion.fromJson(bookLogQuestion));
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