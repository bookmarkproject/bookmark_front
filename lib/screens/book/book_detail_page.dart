import 'package:bookmarkfront/api/book_record_api.dart';
import 'package:bookmarkfront/models/book.dart';
import 'package:bookmarkfront/models/book_record.dart';
import 'package:bookmarkfront/utils/global_util.dart';
import 'package:bookmarkfront/widgets/app_bars.dart';
import 'package:bookmarkfront/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
  const BookDetailPage({super.key,required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "도서 상세"
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: getMainPadding(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    _formatUrlPicture(book.imageUrl),
                    width: 360,
                    height: 360,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  book.title,
                  style: TextStyle(
                    fontSize: 22.0,
                    letterSpacing: 22.0 * -0.01,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  "${book.author} - ${book.publisher} 출판사",
                  style: TextStyle(
                    fontSize: 14.0,
                    letterSpacing: 12.0 * -0.02,
                    color: Color.fromRGBO(23, 20, 46, 0.62),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  "${_formatPublishDate(book.publishDate)} 출판",
                  style: TextStyle(
                    fontSize: 14.0,
                    letterSpacing: 12.0 * -0.02,
                    color: Color.fromRGBO(23, 20, 46, 0.62),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  book.contents,
                  style: TextStyle(
                    fontSize: 14.0,
                    letterSpacing: 12.0 * -0.02,
                    color: Color.fromRGBO(23, 20, 46, 0.62),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                CustomFilledButton(
                  callback: () async{
                    final request = {
                      "isbn" : book.isbn,
                      "title" : book.title,
                      "author" : book.author,
                      "contents" : book.contents,
                      "imageUrl" : _formatUrlPicture(book.imageUrl),
                      "publisher" : book.publisher,
                      "publishDate" : book.publishDate
                    };
                    BookRecord? bookRecord = await saveBookRecord(context, request);
                    if (bookRecord!=null){
                      print(bookRecord.book.title);
                    }
                  }, 
                  text: "기록하기", 
                  fontsize: 15.0, 
                  width: 360,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatUrlPicture(String url) {
    return url.replaceAll("coversum", "cover500");
  }

  String _formatPublishDate(String date) {
    return date.replaceAll("-", ".");
  }
}