import 'package:equatable/equatable.dart';
import 'package:icon_plus_app/modules/auth/domain/entities/user.dart';

class LoginResult extends Equatable {
  final User user;
  final String accessToken;
  final String refreshToken;

  const LoginResult({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [user, accessToken, refreshToken];
}
