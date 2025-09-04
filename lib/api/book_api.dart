import 'package:bookmarkfront/api/utils/api_basic_util.dart';
import 'package:bookmarkfront/api/utils/dio/dio_client.dart';
import 'package:bookmarkfront/models/book.dart';
import 'package:bookmarkfront/widgets/custom_snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String base_url = "${getHost()}/book";

Future<List<Book>> getBestSellers(BuildContext context) async {
  List<Book> result = [];
  
  final dioClient = Provider.of<DioClient>(context,listen: false);
  
  try {
    final response = await dioClient.dio.get("$base_url/bestseller");
    
    if (response.statusCode == 200) {
      final books = response.data;
      for (var book in books) {
        result.add(Book.fromJson(book));
      }
      return result;
    } 
    return [];
  } on DioException catch (e) {
    print('Dio 오류 발생: ${e.response?.statusCode}');

    return [];
  } catch (e) {
    print('알 수 없는 오류 발생: $e');
    return [];
  }
}

Future<List<Book>> getLatest(BuildContext context) async {
  List<Book> result = [];
  
  final dioClient = Provider.of<DioClient>(context,listen: false);
  
  try {
    final response = await dioClient.dio.get("$base_url/latest");

    if (response.statusCode == 200) {
      final books = response.data;
      for (var book in books) {
        result.add(Book.fromJson(book));
      }
      return result;
    } else {
      showSnack(context, errorMessage(response),isError: true);
      return [];
    }
  } on DioException catch (e) {
    print('Dio 오류 발생: ${e.response?.statusCode}');

    return [];
  } catch (e) {
    print('알 수 없는 오류 발생: $e');
    return [];
  }
}


Future<List<Book>> getBooksByQuery(BuildContext context,String query) async {
  List<Book> result = [];
  
  final dioClient = Provider.of<DioClient>(context,listen: false);
  
  try {
    final response = await dioClient.dio.get("$base_url/search?query=$query");

    if (response.statusCode == 200) {
      final books = response.data;
      for (var book in books) {
        result.add(Book.fromJson(book));
      }
      return result;
    } 
    return [];
  } on DioException catch (e) {
    print('Dio 오류 발생: ${e.response?.statusCode}');

    return [];
  } catch (e) {
    print('알 수 없는 오류 발생: $e');
    return [];
  }
}