import 'package:dio/dio.dart';
import 'package:icon_plus_app/modules/auth/data/models/login_request_dto.dart';
import 'package:icon_plus_app/modules/auth/data/models/login_response_dto.dart';
import 'package:icon_plus_app/modules/auth/data/models/refresh_token_dto.dart';
import 'package:icon_plus_app/modules/core/api/api_exceptions.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseDto> login(LoginRequestDto request);
  Future<RefreshTokenResponseDto> refresh(RefreshTokenRequestDto request);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl(@Named('baseDio') this._dio);

  @override
  Future<LoginResponseDto> login(LoginRequestDto request) async {
    try {
      final response = await _dio.post('/auth/login', data: request.toJson());
      return LoginResponseDto.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw ApiException(
          "Oops! Email or password seems off. Please try again.",
          statusCode: 401,
        );
      }
      throw ApiException(
        "Something went wrong. Please check your connection.",
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<RefreshTokenResponseDto> refresh(
    RefreshTokenRequestDto request,
  ) async {
    try {
      final response = await _dio.post('/auth/refresh', data: request.toJson());
      return RefreshTokenResponseDto.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException(
        "Your session has expired. Please log in again.",
        statusCode: e.response?.statusCode,
      );
    }
  }
}
