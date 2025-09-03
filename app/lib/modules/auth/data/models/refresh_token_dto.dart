import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_token_dto.freezed.dart';
part 'refresh_token_dto.g.dart';

@freezed
abstract class RefreshTokenRequestDto with _$RefreshTokenRequestDto {
  const factory RefreshTokenRequestDto({required String refreshToken}) =
      _RefreshTokenRequestDto;

  factory RefreshTokenRequestDto.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestDtoFromJson(json);
}

@freezed
abstract class RefreshTokenResponseDto with _$RefreshTokenResponseDto {
  const factory RefreshTokenResponseDto({
    required String accessToken,
    required String refreshToken,
  }) = _RefreshTokenResponseDto;

  factory RefreshTokenResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenResponseDtoFromJson(json);
}
