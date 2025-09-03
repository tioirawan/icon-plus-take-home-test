import 'package:icon_plus_app/modules/auth/data/datasources/auth_remote_data_source.dart';
import 'package:icon_plus_app/modules/auth/data/models/login_request_dto.dart';
import 'package:icon_plus_app/modules/auth/data/models/refresh_token_dto.dart';
import 'package:icon_plus_app/modules/auth/domain/entities/login_result.dart';
import 'package:icon_plus_app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<LoginResult> login({
    required String email,
    required String password,
  }) async {
    final requestDto = LoginRequestDto(email: email, password: password);
    final responseDto = await _remoteDataSource.login(requestDto);
    return responseDto.toDomain();
  }

  @override
  Future<RefreshTokenResponseDto> refresh({
    required String refreshToken,
  }) async {
    final requestDto = RefreshTokenRequestDto(refreshToken: refreshToken);
    return _remoteDataSource.refresh(requestDto);
  }
}
