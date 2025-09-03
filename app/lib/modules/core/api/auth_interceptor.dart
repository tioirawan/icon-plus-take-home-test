import 'package:dio/dio.dart';
import 'package:icon_plus_app/modules/auth/domain/repositories/token_repository.dart';

class AuthInterceptor extends Interceptor {
  final TokenRepository _tokenRepository;

  AuthInterceptor(this._tokenRepository);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.path.contains('/auth/')) {
      return handler.next(options);
    }

    final token = await _tokenRepository.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }
}
