import 'package:bookmarkfront/api/auth_api.dart';
import 'package:bookmarkfront/api/member_api.dart';
import 'package:bookmarkfront/provider/auth_provider.dart';
import 'package:bookmarkfront/utils/global_util.dart';
import 'package:bookmarkfront/widgets/login_buttons.dart';
import 'package:bookmarkfront/widgets/login_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 55,
                  width: 55,
                  child: SvgPicture.asset(
                    "svg/logo.svg",
                    color: getMainColor(),
                  ),
                ),
                const Text(
                  "책갈피",
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 20*0.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "지금 바로\n나의 독서를 기록하세요!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 28 * (-0.05)
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                LoginTextfield(
                  hintText: "이메일", 
                  obscureText: false, 
                  controller: emailController,
                  type: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 15,
                ),
                LoginTextfield(
                  hintText: "비밀번호", 
                  obscureText: true, 
                  controller: passwordController
                ),
                const SizedBox(
                  height: 30,
                ),
                LoginButtons(
                  callback: () async{
                    final request = {
                      "email" : emailController.text,
                      "password" : passwordController.text
                    };
                    await login(context,request);
                  }, 
                  backgroundColor: getMainColor(), 
                  text: "로그인", 
                  textColor: Colors.white, 
                  borderSide: BorderSide.none
                ),
                SizedBox(
                  height: 12,
                ),
               LoginButtons(
                  callback: (){
                    Navigator.pushNamed(context, '/search/email');
                  }, 
                  backgroundColor: Color.fromRGBO(0, 0, 0, 0.04), 
                  text: "이메일을 잊으셨나요?", 
                  textColor: Colors.black, 
                  borderSide: BorderSide.none
                ),
                SizedBox(
                  height: 12,
                ),
                LoginButtons(
                  callback: (){
                    Navigator.pushNamed(context, '/search/password');
                  }, 
                  backgroundColor: Color.fromRGBO(245, 245, 245, 0.5), 
                  text: "비밀번호를 잊으셨나요?", 
                  textColor: Colors.black, 
                  borderSide: BorderSide.none
                ),
                SizedBox(
                  height: 12,
                ),
                 LoginButtons(
                  callback: (){
                    Navigator.pushNamed(context, '/signup');
                  }, 
                  backgroundColor: Colors.white, 
                  text: "회원가입", 
                  textColor: Colors.black, 
                  borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.2), width: 0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

