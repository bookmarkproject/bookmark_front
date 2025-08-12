import 'package:bookmarkfront/utils/global_util.dart';
import 'package:flutter/material.dart';

BottomNavigationBar getBottomBar(context,currentIndex) {
  return BottomNavigationBar(
    currentIndex: currentIndex,
    onTap: (index) {
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/home');
      }
      if (index == 1) { 
        Navigator.pushNamed(context, '/book/search');
      }
      if (index == 2) { 
        Navigator.pushReplacementNamed(context, '/home');
      }
       if (index == 3) { 
        Navigator.pushReplacementNamed(context, '/home');
      }
    },
    items: const [ 
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