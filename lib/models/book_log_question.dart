import 'dart:ffi';

import 'package:bookmarkfront/models/book.dart';

class BookLogQuestion {
    final int id;
    final String question;
    final String answer;
    
  BookLogQuestion({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory BookLogQuestion.fromJson(Map<String, dynamic> json) {
    return BookLogQuestion(
      id: json['id'],
      question: json['question'],
      answer: json['answer'],
    );
  }
}
