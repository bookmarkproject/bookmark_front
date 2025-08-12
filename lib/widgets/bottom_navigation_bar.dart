import 'package:bookmarkfront/utils/global_util.dart';
import 'package:flutter/material.dart';

BottomNavigationBar getBottomBar(context,currentIndex) {
  return BottomNavigationBar(
    currentIndex: currentIndex,
    onTap: (index) {
      if (index == 0) { // 홈 화면으로 이동
        Navigator.pushReplacementNamed(context, '/home');
      }
      if (index == 1) { // 공지 조회 화면으로 이동
        Navigator.pushReplacementNamed(context, '/home');
      }
      if (index == 2) { // 리플렉션 화면으로 이동
        Navigator.pushReplacementNamed(context, '/home');
      }
       if (index == 3) { // 리플렉션 화면으로 이동
        Navigator.pushReplacementNamed(context, '/home');
      }
    },
    items: const [ // 하단바 아이콘 설정
      BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
      BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
      BottomNavigationBarItem(icon: Icon(Icons.my_library_books), label: ''),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
    ],
    selectedItemColor: getMainColor(),
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
  );
}