import 'package:bookmarkfront/api/auth_api.dart';
import 'package:bookmarkfront/api/mail_api.dart';
import 'package:bookmarkfront/models/email_response.dart';
import 'package:bookmarkfront/utils/global_util.dart';
import 'package:bookmarkfront/widgets/app_bars.dart';
import 'package:bookmarkfront/widgets/custom_dropdown.dart';
import 'package:bookmarkfront/widgets/custom_filled_button.dart';
import 'package:bookmarkfront/widgets/custom_snackbar.dart';
import 'package:bookmarkfront/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  
  final nameCountroller = TextEditingController();
  final emailCountroller = TextEditingController();
  final authNumCountroller = TextEditingController();
  final passwordCountroller = TextEditingController();
  final passwordCheckCountroller = TextEditingController();
  final phoneNumberController = TextEditingController();
  final nicknameController = TextEditingController();
  
  String? genderSelected = '남자';
  final List<String> genderItems = ['남자','여자'];

  int? yearSelected = DateTime.now().year;
  int? monthSelected = 1;
  int? daySelected = 1;

  final List<int> yearItems = List.generate(100, (index) => DateTime.now().year - index);
  final List<int> monthItems = List.generate(12, (index) => index + 1);
  List<int> dayItems = [];

  bool isEmailVerified = false;
  bool isNicknameDuplicated = true;
  bool isPiChecked = false;
  
  @override
  void initState() {
    super.initState();
    _updateDays();
    nicknameController.addListener(() {
    setState(() {
      isNicknameDuplicated = true;
    });
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "회원가입"),
      body: SingleChildScrollView(
        child: Padding(
          padding: getMainPadding(),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _getTitle("계정 만들기", 22.0),
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
                  height: 15,
                ),
                Row(
                  children: [
                    CustomTextField(
                      hintText: "이메일",
                      obscureText: false,
                      controller: emailCountroller,
                      enabled: isEmailVerified,
                      width: 240,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    CustomFilledButton(
                      callback: (){
                        sendMail(context,emailCountroller.text);
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
                    CustomTextField(
                      hintText: "이메일 인증 코드",
                      obscureText: false,
                      controller: authNumCountroller,
                      enabled: isEmailVerified,
                      width: 270,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    CustomFilledButton(
                      callback: () async {
                        EmailResponse? response =  await authNumCheck(context, emailCountroller.text, authNumCountroller.text);
                        setState(() {
                          if(response!=null) {
                            isEmailVerified = response.isVerified;
                          }
                        });
                      }, 
                      text: "인증", 
                      fontsize: 16.0,
                      width: 70,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  hintText: "비밀번호",
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
                  hintText: "비밀번호 확인",
                  obscureText: true,
                  controller: passwordCheckCountroller,
                  width: 361,
                ),
                const SizedBox(
                  height: 20,
                ),
                _getTitle("성별", 18.0),
                const SizedBox(
                  height: 15.0,
                ),
                CustomDropdown<String>(
                  width: 360,
                  selectedValue: genderSelected,
                  items: genderItems,
                  itemToString: (v)=>v,
                  onChanged: (val) {
                    setState(() {
                      genderSelected = val;
                    });
                  }
                ),
                const SizedBox(
                  height: 20,
                ),
                _getTitle("휴대폰 번호", 18.0),
                const SizedBox(
                  height: 15,
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
                  height: 20,
                ),
                _getTitle("생년월일", 18.0),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    CustomDropdown<int>(
                      width: 110,
                      selectedValue: yearSelected,
                      items: yearItems,
                      itemToString: (v)=>'$v년',
                      onChanged: (val) {
                        setState(() {
                          yearSelected = val!;
                          _updateDays();
                        });
                      }
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    CustomDropdown<int>(
                      width: 110,
                      selectedValue: monthSelected,
                      items: monthItems,
                      itemToString: (v)=>'$v월',
                      onChanged: (val) {
                        setState(() {
                          monthSelected = val!;
                          _updateDays();
                        });
                      }
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    CustomDropdown<int>(
                      width: 110,
                      selectedValue: daySelected,
                      items: dayItems,
                      itemToString: (v)=>'$v일',
                      onChanged: (val) {
                        setState(() {
                          daySelected = val!;
                        });
                      }
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                _getTitle("닉네임", 18.0),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    CustomTextField(
                      hintText: "닉네임을 입력하세요.",
                      obscureText: false,
                      controller: nicknameController,
                      width: 250,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    CustomFilledButton(
                      callback: () async{
                        bool isDuplicated = await isDuplicateNickname(context, nicknameController.text);
                        setState(() {
                          isNicknameDuplicated = isDuplicated;
                        });
                      }, 
                      text: "중복확인", 
                      fontsize: 14.0,
                      width: 90,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isPiChecked, 
                      onChanged: (bool? value){
                        setState(() {
                          isPiChecked = value!;
                        });
                      },
                    ),
                    Text(
                      "개인정보 수집에 동의합니다.",
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFilledButton(
                  callback: (){
                    if(!_isValidForSingup()) {
                      return;
                    }
                    final month = monthSelected.toString().padLeft(2, '0');
                    final day = daySelected.toString().padLeft(2,'0');
                    final request = {
                      "email" : emailCountroller.text,
                      "password" : passwordCountroller.text,
                      "name" : nameCountroller.text,
                      "nickname" : nicknameController.text,
                      "gender" : genderSelected,
                      "phoneNumber" : phoneNumberController.text,
                      "birthday" : "$yearSelected-$month-$day"
                    };
                    signup(context, request);
                  }, 
                  text: "회원 가입", 
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

  void _updateDays() {
    final daysInMonth = DateTime(yearSelected!, monthSelected! + 1, 0).day;
    dayItems = List.generate(daysInMonth, (index) => index + 1);

    // 현재 선택된 일이 유효하지 않으면 조정
    if (daySelected! > daysInMonth) {
      daySelected = daysInMonth;
    }
  }

  bool _isValidForSingup() {
    if(isEmptyField(context, nameCountroller, "이름")) return false;
    else if (!isEmailVerified) {
      showSnack(context,"이메일 인증을 진행해주세요.",isError: true);
      return false;
    } 
    else if (isEmptyField(context, passwordCheckCountroller, "비밀번호")) return false;
    else if (passwordCountroller.text != passwordCheckCountroller.text) {
      showSnack(context,"비밀번호와 비밀번호 확인이 같지 않습니다.",isError: true);
      return false;
    } 
    else if (isEmptyField(context, phoneNumberController, "휴대폰 번호")) return false;
    else if (isEmptyField(context,nicknameController, "닉네임")) return false;
    else if (isNicknameDuplicated){
      showSnack(context,"닉네임 중복체크를 진행해주세요.",isError: true);
      return false;
    } else if (!isPiChecked) {
      showSnack(context,"개인정보 수집에 동의해주세요.",isError: true);
      return false;
    }
    return true;
  }
}



