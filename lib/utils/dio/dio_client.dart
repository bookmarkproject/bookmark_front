import 'package:bookmarkfront/api/utils/api_basic_util.dart';
import 'package:bookmarkfront/provider/auth_provider.dart';
import 'package:bookmarkfront/utils/dio/token_interseptor.dart';
import 'package:dio/dio.dart';

class DioClient {
  final Dio dio = Dio();

  DioClient({required AuthProvider authProvider}) {
    dio.options.baseUrl = getHost();
    dio.interceptors.add(TokenInterceptor(dio, authProvider));
  }
}