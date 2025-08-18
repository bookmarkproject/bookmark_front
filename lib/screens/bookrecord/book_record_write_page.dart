import 'package:bookmarkfront/models/book_record.dart';
import 'package:bookmarkfront/utils/global_util.dart';
import 'package:bookmarkfront/widgets/app_bars.dart';
import 'package:flutter/material.dart';

class BookRecordWritePage extends StatelessWidget {
  const BookRecordWritePage({super.key,required this.bookRecord,required this.seconds});

  final BookRecord bookRecord;
  final int seconds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "독서 기록하기",
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: getMainPadding(),
            child: Column(
              children: [
                Text(
                  "${bookRecord.book.title}-$seconds"
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}