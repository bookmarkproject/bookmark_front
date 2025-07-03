import 'package:bookmarkfront/screens/login_page.dart';
import 'package:bookmarkfront/screens/search_email_page.dart';
import 'package:bookmarkfront/screens/search_email_result_page.dart';
import 'package:bookmarkfront/screens/search_password_page.dart';
import 'package:bookmarkfront/screens/search_password_result_page.dart';
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
      themeMode: ThemeMode.light, 
      initialRoute: '/',
      theme: ThemeData(
        fontFamily: 'NotoSansKR',
      ),
      routes: {
        '/': (context) => LoginPage(),
        '/search/email': (context) => SearchEmailPage(), 
        '/search/email/result': (context) => SearchEmailResultPage(),
        '/search/password' : (context) => SearchPasswordPage(),
        '/search/password/result' : (context) => SearchPasswordResultPage(),
        '/signup' : (context) => SignupPage(),
      } 
    );
  }
}