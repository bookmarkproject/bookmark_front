import 'package:bookmarkfront/api/book_log_question_api.dart';
import 'package:bookmarkfront/models/book_log_question.dart';
import 'package:bookmarkfront/models/book_record.dart';
import 'package:bookmarkfront/utils/global_util.dart';
import 'package:bookmarkfront/widgets/app_bars.dart';
import 'package:flutter/material.dart';

class BookLogDetailPage extends StatefulWidget {
  const BookLogDetailPage({super.key,required this.bookRecord, required this.bookLogId});

  final BookRecord bookRecord;
  final int bookLogId;

  @override
  State<BookLogDetailPage> createState() => _BookLogDetailPageState();
}

class _BookLogDetailPageState extends State<BookLogDetailPage> {
  
  List<BookLogQuestion> bookLogQuestions = [];

  List<String> titles = [
    "오늘 읽은 내용 요약",
    "가장 인상 깊었던 문장/구절",
    "내가 생각한 질문",
    "배운 점 또는 적용할 점",
  ];

  @override
  void initState() {
    _fetchBookLogQuestion();
  }

  void _fetchBookLogQuestion() async{
    List<BookLogQuestion> response = await getBookLogQuestion(context, widget.bookLogId);
    setState(() {
      bookLogQuestions = response;
      print(bookLogQuestions[0].question);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "독서 기록 로그"),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: getMainPadding(),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.bookRecord.book.imageUrl,
                      width: 360,
                      height: 360,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    widget.bookRecord.book.title,
                    style: TextStyle(
                      fontSize: 20.0,
                      letterSpacing: 22.0 * -0.01,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "${widget.bookRecord.book.author} - ${widget.bookRecord.book.publisher} 출판사",
                    style: TextStyle(
                      fontSize: 14.0,
                      letterSpacing: 12.0 * -0.02,
                      color: Color.fromRGBO(23, 20, 46, 0.62),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                      List.generate(bookLogQuestions.length, (i) {
                      return _QuestionsLayout(
                        titles[i],
                        bookLogQuestions[i].question,
                        bookLogQuestions[i].answer,
                        i, 
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _QuestionsLayout(title,subTitle,answer,idx) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${idx+1}. $title",
          style: TextStyle(
            fontSize: 22.0,
            letterSpacing: 22.0 * -0.02,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          subTitle,
          style: TextStyle(
            fontSize: 14.0,
            letterSpacing: 14.0 * -0.02,
            color: Color.fromRGBO(23, 20, 46, 0.62),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          width: 360,
          constraints: BoxConstraints(
            minHeight: 5 * 20.0, 
          ),
          padding: EdgeInsets.all(8), 
          decoration: BoxDecoration(
            color: Color.fromRGBO(126, 52, 37, 0.09), // 배경색
            borderRadius: BorderRadius.circular(16), // 둥근 모서리
          ),
          child: Text(
            answer,
            style: TextStyle(
              fontSize: 14.0,
              letterSpacing: 14.0 * -0.02,
              color: Color.fromRGBO(23, 20, 46, 0.62),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 40,
        )
      ],
    );
  }
}