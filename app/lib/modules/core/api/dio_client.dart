import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DioClient {
  late final Dio _dio;

  Dio get dio => _dio;

  DioClient() {
    final options = BaseOptions(
      baseUrl: 'http://localhost:8080/v1',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    _dio = Dio(options);

    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );
  }
}
