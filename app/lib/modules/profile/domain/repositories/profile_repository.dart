import 'package:icon_plus_app/modules/auth/domain/entities/user.dart';

abstract class ProfileRepository {
  Future<User> getProfile();
  Future<User> updateProfile({String? name, String? jobTitle, String? company});
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });
  Future<void> logout();
}
