import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:icon_plus_app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:icon_plus_app/modules/auth/domain/repositories/token_repository.dart';
import 'package:icon_plus_app/modules/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:icon_plus_app/modules/core/api/auth_interceptor.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @Named('baseDio')
  @lazySingleton
  Dio get baseDio {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://localhost:8080/v1',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    return dio;
  }

  @lazySingleton
  Dio dio(
    @Named('baseDio') Dio baseDio,
    TokenRepository tokenRepository,
    AuthRepository authRepository,
    AuthBloc authBloc,
  ) {
    final dio = baseDio;

    dio.interceptors.add(
      AuthInterceptor(tokenRepository, authRepository, authBloc, dio),
    );

    return dio;
  }
}
