import 'package:bookmarkfront/api/utils/api_basic_util.dart';
import 'package:bookmarkfront/models/book_record.dart';
import 'package:bookmarkfront/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


String base_url = "${getHost()}/book/record";

Future<BookRecord?> saveBookRecord(BuildContext context, Map<String,dynamic> request) async {
  
  final url = Uri.parse(base_url);
  final headers = getHeadersIncludeAuth(context);
  final body = jsonEncode(request);
  try {
    final response = await http.post(url, headers: headers,body: body);

    if (response.statusCode == 200) {
      showSnack(context, "기록되었습니다.");
      BookRecord bookRecord = BookRecord.fromJson(jsonDecode(response.body));
      return bookRecord;
    } else if (response.statusCode == 400) {
      showSnack(context, "기록할 수 없는 책입니다." ,isError: true);
      return null;
    } else {
      showSnack(context, errorMessage(response),isError: true);
      return null;
    }
  } catch (e) {
    print('알 수 없는 오류 발생: $e');
    return null;
  }
}


Future<List<BookRecord>> getMyBookRecord(BuildContext context) async {
  
  List<BookRecord> result = [];

  final url = Uri.parse("$base_url/me");
  final headers = getHeadersIncludeAuth(context);

  print(headers);

  try {
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final bookRecords = jsonDecode(response.body);
      for (var bookRecord in bookRecords) {
        result.add(BookRecord.fromJson(bookRecord));
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