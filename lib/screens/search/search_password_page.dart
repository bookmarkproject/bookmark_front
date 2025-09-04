import 'package:bookmarkfront/api/mail_api.dart';
import 'package:bookmarkfront/models/email_response.dart';
import 'package:bookmarkfront/provider/auth_provider.dart';
import 'package:bookmarkfront/utils/global_util.dart';
import 'package:bookmarkfront/widgets/app_bars.dart';
import 'package:bookmarkfront/widgets/custom_filled_button.dart';
import 'package:bookmarkfront/widgets/custom_snackbar.dart';
import 'package:bookmarkfront/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPasswordPage extends StatefulWidget {
  const SearchPasswordPage({super.key});

  @override
  State<SearchPasswordPage> createState() => _SearchPasswordPageState();
}

class _SearchPasswordPageState extends State<SearchPasswordPage> {
  
  final nameCountroller = TextEditingController();
  final emailCountroller = TextEditingController();
  final authNumCountroller = TextEditingController();

  bool isEmailVerified = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "비밀번호 찾기"),
      body: SafeArea(
        child: Padding(
          padding: getMainPadding(),
          child: SingleChildScrollView(
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
                  width: 360,
                ),
                const SizedBox(
                  height: 30,
                ),
                _getTitle("이메일을 입력하세요", 18.0),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: "이메일", 
                        obscureText: false, 
                        controller: emailCountroller, 
                        enabled: isEmailVerified,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    CustomFilledButton(
                      callback: () async{
                        await sendMail(context, emailCountroller.text);
                      }, 
                      text: "인증 요청", 
                      fontsize: 16.0,
                      width: 100,
                    ),
                  ],
                ),
                 const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: "인증번호", 
                        obscureText: false, 
                        controller: authNumCountroller,
                        enabled: isEmailVerified,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    CustomFilledButton(
                      callback: () async{
                        EmailResponse? response = await authNumCheck(context, emailCountroller.text, authNumCountroller.text,passwordChange: "passwordChange");
                        Provider.of<AuthProvider>(context,listen: false).saveChangePasswordToken(response!.passwordChangeToken!);
                        setState(() {
                          isEmailVerified = response.isVerified;
                        });
                      }, 
                      text: "인증", 
                      fontsize: 16.0,
                      width: 70,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomFilledButton(
                  callback: ()async{
                    if (isEmptyField(context, nameCountroller, "이름")) return;
                    else if (!isEmailVerified) {
                      showSnack(context, "이메일 인증을 진행해주세요.",isError: true);
                      return;
                    }
                    
                    final authProvider = context.read<AuthProvider>();
                    await authProvider.loadChangePasswordToken();
                    showSnack(context, "새 비밀번호를 입력해주세요.");
                    Navigator.pushReplacementNamed(context, '/search/password/result',arguments: authProvider.chagePasswordToken);
                  }, 
                  text: "비밀번호 찾기", 
                  fontsize: 17.0,
                  width: 361,
                ),
              ],
            ),
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