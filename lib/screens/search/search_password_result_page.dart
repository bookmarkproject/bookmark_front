import 'package:bookmarkfront/api/auth_api.dart';
import 'package:bookmarkfront/provider/auth_provider.dart';
import 'package:bookmarkfront/utils/global_util.dart';
import 'package:bookmarkfront/widgets/app_bars.dart';
import 'package:bookmarkfront/widgets/custom_filled_button.dart';
import 'package:bookmarkfront/widgets/custom_snackbar.dart';
import 'package:bookmarkfront/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPasswordResultPage extends StatelessWidget {
  SearchPasswordResultPage({super.key});

  final passwordCountroller = TextEditingController();
  final passwordCheckCountroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final changePasswordToken = ModalRoute.of(context)!.settings.arguments as String;
   
    return Scaffold(
      appBar: CustomAppBar(text: "비밀번호 찾기"),
      body : SafeArea(
        child: Padding(
          padding: getMainPadding(),
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
                height: 3,
              ),
              const Text(
                '비밀번호는 영어, 숫자, 특수문자(!@#\$%^&*())를 1개 이상 포함하여\n 8~16자로 입력 해야합니다.',
                style: TextStyle(
                  fontSize: 10,
                ),
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
                callback: ()async {
                  if (isEmptyField(context, passwordCountroller, "비밀번호")) return;
                  else if (passwordCountroller.text != passwordCheckCountroller.text) {
                    showSnack(context, "비밀번호와 비밀번호 확인이 다릅니다.",isError: true);
                    return;
                  }
                  
                  final request = {
                    "password" : passwordCountroller.text,
                    "token" : "Bearer $changePasswordToken"
                  };
                  
                  bool isChanged = await changePassword(context, request);
                  if(isChanged) {
                    Provider.of<AuthProvider>(context,listen: false).clearChangePasswordToken();
                    Navigator.pushNamed(context, '/login');
                  }
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