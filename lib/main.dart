import 'package:bookmarkfront/api/utils/dio/dio_client.dart';
import 'package:bookmarkfront/provider/auth_provider.dart';
import 'package:bookmarkfront/provider/book_record_provider.dart';
import 'package:bookmarkfront/provider/member_provider.dart';
import 'package:bookmarkfront/screens/auth/login_page.dart';
import 'package:bookmarkfront/screens/auth/signup_page.dart';
import 'package:bookmarkfront/screens/book/book_search_page.dart';
import 'package:bookmarkfront/screens/bookrecord/book_record_list_page.dart';
import 'package:bookmarkfront/screens/home/home.dart';
import 'package:bookmarkfront/screens/mypage/my_page.dart';
import 'package:bookmarkfront/screens/search/search_email_page.dart';
import 'package:bookmarkfront/screens/search/search_email_result_page.dart';
import 'package:bookmarkfront/screens/search/search_password_page.dart';
import 'package:bookmarkfront/screens/search/search_password_result_page.dart';
import 'package:bookmarkfront/screens/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MemberProvider()),
        ChangeNotifierProvider(create: (_) => BookRecordProvider()),
        ProxyProvider<AuthProvider, DioClient>(
          update: (_, authProvider, __) => DioClient(authProvider: authProvider),
        ),
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
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light, 
      initialRoute: '/',
      theme: ThemeData(
        fontFamily: 'NotoSansKR',
      ),
      builder: (context, child) {
      final mediaQueryData = MediaQuery.of(context);
      return MediaQuery(
        data: mediaQueryData.copyWith(textScaler: TextScaler.linear(1.0)),
        child: child!,
        );
      },
      routes: {
        '/': (context) => SplashPage(),
        '/login': (context) => LoginPage(),
        '/search/email': (context) => SearchEmailPage(), 
        '/search/email/result': (context) => SearchEmailResultPage(),
        '/search/password' : (context) => SearchPasswordPage(),
        '/search/password/result' : (context) => SearchPasswordResultPage(),
        '/signup' : (context) => SignupPage(),
        '/home' : (context) => Home(),
        
        '/book/search' : (context) => BookSearchPage(),
        '/book/record' : (context) => BookRecordListPage(),
      
        '/mypage' : (context) => MyPage(),
      } 
    );
  }
}