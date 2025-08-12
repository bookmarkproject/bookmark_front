import 'package:bookmarkfront/api/utils/api_basic_util.dart';
import 'package:bookmarkfront/models/book.dart';
import 'package:bookmarkfront/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String base_url = "${getHost()}/book";

Future<List<Book>> getBestSellers(BuildContext context) async {
  List<Book> result = [];
  
  final url = Uri.parse("$base_url/bestseller");
  final headers = getHeadersIncludeAuth(context);

  try {
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final books = jsonDecode(response.body);
      for (var book in books) {
        result.add(Book.fromJson(book));
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

Future<List<Book>> getLatest(BuildContext context) async {
  List<Book> result = [];
  
  final url = Uri.parse("$base_url/latest");
  final headers = getHeadersIncludeAuth(context);

  try {
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final books = jsonDecode(response.body);
      for (var book in books) {
        result.add(Book.fromJson(book));
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


Future<List<Book>> getBooksByQuery(BuildContext context,String query) async {
  List<Book> result = [];
  
  final url = Uri.parse("$base_url/search?query=$query");
  final headers = getHeadersIncludeAuth(context);

  try {
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final books = jsonDecode(response.body);
      for (var book in books) {
        result.add(Book.fromJson(book));
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