import 'package:bookmarkfront/api/book_log_api.dart';
import 'package:bookmarkfront/api/book_record_api.dart';
import 'package:bookmarkfront/models/book_record.dart';
import 'package:bookmarkfront/provider/book_record_provider.dart';
import 'package:bookmarkfront/screens/bookrecord/book_record_page.dart';
import 'package:bookmarkfront/utils/global_util.dart';
import 'package:bookmarkfront/widgets/app_bars.dart';
import 'package:bookmarkfront/widgets/custom_dropdown.dart';
import 'package:bookmarkfront/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookRecordWritePage extends StatefulWidget {
  const BookRecordWritePage({super.key,required this.bookRecord,required this.seconds});

  final BookRecord bookRecord;
  final int seconds;

  @override
  State<BookRecordWritePage> createState() => _BookRecordWritePageState();
}

class _BookRecordWritePageState extends State<BookRecordWritePage> {
  
  String? selectedValue = "미완독"; 

  List<int> pageStartItems = [];
  List<int> pageEndItems = [];

  int? selectedPageStart = 1;
  int? selectedPageEnd = 1;

  int questionCount = 4;
  List<String> titles = [
    "오늘 읽은 내용 요약",
    "가장 인상 깊었던 문장/구절",
    "내가 생각한 질문",
    "배운 점 또는 적용할 점",
  ];

  List<String> subTitles = [
    "오늘 읽은 내용을 요약해보세요.",
    "오늘 읽은 내용 중 가장 인상 깊었던 문장이나 구절은 무엇인가요? 이유도 적어보세요.",
    "오늘 읽은 내용에 대해 스스로 질문을 만들어보세요.",
    "오늘 읽은 내용에서 배운 점이나 실제로 적용할 수 있는 점은 무엇인가요?",
  ];

  List<TextEditingController> controllers = [];
  
  @override
  void initState() {
    super.initState();
    pageStartItems = List.generate(widget.bookRecord.book.page!, (index) => index + 1);
    controllers = List.generate(
      questionCount,
      (index) => TextEditingController(),
    );
    _updatePageEnd();
  }

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: CustomAppBar(
        backButton: false,
        text: "독서 기록하기",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: getMainPadding(),
          child: SafeArea(
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
                  Text(
                    "독서 진행",
                    style: TextStyle(
                      fontSize: 22.0,
                      letterSpacing: 22.0 * -0.02,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RadioListTile<String>(
                    value: "미완독",
                    groupValue: selectedValue,
                    title: Text(
                      "아직 완독하지 못했어요.",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                    contentPadding: EdgeInsets.zero,      
                    dense: true,                          
                    visualDensity: VisualDensity(horizontal: -3.0), 
                  ),
                  selectedValue=="미완독" ?
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      CustomDropdown<int>(
                        width: 70,
                        selectedValue: selectedPageStart,
                        items: pageStartItems,
                        itemToString: (v)=>'$v',
                        onChanged: (val) {
                          setState(() {
                            selectedPageStart = val!;
                            _updatePageEnd();
                          });
                        }
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "페이지 부터",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CustomDropdown<int>(
                        width: 70,
                        selectedValue: selectedPageEnd,
                        items: pageEndItems,
                        itemToString: (v)=>'$v',
                        onChanged: (val) {
                          setState(() {
                            selectedPageEnd = val!;
                          });
                        }
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "까지 읽었습니다.",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ) : SizedBox.shrink(),
                  RadioListTile<String>(
                    value: "완독",
                    groupValue: selectedValue,
                    title: Text(
                      "완독했어요!",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ), 
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                    contentPadding: EdgeInsets.zero,      
                    dense: true,                          
                    visualDensity: VisualDensity(horizontal: -3.0), 
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
                        "isOver" : selectedValue == "미완독" ? false : true,
                        "pageStart" : selectedPageStart,
                        "pageEnd" : selectedPageEnd,
                        "readingTime" : widget.seconds ~/ 60,
                        "questions" : subTitles,
                        "answers" : List.generate(questionCount, (index) => controllers[index].text),
                      };
                      await saveBookLog(context, request);
                      BookRecord? bookRecord = await getRecordById(context, widget.bookRecord.id);
                      if(bookRecord!=null) {
                        Provider.of<BookRecordProvider>(context,listen: false).updateBookRecord(bookRecord);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookRecordPage(bookRecord: bookRecord),
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
    );
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
  void _updatePageEnd() {
    setState(() {
      pageEndItems = List.generate(widget.bookRecord.book.page! - selectedPageStart!, (index) => selectedPageStart! + 1 + index);
      selectedPageEnd = selectedPageStart! + 1;
    });
  }
}