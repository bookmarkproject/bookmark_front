import 'package:bookmarkfront/provider/auth_provider.dart';
import 'package:bookmarkfront/provider/member_provider.dart';
import 'package:bookmarkfront/screens/home.dart';
import 'package:bookmarkfront/screens/login_page.dart';
import 'package:bookmarkfront/screens/search_email_page.dart';
import 'package:bookmarkfront/screens/search_email_result_page.dart';
import 'package:bookmarkfront/screens/search_password_page.dart';
import 'package:bookmarkfront/screens/search_password_result_page.dart';
import 'package:bookmarkfront/screens/signup_page.dart';
import 'package:bookmarkfront/screens/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MemberProvider()),
      ],
      child: MyApp(),
    ),
  );
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
        '/': (context) => SplashPage(),
        '/login': (context) => LoginPage(),
        '/search/email': (context) => SearchEmailPage(), 
        '/search/email/result': (context) => SearchEmailResultPage(),
        '/search/password' : (context) => SearchPasswordPage(),
        '/search/password/result' : (context) => SearchPasswordResultPage(),
        '/signup' : (context) => SignupPage(),
        '/home' : (context) => Home(),
      } 
    );
  }
}