import 'package:dio/dio.dart';
import 'package:icon_plus_app/modules/auth/data/models/login_request_dto.dart';
import 'package:icon_plus_app/modules/auth/data/models/login_response_dto.dart';
import 'package:icon_plus_app/modules/core/api/api_exceptions.dart';
import 'package:icon_plus_app/modules/core/api/dio_client.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseDto> login(LoginRequestDto request);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _dioClient;

  AuthRemoteDataSourceImpl(this._dioClient);

  @override
  Future<LoginResponseDto> login(LoginRequestDto request) async {
    try {
      final response = await _dioClient.dio.post(
        '/auth/login',
        data: request.toJson(),
      );
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
}
