import 'dart:ffi';

import 'package:bookmarkfront/models/book.dart';

class BookLog {
    final int id;
    final int pageStart;
    final int pageEnd;
    final int readingTime;
    final String readingDate;
    
  BookLog({
    required this.id,
    required this.pageStart,
    required this.pageEnd,
    required this.readingTime,
    required this.readingDate,
  });

  factory BookLog.fromJson(Map<String, dynamic> json) {
    return BookLog(
      id: json['id'],
      pageStart:  json['pageStart'],
      pageEnd: json['pageEnd'],
      readingTime: json['readingTime'],
      readingDate: json['readingDate'],
    );
  }
}
