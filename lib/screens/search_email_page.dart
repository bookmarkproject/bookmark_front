import 'package:bookmarkfront/widgets/app_bars.dart';
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
      appBar: CustomAppBar(text: "이메일 찾기"),
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