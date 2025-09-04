import 'package:bookmarkfront/api/book_log_api.dart';
import 'package:bookmarkfront/models/book_record.dart';
import 'package:bookmarkfront/screens/bookrecord/book_record_page.dart';
import 'package:bookmarkfront/utils/global_util.dart';
import 'package:bookmarkfront/widgets/app_bars.dart';
import 'package:bookmarkfront/widgets/custom_filled_button.dart';
import 'package:bookmarkfront/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';

class BookRecordOverWirtePage extends StatefulWidget {
  const BookRecordOverWirtePage({super.key,required this.bookRecord});
  
  final BookRecord bookRecord;

  @override
  State<BookRecordOverWirtePage> createState() => _BookRecordOverWirtePageState();
}

class _BookRecordOverWirtePageState extends State<BookRecordOverWirtePage> {
  
  int questionCount = 7;

  List<String> titles = [
    "책의 핵심",
    "나의 깨달음",
    "인상 깊은 장면",
    "적용과 변화",
    "비판적 시선",
    "나와의 연결고리",
    "여운과 확장",
  ];

  List<String> subTitles = [
    "이 책이 전하려는 가장 중요한 메시지는 무엇일까요?",
    "이 책을 읽고 나에게 생긴 새로운 시각은 무엇일까요?",
    "기억에 오래 남을 만한 문장이나 장면은 무엇일까요?",
    "이 책의 내용을 내 삶에 어떻게 적용할 수 있을까요?",
    "책에서 아쉬웠던 점이나 동의하기 어려운 주장은 무엇일까요?",
    "이 책은 내 삶의 어떤 경험과 연결될까요?",
    "이 책 다음에 읽으면 좋을 만한 책은 무엇일까요?"
  ];

  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    controllers = List.generate(
      questionCount,
      (index) => TextEditingController(),
    );
  }

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: CustomAppBar(
        text: "완독 감상평 작성",
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); 
        },
        child: SafeArea(
          child: Padding(
            padding: getMainPadding(),
            child: SingleChildScrollView(
              child: Center(
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
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                        List.generate(questionCount, (i) {
                        return _QuestionsLayout(
                          titles[i],
                          subTitles[i],
                          controllers[i],
                          i, 
                        );
                      }),
                    ),
                    CustomFilledButton(
                      callback: ()async{
                        final request = {
                          "bookRecordId" : widget.bookRecord.id,
                          "questions" : subTitles,
                          "answers" : List.generate(questionCount, (index) => controllers[index].text),
                          "logType" : "완독",
                        };
                        if(_checkInput()) {
                          await saveBookLogOver(context, request);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookRecordPage(bookRecord: widget.bookRecord),
                            )
                          );
                        }
                      }, 
                      text: "기록하기", 
                      fontsize: 14.0, 
                      width: 360,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _checkInput() {
    for(var controllers in controllers) {
      if (controllers.text.isEmpty) {
        showSnack(context, "모든 질문에 대한 답변을 해주세요.",isError: true);
        return false;
      }
    }
    return true;
  }

  Column _QuestionsLayout(title,subTitle,controller,idx) {
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
          decoration: BoxDecoration(
            color: Color.fromRGBO(126, 52, 37, 0.09), // 배경색
            borderRadius: BorderRadius.circular(16), // 둥근 모서리
          ),
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null, 
            minLines: 1,    
            style: const TextStyle(  
              fontSize: 12,         
              color: Colors.black,   
            ),
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "여기에 답변하세요",
              hintStyle: TextStyle(
                fontSize: 12,          // 힌트 텍스트 크기
                color: Color.fromRGBO(0,0,0,0.5),    // 색상 변경도 가능
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 12,  // 위아래 여백
                horizontal: 12 // 좌우 여백
              ),
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