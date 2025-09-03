import 'package:dio/dio.dart';
import 'package:icon_plus_app/modules/auth/data/models/user_dto.dart';
import 'package:icon_plus_app/modules/core/api/api_exceptions.dart';
import 'package:icon_plus_app/modules/profile/data/models/change_password_request_dto.dart';
import 'package:icon_plus_app/modules/profile/data/models/update_profile_request_dto.dart';
import 'package:injectable/injectable.dart';

abstract class ProfileRemoteDataSource {
  Future<UserDto> getProfile();
  Future<UserDto> updateProfile(UpdateProfileRequestDto request);
  Future<void> changePassword(ChangePasswordRequestDto request);
  Future<void> logout();
}

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio _dio;

  ProfileRemoteDataSourceImpl(this._dio);

  @override
  Future<UserDto> getProfile() async {
    try {
      final response = await _dio.get('/me');
      return UserDto.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException(
        "Failed to fetch profile.",
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<UserDto> updateProfile(UpdateProfileRequestDto request) async {
    try {
      final response = await _dio.put('/me', data: request.toJson());
      return UserDto.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException(
        e.response?.data['message'] ?? "Failed to update profile.",
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<void> changePassword(ChangePasswordRequestDto request) async {
    try {
      await _dio.post('/me/change-password', data: request.toJson());
    } on DioException catch (e) {
      throw ApiException(
        e.response?.data['message'] ?? "Failed to change password.",
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _dio.post('/auth/logout');
    } on DioException {
      // We can ignore errors here.
    }
  }
}
