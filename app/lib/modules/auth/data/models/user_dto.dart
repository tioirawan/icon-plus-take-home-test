import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:icon_plus_app/modules/auth/domain/entities/user.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
abstract class UserDto with _$UserDto {
  const UserDto._();

  const factory UserDto({
    required String id,
    required String email,
    required String name,
    String? jobTitle,
    String? company,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  User toDomain() {
    return User(
      id: id,
      email: email,
      name: name,
      jobTitle: jobTitle,
      company: company,
    );
  }
}
