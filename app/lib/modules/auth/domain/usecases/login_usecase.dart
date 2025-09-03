import 'package:equatable/equatable.dart';
import 'package:icon_plus_app/modules/auth/domain/entities/login_result.dart';
import 'package:icon_plus_app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<LoginResult> call(LoginParams params) {
    return _repository.login(email: params.email, password: params.password);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
