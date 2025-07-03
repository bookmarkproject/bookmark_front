import 'package:flutter/material.dart';

class SearchEmailPage extends StatefulWidget {
  const SearchEmailPage({super.key});

  @override
  State<SearchEmailPage> createState() => _SearchEmailPageState();
}

class _SearchEmailPageState extends State<SearchEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("이메일 찾기 페이지 입니다.")
          ],
        ),
      ),
    );
  }
}