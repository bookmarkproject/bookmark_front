import 'package:flutter/material.dart';

class SearchPasswordPage extends StatefulWidget {
  const SearchPasswordPage({super.key});

  @override
  State<SearchPasswordPage> createState() => _SearchPasswordPageState();
}

class _SearchPasswordPageState extends State<SearchPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("비밀번호 찾기 페이지 입니다.")
          ],
        ),
      ),
    );
  }
}