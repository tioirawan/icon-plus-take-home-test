import 'package:dio/dio.dart';
import 'package:icon_plus_app/modules/auth/data/models/refresh_token_dto.dart';
import 'package:icon_plus_app/modules/auth/domain/repositories/token_repository.dart';
import 'package:icon_plus_app/modules/auth/presentation/blocs/auth_bloc/auth_bloc.dart';


class AuthInterceptor extends QueuedInterceptor {
  final TokenRepository _tokenRepository;
  final AuthBloc _authBloc;
  
  final Dio _retryDio;
  final Dio _refreshDio;

  AuthInterceptor(
    this._tokenRepository,
    this._authBloc,
    this._retryDio,
    this._refreshDio,
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
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    final oldRefreshToken = await _tokenRepository.getRefreshToken();
    if (oldRefreshToken == null) {
      return handler.next(err);
    }

    try {
      final requestDto = RefreshTokenRequestDto(refreshToken: oldRefreshToken);
      
      final response = await _refreshDio.post(
        '/auth/refresh',
        data: requestDto.toJson(),
      );
      final newTokens = RefreshTokenResponseDto.fromJson(response.data);

      await _tokenRepository.saveTokens(
        accessToken: newTokens.accessToken,
        refreshToken: newTokens.refreshToken,
      );

      final options = err.requestOptions;
      options.headers['Authorization'] = 'Bearer ${newTokens.accessToken}';
      
      final retryResponse = await _retryDio.fetch(options);
      return handler.resolve(retryResponse);

    } catch (e) {
      await _tokenRepository.clearTokens();
      _authBloc.add(AuthLogoutRequested());
      
      return handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: 'Silent logout on token refresh failure',
        ),
      );
    }
  }
}
