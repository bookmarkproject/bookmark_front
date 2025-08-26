import 'package:bookmarkfront/models/member.dart';
import 'package:flutter/material.dart';

class MemberProvider with ChangeNotifier {
  Member? _member;

  Member? get member => _member;

  void setMember(Member member) {
    _member = member;
    _member!.printMember();
    notifyListeners();
  }

  void clear() {
    _member = null;
    notifyListeners();
  }
}
