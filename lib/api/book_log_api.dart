import 'package:bookmarkfront/api/utils/api_basic_util.dart';
import 'package:bookmarkfront/models/book_log.dart';
import 'package:bookmarkfront/models/book_record.dart';
import 'package:bookmarkfront/provider/book_record_provider.dart';
import 'package:bookmarkfront/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';


String base_url = "${getHost()}/book/log";

Future<void> saveBookLog(BuildContext context, Map<String,dynamic> request) async {
  
  final url = Uri.parse(base_url);
  final headers = getHeadersIncludeAuth(context);
  final body = jsonEncode(request);
  try {
    final response = await http.post(url, headers: headers,body: body);
    if (response.statusCode == 200) {
      showSnack(context, "기록되었습니다.");
    } else if (response.statusCode >= 400) {
      showSnack(context, "잘못된 요청입니다." ,isError: true);
      return;
    } else {
      showSnack(context, errorMessage(response),isError: true);
      return;
    }
  } catch (e) {
    print('알 수 없는 오류 발생: $e');
    return;
  }
}

Future<List<BookLog>> getBookLog(BuildContext context, int id) async {
  
  List<BookLog> result = [];

  final url = Uri.parse("$base_url/$id");
  final headers = getHeadersIncludeAuth(context);

  try {
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final bookLogs = jsonDecode(response.body);
      for (var bookLog in bookLogs) {
        result.add(BookLog.fromJson(bookLog));
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