import 'package:bookmarkfront/api/utils/api_basic_util.dart';
import 'package:bookmarkfront/models/book_log_question.dart';
import 'package:bookmarkfront/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String base_url = "${getHost()}/book/log/question";

Future<List<BookLogQuestion>> getBookLogQuestion(BuildContext context,int id) async {
  List<BookLogQuestion> result = [];
  
  final url = Uri.parse("$base_url/$id");
  final headers = getHeadersIncludeAuth(context);

  try {
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final bookLogQuestions = jsonDecode(response.body);
      for (var bookLogQuestion in bookLogQuestions) {
        result.add(BookLogQuestion.fromJson(bookLogQuestion));
      }
      return result;
    } else {
      showSnack(context, errorMessage(response),isError: true);
      return [];
    }
  } catch (e) {
    print('알 수 없는 오류 발생: $e');
    return [];
  }
}