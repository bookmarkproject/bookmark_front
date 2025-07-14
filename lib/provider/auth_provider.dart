import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider with ChangeNotifier {
  String? _accessToken;
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  String? get accessToken => _accessToken;

  Future<void> loadToken() async {
    _accessToken = await _storage.read(key: 'accessToken');
    notifyListeners();
  }

  Future<void> saveToken(String token) async {
    _accessToken = token;
    await _storage.write(key: 'accessToken', value: token);
    notifyListeners();
  }

  Future<void> clearToken() async {
    _accessToken = null;
    await _storage.delete(key: 'accessToken');
    notifyListeners();
  }
}