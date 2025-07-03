import 'package:bookmarkfront/widgets/app_bars.dart';
import 'package:bookmarkfront/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';

class SearchEmailResultPage extends StatefulWidget {
  const SearchEmailResultPage({super.key});

  @override
  State<SearchEmailResultPage> createState() => _SearchEmailResultPageState();
}

class _SearchEmailResultPageState extends State<SearchEmailResultPage> {
  
  final String searchedEmail = "joyuri123@gmail.com";
  String maskedEmail = "";
  
  @override
  void initState() {
    super.initState();
    maskedEmail = _maskEmail(searchedEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "이메일 찾기"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 20.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getTitle("발견된 이메일", 18.0),
              const SizedBox(
                height: 20,
              ),
              Text(
                "안녕하세요, 회원님의 이메일은\n$maskedEmail 입니다.",
                style: TextStyle(
                  fontSize: 17.0,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              CustomFilledButton(
                callback: (){
                  Navigator.pushNamed(context, '/');
                }, 
                text: "로그인 화면으로", 
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

  String _maskEmail(String email) {
    int atIdx = email.indexOf('@');
    String maskedEmail = "${email.substring(0,2)}****${email.substring(atIdx)}";
    return maskedEmail;
  }
  }

  