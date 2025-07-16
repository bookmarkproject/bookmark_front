import 'package:bookmarkfront/api/member_api.dart';
import 'package:bookmarkfront/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  
  @override
  void initState() {
    super.initState();
    _initAuth();
  }

  Future<void> _initAuth() async {
    final authProvider = context.read<AuthProvider>();
    await authProvider.loadToken();
    await authProvider.loadRefreshToken();
    
    if (authProvider.accessToken != null) {
      bool isValid = await getMemberInfo(context);
      print(isValid);
      if(isValid) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Provider.of<AuthProvider>(context,listen: false).clearToken();
        Navigator.pushReplacementNamed(context, '/login');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}