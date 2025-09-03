import 'package:icon_plus_app/modules/auth/domain/entities/user.dart';
import 'package:icon_plus_app/modules/profile/data/datasources/profile_remote_data_source.dart';
import 'package:icon_plus_app/modules/profile/data/models/change_password_request_dto.dart';
import 'package:icon_plus_app/modules/profile/data/models/update_profile_request_dto.dart';
import 'package:icon_plus_app/modules/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<User> getProfile() async {
    final userDto = await _remoteDataSource.getProfile();
    return userDto.toDomain();
  }

  @override
  Future<User> updateProfile({
    String? name,
    String? jobTitle,
    String? company,
  }) async {
    final requestDto = UpdateProfileRequestDto(
      name: name,
      jobTitle: jobTitle,
      company: company,
    );
    final userDto = await _remoteDataSource.updateProfile(requestDto);
    return userDto.toDomain();
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    final requestDto = ChangePasswordRequestDto(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    return _remoteDataSource.changePassword(requestDto);
  }

  @override
  Future<void> logout() async {
    await _remoteDataSource.logout();
  }
}
