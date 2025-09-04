import 'package:bookmarkfront/api/book_log_api.dart';
import 'package:bookmarkfront/models/book_log.dart';
import 'package:bookmarkfront/models/book_record.dart';
import 'package:bookmarkfront/screens/booklog/book_log_detail_over_page.dart';
import 'package:bookmarkfront/screens/booklog/book_log_detail_page.dart';
import 'package:bookmarkfront/screens/bookrecord/book_record_over_wirte_page.dart';
import 'package:bookmarkfront/screens/bookrecord/book_record_timer_page.dart';
import 'package:bookmarkfront/utils/global_util.dart';
import 'package:bookmarkfront/widgets/app_bars.dart';
import 'package:bookmarkfront/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';

class BookRecordPage extends StatefulWidget {
  const BookRecordPage({super.key,required this.bookRecord});

  final BookRecord bookRecord;

  @override
  State<BookRecordPage> createState() => _BookRecordPageState();
}

class _BookRecordPageState extends State<BookRecordPage> {
  
  List<BookLog> bookLogs = [];
  List<BookLog> bookLogsIsOver = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBookLog();
  }

  void _fetchBookLog() async{
    List<BookLog> responses = await getBookLog(context, widget.bookRecord.id);
    List<BookLog> tempLogNormal = [];
    List<BookLog> tempLogIsOver = [];
    for(var response in responses) {
      if (response.logType=="일반") {
        tempLogNormal.add(response);
      } else if (response.logType=="완독") {
        tempLogIsOver.add(response);
      }
    }
    
    setState(() {
      bookLogs = tempLogNormal;
      bookLogsIsOver = tempLogIsOver;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "독서 기록",
      ),
      body: SafeArea(
        child: Padding(
          padding: getMainPadding(),
          child: SingleChildScrollView(
            child: Center(
              child: _isLoading ? Center(child: CircularProgressIndicator()):
              Column(
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
                    "독서 요약",
                    style: TextStyle(
                      fontSize: 22.0,
                      letterSpacing: 22.0 * -0.02,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "총 독서 시간",
                            style: TextStyle(
                              fontSize: 15.0,
                              letterSpacing: 15.0 * -0.005,
                              color: Color.fromRGBO(23, 20, 46, 0.62)
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${widget.bookRecord.readingTime} 분",
                            style: TextStyle(
                              fontSize: 17.0,
                              letterSpacing: 17.0 * -0.02,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "총 페이지",
                            style: TextStyle(
                              fontSize: 15.0,
                              letterSpacing: 15.0 * -0.005,
                              color: Color.fromRGBO(23, 20, 46, 0.62)
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${widget.bookRecord.page}  /  ${widget.bookRecord.book.page}",
                            style: TextStyle(
                              fontSize: 17.0,
                              letterSpacing: 17.0 * -0.02,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 360,
                    child: LinearProgressIndicator(
                      value: widget.bookRecord.page / widget.bookRecord.book.page!,  
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
                    "${widget.bookRecord.page} / ${widget.bookRecord.book.page}  ${_calPercent(widget.bookRecord.page, widget.bookRecord.book.page!)}%",
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  widget.bookRecord.status == "독서중" ?
                  CustomFilledButton(
                    callback: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookRecordTimerPage(bookRecord: widget.bookRecord)
                        ),
                      );
                    }, 
                    text: "계속 읽기",
                    fontColor: Colors.white, 
                    fontsize: 13.0, 
                    width: 360,
                  ) : SizedBox.shrink(),
                  SizedBox(
                    height: 15,
                  ),
                  widget.bookRecord.status == "완독" ?
                  CustomFilledButton(
                    callback: (){
                     Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => 
                            bookLogsIsOver.isEmpty ? 
                            BookRecordOverWirtePage(bookRecord: widget.bookRecord) 
                            : BookLogDetailOverPage(bookRecord: widget.bookRecord,bookLogId: bookLogsIsOver[0].id) 
                        ),
                      );
                    }, 
                    text: "완독 감상평",
                    backgroundColor: Colors.grey[300],
                    fontColor: Colors.black, 
                    fontsize: 13.0, 
                    width: 360,
                  ) : SizedBox.shrink(),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "지난 독서 기록",
                    style: TextStyle(
                      fontSize: 22.0,
                      letterSpacing: 22.0 * -0.02,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  bookLogs.isEmpty ? 
                  Text(
                    "저장된 독서 기록이 없습니다.",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                  :      
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(), 
                    itemCount: bookLogs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: index == bookLogs.length - 1 ? 0 : 25),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: _bookLogLayout(bookLogs[index]),
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InkWell _bookLogLayout(BookLog bookLog) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookLogDetailPage(bookRecord: widget.bookRecord,bookLogId: bookLog.id,),
          )
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Container(
              width: 40,
              height: 40,
              color: getMainColor(),
              child: Icon(
                Icons.bookmark,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                "${_formatReadingDate(bookLog.readingDate)} 독서",
                style: TextStyle(
                  fontSize: 17.0,
                  letterSpacing: 17.0 * -0.02,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "페이지 : ${bookLog.pageStart} ~ ${bookLog.pageEnd}",
                style: TextStyle(
                  fontSize: 13.0,
                  letterSpacing: 13.0 * -0.02,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                "시간 : ${bookLog.readingTime} 분",
                style: TextStyle(
                  fontSize: 13.0,
                  letterSpacing: 13.0 * -0.02,
                  fontWeight: FontWeight.normal,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  String _formatReadingDate(String date) {
    return date.replaceAll("-", ".");
  }

  String _calPercent(int num1,int num2) {
    return ((num1/num2)*100).toStringAsFixed(2);
  }
}