import 'package:bookmarkfront/models/book_record.dart';
import 'package:flutter/material.dart';

class BookRecordProvider with ChangeNotifier {
  List<BookRecord> _bookRecords = [];

  List<BookRecord> get bookRecords => _bookRecords;

  void setBookRecords(List<BookRecord> bookRecords){
    _bookRecords = bookRecords;
    notifyListeners();
  }

  void appendBookRecords(BookRecord bookRecord) {
    _bookRecords.add(bookRecord);
    notifyListeners();
  }

  void clear() {
    _bookRecords = [];
    notifyListeners();
  }
}
