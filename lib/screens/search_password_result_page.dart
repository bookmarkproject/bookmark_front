import 'package:bookmarkfront/widgets/app_bars.dart';
import 'package:bookmarkfront/widgets/custom_filled_button.dart';
import 'package:bookmarkfront/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class SearchPasswordResultPage extends StatelessWidget {
  SearchPasswordResultPage({super.key});

  final passwordCountroller = TextEditingController();
  final passwordCheckCountroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "비밀번호 찾기"),
      body : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 20.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getTitle("새 비밀번호 입력", 18.0),
              const SizedBox(
                height: 30,
              ),
              CustomTextField(
                hintText: "새 비밀번호", 
                obscureText: true, 
                controller: passwordCountroller,
                width: 361,
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                hintText: "새 비밀번호 확인", 
                obscureText: true, 
                controller: passwordCheckCountroller,
                width: 361,
              ),
              const SizedBox(
                height: 40,
              ),
              CustomFilledButton(
                callback: (){
                  Navigator.pushNamed(context, '/');
                }, 
                text: "비밀번호 변경", 
                fontsize: 17.0,
                width: 361,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text _getTitle(text,fontsize) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontsize,
        fontWeight: FontWeight.bold,
      ),
    );
  }

}