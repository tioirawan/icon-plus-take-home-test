import 'package:dio/dio.dart';
import 'package:icon_plus_app/modules/auth/data/models/user_dto.dart';
import 'package:icon_plus_app/modules/core/api/api_exceptions.dart';
import 'package:icon_plus_app/modules/core/api/dio_client.dart';
import 'package:injectable/injectable.dart';

abstract class ProfileRemoteDataSource {
  Future<UserDto> getProfile();
  Future<void> logout();
}

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final DioClient _dioClient;

  ProfileRemoteDataSourceImpl(this._dioClient);

  @override
  Future<UserDto> getProfile() async {
    try {
      final response = await _dioClient.dio.get('/me');
      return UserDto.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException(
        "Failed to fetch profile.",
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _dioClient.dio.post('/auth/logout');
    } on DioException {
      // ignore this, but ensure token is cleared somewhere
    }
  }
}
