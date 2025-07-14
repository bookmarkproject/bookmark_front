import 'package:bookmarkfront/provider/auth_provider.dart';
import 'package:bookmarkfront/provider/member_provider.dart';
import 'package:bookmarkfront/widgets/app_bars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final member = Provider.of<MemberProvider>(context).member;
    return Scaffold(
      appBar: CustomAppBar(text: "Main Home"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 20.0),
          child: SafeArea(
            child: Column(
              children: [
                Text("${member!.nickname}님 환영합니다.")
              ],
            ),
          ),
        ),
      )
    );
  }
}