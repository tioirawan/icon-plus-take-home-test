// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RefreshTokenRequestDto _$RefreshTokenRequestDtoFromJson(
  Map<String, dynamic> json,
) => _RefreshTokenRequestDto(refreshToken: json['refreshToken'] as String);

Map<String, dynamic> _$RefreshTokenRequestDtoToJson(
  _RefreshTokenRequestDto instance,
) => <String, dynamic>{'refreshToken': instance.refreshToken};

_RefreshTokenResponseDto _$RefreshTokenResponseDtoFromJson(
  Map<String, dynamic> json,
) => _RefreshTokenResponseDto(
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
);

Map<String, dynamic> _$RefreshTokenResponseDtoToJson(
  _RefreshTokenResponseDto instance,
) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
};
