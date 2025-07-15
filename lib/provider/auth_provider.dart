import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider with ChangeNotifier {
  String? _accessToken;
  String? _changePasswordToken;

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  String? get accessToken => _accessToken;
  String? get chagePasswordToken => _changePasswordToken;

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

  Future<void> loadChangePasswordToken() async {
    _changePasswordToken = await _storage.read(key: 'changePasswordToken');
    notifyListeners();
  }

  Future<void> saveChangePasswordToken(String token) async {
    _changePasswordToken = token;
    await _storage.write(key: 'changePasswordToken', value: token);
    notifyListeners();
  }

  Future<void> clearChangePasswordToken() async {
    _changePasswordToken = null;
    await _storage.delete(key: 'changePasswordToken');
    notifyListeners();
  }
}