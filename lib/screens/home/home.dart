import 'package:bookmarkfront/api/book_api.dart';
import 'package:bookmarkfront/api/book_record_api.dart';
import 'package:bookmarkfront/models/book.dart';
import 'package:bookmarkfront/models/book_record.dart';
import 'package:bookmarkfront/provider/auth_provider.dart';
import 'package:bookmarkfront/provider/member_provider.dart';
import 'package:bookmarkfront/screens/book/book_detail_page.dart';
import 'package:bookmarkfront/utils/global_util.dart';
import 'package:bookmarkfront/widgets/app_bars.dart';
import 'package:bookmarkfront/widgets/bottom_navigation_bar.dart';
import 'package:bookmarkfront/widgets/custom_filled_button.dart';
import 'package:bookmarkfront/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  List<Book> bestSellers = [];

  List<Book> latestBooks = [];

  List<BookRecord> recordingBooks = [];

  @override
  void initState() {
    super.initState();
    _initFetchData();
  }

  void _initFetchData() async{
    List<Book> bestSellerResponse = await getBestSellers(context);
    setState(() {
      bestSellers = bestSellerResponse;
    });
    List<BookRecord> bookRecordsResponse = await getMyBookRecord(context);
    setState(() {
      recordingBooks = bookRecordsResponse;
    });
    List<Book> latestSellerResponse = await getLatest(context);
    setState(() {
      latestBooks = latestSellerResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    final member = Provider.of<MemberProvider>(context).member;
    return Scaffold(
      appBar: CustomAppBar(text: "책갈피",backButton : false),
      bottomNavigationBar: getBottomBar(context, 0),
      body: Center(
        child: Padding(
          padding: getMainPadding(),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      _titleAndSubTitle(
                        "이달의 베스트셀러",
                        "이달의 베스트셀러 도서입니다."
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 205,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,  // 가로 스크롤
                          itemCount: bestSellers.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(right: index == bestSellers.length - 1 ? 0 : 14),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: _bookLayout(bestSellers[index]),
                              ),
                            );
                          }
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      _titleAndSubTitle(
                        "신작 도서",
                        "이달의 신작 도서입니다."
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 205,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,  // 가로 스크롤
                          itemCount: latestBooks.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(right: index == latestBooks.length - 1 ? 0 : 14),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: _bookLayout(latestBooks[index]),
                              ),
                            );
                          }
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      _titleAndSubTitle(
                        "현재 기록 중인 책", 
                        "${member!.nickname}님이 기록 중인 책 입니다.",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 305,
                        child: recordingBooks.isEmpty ? 
                        Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "현재 기록 중인 책이 없습니다.",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomFilledButton(
                              callback: (){}, 
                              text: "책 검색하기", 
                              fontsize: 14.0, 
                              width: 160,
                            )
                          ],
                        )
                        :
                        ListView.builder(
                          scrollDirection: Axis.horizontal,  // 가로 스크롤
                          itemCount: recordingBooks.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(right: index == recordingBooks.length - 1 ? 0 : 14),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: _recordingBookLayout(recordingBooks[index])
                              ),
                            );
                          }
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  Column _recordingBookLayout(BookRecord recordingBook) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bookLayout(recordingBook.book),
          SizedBox(
            height: 6,
          ),
          SizedBox(
            width: 160,
            child: LinearProgressIndicator(
              value: recordingBook.page / recordingBook.book.page!,  
              minHeight: 12,
              backgroundColor: Colors.grey[150],
              valueColor: AlwaysStoppedAnimation<Color>(getMainColor()),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            "${recordingBook.page} / ${recordingBook.book.page}  ${_calPercent(recordingBook.page, recordingBook.book.page!)}%",
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              CustomFilledButton(
                callback: (){}, 
                text: "계속 읽기", 
                fontsize: 9.0, 
                width: 75,
                height: 40,
                borderRadius: 10.0,
              ),
              SizedBox(
                width: 10,
              ),
              CustomFilledButton(
                callback: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDetailPage(book : recordingBook.book),
                    )
                  );
                }, 
                text: "책 정보 보기", 
                fontsize: 9.0, 
                width: 75,
                height: 40,
                borderRadius: 10.0,
                backgroundColor: Color.fromRGBO(47, 37, 126, 0.09),
                fontColor: Colors.black,
              ),
            ],
          ),
        ],
      );
  }

  InkWell _bookLayout(Book book) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailPage(book : book),
          )
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              book.imageUrl,
              width: 160,
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            book.title.length >= 8 ? "${book.title.substring(0,8)}..." : book.title,
            style: TextStyle(
              fontSize: 15.0,
              letterSpacing: 15.0 * -0.02,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            book.author.length >= 8 ? "${book.author.substring(0,8)}..." : book.author,
            style: TextStyle(
              fontSize: 13.0,
              letterSpacing: 15.0 * -0.02,
              color: Color.fromRGBO(23, 20, 46, 0.62),
            ),
          ),
        ],
      ),
    );
  }

  Row _titleAndSubTitle(title,subTitle) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title, 
                style: TextStyle(
                  fontSize: 22.0,
                  letterSpacing: -0.02 * 22.0,
                  fontWeight: FontWeight.bold
                )
              ),
              Text(
                subTitle, 
                style: TextStyle(
                  color: Color.fromRGBO(23, 20, 46, 0.62),
                )
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  String _calPercent(int num1,int num2) {
    return ((num1/num2)*100).toStringAsFixed(2);
  }
}
