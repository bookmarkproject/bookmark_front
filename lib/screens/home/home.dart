import 'package:bookmarkfront/provider/auth_provider.dart';
import 'package:bookmarkfront/provider/member_provider.dart';
import 'package:bookmarkfront/utils/global_util.dart';
import 'package:bookmarkfront/widgets/app_bars.dart';
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
  
  List<Map<String, dynamic>> books = [
    {"url":"https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F540854%3Ftimestamp%3D20250424113358","title":"오만과 편견","author":"제인 오스틴"},
    {"url":"https://search.pstatic.net/sunny/?src=https%3A%2F%2Fcdn.crowdpic.net%2Fdetail-thumb%2Fthumb_d_E95A5836D7FAFA21B6C841753BC7CB3E.jpg&type=sc960_832","title":"오만과 편견","author":"제인 오스틴"},
    {"url":"https://search.pstatic.net/sunny/?src=https%3A%2F%2Fcdn.crowdpic.net%2Fdetail-thumb%2Fthumb_d_E95A5836D7FAFA21B6C841753BC7CB3E.jpg&type=sc960_832","title":"오만과 편견","author":"제인 오스틴"}
  ];

  List<Map<String, dynamic>> recordingBooks = [
    {"url":"https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F540854%3Ftimestamp%3D20250424113358","title":"오만과 편견","author":"제인 오스틴","pageNow":153,"pageTotal":361,},
    {"url":"https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F540854%3Ftimestamp%3D20250424113358","title":"오만과 편견","author":"제인 오스틴","pageNow":153,"pageTotal":361,},
    {"url":"https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F540854%3Ftimestamp%3D20250424113358","title":"오만과 편견","author":"제인 오스틴","pageNow":153,"pageTotal":361,},
  ];

  @override
  Widget build(BuildContext context) {
    final member = Provider.of<MemberProvider>(context).member;
    return Scaffold(
      appBar: CustomAppBar(text: "책갈피",backButton : false),
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
                        "이달의 도서",
                        "이달의 추천 도서입니다."
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 205,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,  // 가로 스크롤
                          itemCount: books.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(right: index == books.length - 1 ? 0 : 14),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: _bookLayout(
                                  books[index]["url"], 
                                  books[index]["title"], 
                                  books[index]["author"],
                                ),
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

  Column _recordingBookLayout(recordingBook) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bookLayout(
            recordingBook["url"],
            recordingBook["title"], 
            recordingBook["author"],
          ),
          SizedBox(
            height: 6,
          ),
          SizedBox(
            width: 160,
            child: LinearProgressIndicator(
              value: recordingBook["pageNow"] / recordingBook["pageTotal"],  
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
            "${recordingBook["pageNow"]} / ${recordingBook["pageTotal"]} ${recordingBook["pageNow"]}/${recordingBook["pageTotal"]}",
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
                callback: (){}, 
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

  InkWell _bookLayout(url,title,author) {
    return InkWell(
      onTap: (){
        
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              url,
              width: 160,
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 15.0,
              letterSpacing: 15.0 * -0.02,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            author,
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
        InkWell(
          onTap: (){
            //
          },
          child: Icon(
            Icons.chevron_right,     
          ),
        ),
      ],
    );
  }
}
