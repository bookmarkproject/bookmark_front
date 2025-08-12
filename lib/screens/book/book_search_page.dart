import 'package:bookmarkfront/utils/global_util.dart';
import 'package:bookmarkfront/widgets/app_bars.dart';
import 'package:flutter/material.dart';

class BookSearchPage extends StatefulWidget {
  const BookSearchPage({super.key});

  @override
  State<BookSearchPage> createState() => _BookSearchPageState();
}

class _BookSearchPageState extends State<BookSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "도서 검색"
      ),
      body: Center(
        child: Padding(
          padding: getMainPadding(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "책 검색 페이지",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}