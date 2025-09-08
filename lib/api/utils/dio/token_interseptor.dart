import 'package:bookmarkfront/api/utils/api_basic_util.dart';
import 'package:bookmarkfront/main.dart';
import 'package:bookmarkfront/provider/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TokenInterceptor extends Interceptor {
  final Dio dio;
  final AuthProvider authProvider;

  TokenInterceptor(this.dio,this.authProvider);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = authProvider.accessToken;
    options.headers["Authorization"] = "Bearer $accessToken";
  
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        await authProvider.clearToken();
        await refreshToken();

        if (authProvider.accessToken != null) {
          err.requestOptions.validateStatus = (status) {
            return true;
          };
          final retryResponse = await dio.fetch(err.requestOptions
            ..headers["Authorization"] = "Bearer ${authProvider.accessToken}");
          
          if (retryResponse.statusCode! >= 200 && retryResponse.statusCode! <= 299) {
            return handler.resolve(retryResponse);
          } else if (retryResponse.statusCode == 401) {
            navigatorKey.currentState?.pushNamedAndRemoveUntil('/login', (route) => false);
          } else {
            return handler.next(DioException(
              requestOptions: err.requestOptions,
              response: retryResponse,
            ));
          }
        }
      } catch (e) {
        print(e);
      }
    }
    return handler.next(err);
  }

  Future<void> refreshToken() async {
    try {
      final refreshToken = authProvider.refreshToken;

      final response = await Dio().post(
        "${getHost()}/auth/refresh/token",
        data: {"refreshToken": refreshToken},
      );

      if (response.statusCode == 200) {
         final data = response.data;
         await authProvider.saveToken(data['accessToken']);
         await authProvider.saveRefreshToken(data['refreshToken']);
      }
    } catch (e) {      
      final context = navigatorKey.currentState?.overlay?.context;
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("다시 로그인 해주세요.",style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.red,
          ),
        );
      }
      navigatorKey.currentState?.pushNamedAndRemoveUntil('/login', (route) => false);
    }
  }
}
