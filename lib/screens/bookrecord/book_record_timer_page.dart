import 'dart:async';

import 'package:bookmarkfront/models/book_record.dart';
import 'package:bookmarkfront/screens/bookrecord/book_record_write_page.dart';
import 'package:bookmarkfront/utils/global_util.dart';
import 'package:bookmarkfront/widgets/app_bars.dart';
import 'package:bookmarkfront/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';

class BookRecordTimerPage extends StatefulWidget {
  const BookRecordTimerPage({super.key,required this.bookRecord});
  final BookRecord bookRecord; 

  @override
  State<BookRecordTimerPage> createState() => _BookRecordTimerPageState();
}

class _BookRecordTimerPageState extends State<BookRecordTimerPage> {
  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;
  bool _isStart = false;

  void _startTimer() {
    if (_isRunning) return;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });

    setState(() {
      _isRunning = true;
      _isStart = true;
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  String _formatTime(int seconds) {
    final int hours = seconds ~/ 3600;
    final int minutes = seconds ~/ 60;
    final int secs = seconds % 60;
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

  String _getFirstText() {
    if(!_isStart) {
      return "독서 시작하기";
    } else if (_isRunning) {
      return "독서 잠시 쉬기";
    } else {
      return "독서 이어하기";
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // 해제 안 하면 화면 넘어가도 계속 실행됨
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backButton: false,
        text: "독서 하기",
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: getMainPadding(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _formatTime(_seconds),
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                CustomFilledButton(
                  callback: _isRunning ? _stopTimer : _startTimer, 
                  text: _getFirstText(),
                  fontsize: 13.0, 
                  width: 360,
                ),
                SizedBox(
                  height: 10,
                ),
                _isStart ?
                  CustomFilledButton(
                    callback: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookRecordWritePage(bookRecord: widget.bookRecord, seconds: _seconds),
                        )
                      );
                    },
                    text: "독서 그만 하기",
                    fontsize: 13.0, 
                    width: 360,
                  )
                  : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
