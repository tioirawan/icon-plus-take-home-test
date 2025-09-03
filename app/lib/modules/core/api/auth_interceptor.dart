import 'package:dio/dio.dart';
import 'package:icon_plus_app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:icon_plus_app/modules/auth/domain/repositories/token_repository.dart';
import 'package:icon_plus_app/modules/auth/presentation/blocs/auth_bloc/auth_bloc.dart';

class AuthInterceptor extends QueuedInterceptor {
  final TokenRepository _tokenRepository;
  final AuthRepository _authRepository;
  final AuthBloc _authBloc;
  final Dio _dio;

  AuthInterceptor(
    this._tokenRepository,
    this._authRepository,
    this._authBloc,
    this._dio,
  );

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenRepository.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // We only want to handle 401 Unauthorized errors
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    final oldRefreshToken = await _tokenRepository.getRefreshToken();
    if (oldRefreshToken == null) {
      return handler.next(err); // No refresh token, proceed with original error
    }

    try {
      // The queue is now locked automatically by QueuedInterceptor
      // until this handler is resolved or rejected.

      // Perform the token refresh
      final newTokens = await _authRepository.refresh(
        refreshToken: oldRefreshToken,
      );

      // Save the new tokens
      await _tokenRepository.saveTokens(
        accessToken: newTokens.accessToken,
        refreshToken: newTokens.refreshToken,
      );

      // Retry the original request with the new token
      final options = err.requestOptions;
      options.headers['Authorization'] = 'Bearer ${newTokens.accessToken}';

      final response = await _dio.fetch(options);

      // Resolve the handler with the new response, unlocking the queue
      return handler.resolve(response);
    } catch (e) {
      // If refresh fails, log the user out and reject the request.
      await _tokenRepository.clearTokens();
      _authBloc.add(AuthLogoutRequested());

      // Reject the handler with the original error, unlocking the queue
      return handler.next(err);
    }
  }
}
