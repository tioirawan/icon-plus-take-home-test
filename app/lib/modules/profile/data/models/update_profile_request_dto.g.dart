// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateProfileRequestDto _$UpdateProfileRequestDtoFromJson(
  Map<String, dynamic> json,
) => _UpdateProfileRequestDto(
  name: json['name'] as String?,
  jobTitle: json['jobTitle'] as String?,
  company: json['company'] as String?,
);

Map<String, dynamic> _$UpdateProfileRequestDtoToJson(
  _UpdateProfileRequestDto instance,
) => <String, dynamic>{
  'name': instance.name,
  'jobTitle': instance.jobTitle,
  'company': instance.company,
};
