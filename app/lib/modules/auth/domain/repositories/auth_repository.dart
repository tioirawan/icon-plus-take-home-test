import 'package:icon_plus_app/modules/auth/data/models/refresh_token_dto.dart';
import 'package:icon_plus_app/modules/auth/domain/entities/login_result.dart';

abstract class AuthRepository {
  Future<LoginResult> login({required String email, required String password});

  Future<RefreshTokenResponseDto> refresh({required String refreshToken});
}
