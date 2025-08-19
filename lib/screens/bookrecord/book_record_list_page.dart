import 'package:bookmarkfront/models/book_record.dart';
import 'package:bookmarkfront/provider/book_record_provider.dart';
import 'package:bookmarkfront/screens/bookrecord/book_record_page.dart';
import 'package:bookmarkfront/utils/global_util.dart';
import 'package:bookmarkfront/widgets/app_bars.dart';
import 'package:bookmarkfront/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookRecordListPage extends StatefulWidget {
  const BookRecordListPage({super.key});

  @override
  State<BookRecordListPage> createState() => _BookRecordListPageState();
}

class _BookRecordListPageState extends State<BookRecordListPage> {
  
  List<BookRecord> recordingBooks = [];
  
  @override
  Widget build(BuildContext context) {
    recordingBooks = Provider.of<BookRecordProvider>(context,listen: true).bookRecords;
    return Scaffold(
      appBar: CustomAppBar(
        text: "기록 중인 책"
      ),
      body: Center(
        child: Padding(
          padding: getMainPadding(),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: recordingBooks.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: index == recordingBooks.length - 1 ? 0 : 20),
                      child: ClipRRect(
                        child: _layout(recordingBooks[index]),
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: getBottomBar(
        context, 2
      ),
    );
  }

  InkWell _layout(BookRecord bookrecord) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookRecordPage(bookRecord: bookrecord),
          )
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            child: Image.network(
              bookrecord.book.imageUrl,
              width: 60,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bookrecord.book.title.length >= 22 ? "${bookrecord.book.title.substring(0,22)}..." : bookrecord.book.title,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                bookrecord.book.author.length >= 22 ? "${bookrecord.book.author.substring(0,22)}..." : bookrecord.book.author,
                style: TextStyle(
                  fontSize: 13.0,
                  color: Color.fromRGBO(23, 20, 46, 0.62),
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}