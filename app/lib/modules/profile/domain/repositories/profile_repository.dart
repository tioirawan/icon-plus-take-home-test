import 'package:icon_plus_app/modules/auth/domain/entities/user.dart';

abstract class ProfileRepository {
  Future<User> getProfile();
  Future<void> logout();
}
