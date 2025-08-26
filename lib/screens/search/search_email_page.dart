import 'package:bookmarkfront/api/auth_api.dart';
import 'package:bookmarkfront/utils/global_util.dart';
import 'package:bookmarkfront/widgets/app_bars.dart';
import 'package:bookmarkfront/widgets/custom_filled_button.dart';
import 'package:bookmarkfront/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class SearchEmailPage extends StatefulWidget {
  const SearchEmailPage({super.key});

  @override
  State<SearchEmailPage> createState() => _SearchEmailPageState();
}

class _SearchEmailPageState extends State<SearchEmailPage> {
  
  final nameCountroller = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "이메일 찾기"),
      body: Padding(
        padding: getMainPadding(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getTitle("이름을 입력하세요", 18.0),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                hintText: "이름", 
                obscureText: false, 
                controller: nameCountroller, 
                width: 361,
              ),
              const SizedBox(
                height: 25,
              ),
              _getTitle("휴대폰 번호를 입력하세요", 18.0),
              const SizedBox(
                height: 15.0,
              ),
              CustomTextField(
                hintText: "010xxxxxxxx",
                obscureText: false,
                controller: phoneNumberController,
                type: TextInputType.phone,
                maxLen: 11,
                width: 361,
              ),
              const SizedBox(
                height: 50,
              ),
              CustomFilledButton(
                callback: ()async {
                  if(isEmptyField(context, nameCountroller, "이름")) return;
                  if(isEmptyField(context, phoneNumberController, "휴대폰 번호")) return;

                  final request = {
                    "name" : nameCountroller.text,
                    "phoneNumber" : phoneNumberController.text
                  };

                  final email = await findEmail(context, request);
                  if(email!=null) {
                    Navigator.pushReplacementNamed(context, '/search/email/result',arguments: email);
                  } 
                }, 
                text: "이메일 찾기", 
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