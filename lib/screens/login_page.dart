import 'package:bookmarkfront/utils/global_util.dart';
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
                FilledButton(
                  onPressed: (){},
                  style: FilledButton.styleFrom(
                    backgroundColor: getMainColor(),
                    fixedSize: Size(361,50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(56), 
                    ),
                  ),
                  child: const Text(
                    "로그인",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                FilledButton(
                  onPressed: (){},
                  style: FilledButton.styleFrom(
                    backgroundColor: Color.fromRGBO(0, 0, 0, 0.04),
                    fixedSize: Size(361,50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(56), 
                    ),
                  ),
                  child: const Text(
                    "이메일을 잊으셨나요?",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                FilledButton(
                  onPressed: (){},
                  style: FilledButton.styleFrom(
                    backgroundColor: Color.fromRGBO(245, 245, 245, 0.5),
                    fixedSize: Size(361,50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(56), 
                    ),
                  ),
                  child: const Text(
                    "비밀번호를 잊으셨나요?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                 FilledButton(
                  onPressed: (){},
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: Size(361,50),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.5,
                        color: Color.fromRGBO(0, 0, 0, 0.2)
                      ),
                      borderRadius: BorderRadius.circular(56), 
                    ),
                  ),
                  child: const Text(
                    "회원가입",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

