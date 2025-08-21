import 'package:bookmarkfront/api/utils/api_basic_util.dart';
import 'package:bookmarkfront/api/utils/dio/dio_client.dart';
import 'package:bookmarkfront/models/book_record.dart';
import 'package:bookmarkfront/provider/book_record_provider.dart';
import 'package:bookmarkfront/widgets/custom_snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';


String base_url = "${getHost()}/book/record";

Future<BookRecord?> saveBookRecord(BuildContext context, Map<String,dynamic> request) async {
  
  final dioClient = Provider.of<DioClient>(context,listen: false);

  try {
    final response = await dioClient.dio.post(base_url,data: request);

    if (response.statusCode == 200) {
      showSnack(context, "기록되었습니다.");
      BookRecord bookRecord = BookRecord.fromJson(response.data);
      Provider.of<BookRecordProvider>(context,listen: false).appendBookRecords(bookRecord);
      return bookRecord;
    } 
    return null;
  } on DioException catch (e) {
    print('Dio 오류 발생: ${e.response?.statusCode}');
    print("Dio 오류 메시지 : ${e.response?.data['message']}");

    if (e.response?.statusCode == 400) {
      showSnack(context, "기록할 수 없는 책입니다." ,isError: true);
      return null;
    } 

    return null;
  } catch (e) {
    print('알 수 없는 오류 발생: $e');
    return null;
  }
}


Future<List<BookRecord>> getMyBookRecord(BuildContext context) async {
  
  List<BookRecord> result = [];

  final dioClient = Provider.of<DioClient>(context,listen: false);
  
  try {
    final response = await dioClient.dio.get("$base_url/me");

    if (response.statusCode == 200) {
      final bookRecords = response.data;
      for (var bookRecord in bookRecords) {
        result.add(BookRecord.fromJson(bookRecord));
      }
      Provider.of<BookRecordProvider>(context,listen: false).setBookRecords(result);
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

Future<BookRecord?> getRecordById(BuildContext context, int id) async {

  final dioClient = Provider.of<DioClient>(context,listen: false);

  try {
    final response = await dioClient.dio.get("$base_url/$id");
   
    if (response.statusCode == 200) {
      BookRecord bookRecord = BookRecord.fromJson(response.data);
      return bookRecord;
    } 
    return null;
  } on DioException catch (e) {
      print('Dio 오류 발생: ${e.response?.statusCode}');
      print("Dio 오류 메시지 : ${e.response?.data['message']}");

      return null;
    } catch (e) {
      print('알 수 없는 오류 발생: $e');
      return null;
    }
}


Future<bool> isRecordingBook(BuildContext context, String isbn) async {

  final dioClient = Provider.of<DioClient>(context,listen: false);

  try {
    final response = await dioClient.dio.get("$base_url/recording?isbn=$isbn");
   
    if (response.statusCode == 200) {
      bool isRecording = response.data;
      return isRecording;
    } 
    return false;
  } on DioException catch (e) {
      print('Dio 오류 발생: ${e.response?.statusCode}');
      print("Dio 오류 메시지 : ${e.response?.data['message']}");

      return false;
    } catch (e) {
      print('알 수 없는 오류 발생: $e');
      return false;
    }
}