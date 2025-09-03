import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:icon_plus_app/modules/auth/domain/repositories/token_repository.dart';
import 'package:icon_plus_app/modules/core/api/auth_interceptor.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DioClient {
  late final Dio _dio;
  final TokenRepository _tokenRepository;

  Dio get dio => _dio;

  DioClient(this._tokenRepository) {
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

    _dio.interceptors.addAll([
      AuthInterceptor(_tokenRepository),
      if (kDebugMode) LogInterceptor(requestBody: true, responseBody: true),
    ]);
  }
}
