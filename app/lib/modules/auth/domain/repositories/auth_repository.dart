import 'package:icon_plus_app/modules/auth/domain/entities/login_result.dart';

abstract class AuthRepository {
  Future<LoginResult> login({required String email, required String password});
}
