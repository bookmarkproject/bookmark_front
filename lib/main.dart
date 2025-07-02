import 'package:bookmarkfront/screens/login_page.dart';
import 'package:bookmarkfront/screens/search_email_page.dart';
import 'package:bookmarkfront/screens/search_password_page.dart';
import 'package:bookmarkfront/screens/signup_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp
({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light, // 항상 밝은 테마 사용
      initialRoute: '/',
      theme: ThemeData(
        fontFamily: 'NotoSansKR',
      ),
      routes: {
        '/': (context) => LoginPage(),
        '/search/email': (context) => SearchEmailPage(), 
        '/search/password' : (context) => SearchPasswordPage(),
        '/signup' : (context) => SignupPage(),
      } 
    );
  }
}