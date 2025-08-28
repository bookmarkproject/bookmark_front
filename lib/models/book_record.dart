import 'package:bookmarkfront/models/book.dart';

class BookRecord {
    final int id;
    final Book book;
    final int page;
    final int readingTime;
    final String status;
    
  BookRecord({
    required this.id,
    required this.page,
    required this.book,
    required this.readingTime,
    required this.status,
  });

  factory BookRecord.fromJson(Map<String, dynamic> json) {
    return BookRecord(
      id: json['id'],
      book: Book.fromJson(json['bookResponse']),
      page: json['page'],
      readingTime: json['readingTime'],
      status: json['status'],
    );
  }
}
