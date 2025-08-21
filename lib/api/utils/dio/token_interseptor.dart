import 'dart:convert';

import 'package:bookmarkfront/api/utils/api_basic_util.dart';
import 'package:bookmarkfront/provider/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            print("응답 코드 401에 의한 로그아웃");
            // 로그아웃 로직
          } else {
            return handler.next(DioException(
              requestOptions: err.requestOptions,
              response: retryResponse,
            ));
          }
        }
      } catch (e, stack) {
        print("❌ catch 발생: $e");
        print(stack);
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
         print("엑세스 토큰 업데이트 : ${data['accessToken']}");
         await authProvider.saveRefreshToken(data['refreshToken']);
         print("리프레쉬 토큰 업데이트 : ${data['refreshToken']}");
      }
    } catch (e) {
      print("리프레쉬 토큰 실패: $e");
    }
  }
}
