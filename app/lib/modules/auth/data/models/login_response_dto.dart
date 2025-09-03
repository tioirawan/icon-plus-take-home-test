import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:icon_plus_app/modules/auth/data/models/user_dto.dart';
import 'package:icon_plus_app/modules/auth/domain/entities/login_result.dart';

part 'login_response_dto.freezed.dart';
part 'login_response_dto.g.dart';

@freezed
abstract class LoginResponseDto with _$LoginResponseDto {
  const LoginResponseDto._();

  const factory LoginResponseDto({
    required String accessToken,
    required String refreshToken,
    required UserDto user,
  }) = _LoginResponseDto;

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDtoFromJson(json);

  LoginResult toDomain() {
    return LoginResult(
      user: user.toDomain(),
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
