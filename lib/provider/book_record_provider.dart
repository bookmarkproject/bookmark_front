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

  BookRecord? getByIsbn(String isbn) {
    for(var bookRecord in _bookRecords) {
      if (bookRecord.book.isbn == isbn) {
        return bookRecord;
      }
    }
    return null;
  }

  void updateBookRecord(BookRecord bookRecord) {
    for(int i = 0 ; i<_bookRecords.length; i++ ){
      if (_bookRecords[i].id == bookRecord.id){
        _bookRecords[i] = bookRecord;
      }
    }
    notifyListeners();
  }

  void clear() {
    _bookRecords = [];
    notifyListeners();
  }
}
