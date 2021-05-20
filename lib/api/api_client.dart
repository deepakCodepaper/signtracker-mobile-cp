import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class ApiClient {
  ApiClient({String basePath, this.token}) {
    dio.options.baseUrl = basePath;
    dio.interceptors
      ..add(InterceptorsWrapper(
        onRequest: (options) {
          var opt = options
            ..headers[Headers.acceptHeader] = 'application/json'
            ..headers[Headers.contentTypeHeader] = 'application/json';
          if (token != null) {
            opt = opt..headers['Authorization'] = 'Bearer $token';
          }
          return opt;
        },
        onError: (error) => error,
      ))
      ..add(LogInterceptor(
        responseHeader: true,
        requestBody: true,
        responseBody: true,
      ))
      ..add((DioCacheManager(CacheConfig(baseUrl: basePath)).interceptor));
  }

  final String token;

  final dio = Dio();
}
