import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_profile_request_dto.freezed.dart';
part 'update_profile_request_dto.g.dart';

@freezed
abstract class UpdateProfileRequestDto with _$UpdateProfileRequestDto {
  const factory UpdateProfileRequestDto({
    String? name,
    String? jobTitle,
    String? company,
  }) = _UpdateProfileRequestDto;

  factory UpdateProfileRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestDtoFromJson(json);
}
