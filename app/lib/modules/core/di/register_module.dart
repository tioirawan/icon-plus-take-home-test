import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
    return Dio(
      BaseOptions(
        baseUrl: 'https://tht-iconplus.rakit.digital/v1',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }

  @lazySingleton
  Dio dio(
    @Named('baseDio') Dio baseDio,
    TokenRepository tokenRepository,
    AuthBloc authBloc,
  ) {
    final dio = Dio(baseDio.options);
    dio.interceptors.addAll([
      AuthInterceptor(tokenRepository, authBloc, dio, baseDio),
      LogInterceptor(requestBody: true, responseBody: true),
    ]);
    return dio;
  }
}
