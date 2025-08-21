import 'package:bookmarkfront/models/member.dart';
import 'package:bookmarkfront/provider/auth_provider.dart';
import 'package:bookmarkfront/provider/member_provider.dart';
import 'package:bookmarkfront/utils/global_util.dart';
import 'package:bookmarkfront/widgets/app_bars.dart';
import 'package:bookmarkfront/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  
  final List<Map<String,dynamic>> menus = [
    {
      "icon" : Icons.menu_book,
      "title" : "기록 중인 책 보기",
      "onTap" : (){},
    },
    {
      "icon" : Icons.support_agent,
      "title" : "고객 센터",
      "onTap" : (){},
    },
    {
      "icon" : Icons.privacy_tip,
      "title" : "개인 정보 수집 및 이용",
      "onTap" : (){},
    },
    {
      "icon" : Icons.logout,
      "title" : "로그아웃",
      "onTap" : (){},
    },
    {
      "icon" : Icons.person_remove,
      "title" : "회원탈퇴",
      "onTap" : (){},
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    Member? member = Provider.of<MemberProvider>(context,listen: true).member;
    return Scaffold(
      appBar: CustomAppBar(text: "마이 페이지"),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: getMainPadding(),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.network(
                        '',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 80,
                            height: 80,
                            color: Colors.grey[300],
                            child: const Icon(Icons.person, size: 60, color: Colors.white),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 3, 
                      right: 6,  
                      child: GestureDetector(
                        onTap: () {
                          
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ]
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  member != null ? member.nickname : "알 수 없음",
                  style: TextStyle(
                    fontSize: 28.0,
                    letterSpacing: 28.0 * -0.02,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      member != null ? member.name : "알 수 없음"
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      member != null ? member.email : "알 수 없음"
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  thickness: 1.0,
                  color: Color.fromRGBO(110, 80, 73, 0.2)
                ),
                Column(
                  children: List.generate(
                    menus.length, 
                    (index){
                      final menu = menus[index];
                      return Column(
                        children: [
                          SizedBox(height: 25),
                          _menuLayout(
                            (){ 
                              _handleMenuTap(menu['title'], context);
                            },
                            menu['icon'],
                            menu['title'],
                          ),
                        ],
                      );
                    }
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: getBottomBar(context, 3),
    );
  }

  InkWell _menuLayout(VoidCallback onTap, IconData icons, String title) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Icon(
            icons,
            color: Colors.black,
            size: 25,
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 18.0 * -0.02,
            ),
          )
        ],
      ),
    );
  }

  void _handleMenuTap(String title, BuildContext context) async{
    switch(title) {
      case "기록 중인 책 보기":
        Navigator.pushNamed(context, '/book/record');
        break;
      case "고객 센터":
        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(   // 모서리 둥글게
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          isScrollControlled: true, // 내용이 많을 때 스크롤 가능
          builder: (context) {
            return Padding(
              padding: getMainPadding(),
              child: SizedBox(
                width: 360,
                height: 100,
                child: Column(
                  mainAxisSize: MainAxisSize.min, // 내용 높이에 맞게
                  children: [
                    Row(
                      children: [
                        Icon(Icons.mail),
                        SizedBox(
                          width: 15,
                        ),
                        const Text(
                          "Gmail : bookmarkapp2025@gmail.com",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("닫기"),
                    ),
                  ],
                ),
              ),
            );
          }
          );
        break;
      case "개인 정보 수집 및 이용":
  
        break;
      case "로그아웃":
        await Provider.of<AuthProvider>(context,listen: false).clearToken();
        await Provider.of<AuthProvider>(context,listen: false).clearRefreshToken();
        Navigator.pushReplacementNamed(context, '/');
        break;
      case "회원탈퇴":
  
        break;
    }
  }
}