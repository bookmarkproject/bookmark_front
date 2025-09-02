import 'package:bookmarkfront/api/book_record_api.dart';
import 'package:bookmarkfront/models/book.dart';
import 'package:bookmarkfront/models/book_record.dart';
import 'package:bookmarkfront/provider/book_record_provider.dart';
import 'package:bookmarkfront/screens/bookrecord/book_record_page.dart';
import 'package:bookmarkfront/utils/global_util.dart';
import 'package:bookmarkfront/widgets/app_bars.dart';
import 'package:bookmarkfront/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({super.key,required this.book});

  final Book book;

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
 
  bool isRecording = false;
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    _fetchIsRecording();
    super.initState();
  }

  void _fetchIsRecording() async{
    bool response = await isRecordingBook(context, widget.book.isbn);
    setState(() {
      isRecording = response;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "도서 상세"
      ),
      body: SafeArea(
        child: Padding(
          padding: getMainPadding(),
          child: SingleChildScrollView(
            child: Center(
              child: _isLoading ? Center(child: CircularProgressIndicator()) :
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      _formatUrlPicture(widget.book.imageUrl),
                      width: 360,
                      height: 360,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    widget.book.title,
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
                    "${widget.book.author} - ${widget.book.publisher} 출판사",
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
                    "${_formatPublishDate(widget.book.publishDate)} 출판",
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
                    widget.book.contents,
                    style: TextStyle(
                      fontSize: 14.0,
                      letterSpacing: 12.0 * -0.02,
                      color: Color.fromRGBO(23, 20, 46, 0.62),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  isRecording == false ?
                  CustomFilledButton(
                    callback: () async{
                      final request = {
                        "isbn" : widget.book.isbn,
                        "title" : widget.book.title,
                        "author" : widget.book.author,
                        "contents" : widget.book.contents,
                        "imageUrl" : _formatUrlPicture(widget.book.imageUrl),
                        "publisher" : widget.book.publisher,
                        "publishDate" : widget.book.publishDate
                      };
                      BookRecord? bookRecord = await saveBookRecord(context, request);
                      if (bookRecord!=null){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookRecordPage(bookRecord: bookRecord)
                          )
                        );
                      }
                    }, 
                    text: "기록하기", 
                    fontsize: 15.0, 
                    width: 360,
                  ) : 
                  CustomFilledButton(
                    callback: () async{
                      BookRecord? bookRecord = _getBookRecord(widget.book.isbn);
                      if (bookRecord!=null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookRecordPage(bookRecord: bookRecord)
                          )
                        );
                      }
                    }, 
                    text: "계속 읽기", 
                    fontsize: 15.0, 
                    width: 360,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BookRecord? _getBookRecord(String isbn) {
    return Provider.of<BookRecordProvider>(context,listen: false).getByIsbn(isbn);
  }

  String _formatUrlPicture(String url) {
    return url.replaceAll("coversum", "cover500");
  }

  String _formatPublishDate(String date) {
    return date.replaceAll("-", ".");
  }
}