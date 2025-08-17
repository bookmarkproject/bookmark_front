import 'dart:ffi';

class Book {
    final int? id;
    final String isbn;
    final String title;
    final String contents;
    final String author;
    final double? rating;
    final int? page;
    final String imageUrl;
    final String publisher;
    final String publishDate;
  
  Book({
    this.id,
    required this.isbn,
    required this.title,
    required this.contents,
    required this.author,
    this.rating,
    this.page,
    required this.imageUrl,
    required this.publisher,
    required this.publishDate,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      isbn: json['isbn'],
      title: json['title'],
      contents: json['contents'],
      author: json['author'],
      rating: json['rating'],
      page: json['page'],
      imageUrl: json['imageUrl'],
      publisher: json['publisher'],
      publishDate: json['publishDate']
    );
  }
}
