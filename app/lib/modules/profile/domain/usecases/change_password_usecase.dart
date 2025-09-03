import 'package:equatable/equatable.dart';
import 'package:icon_plus_app/modules/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordUseCase {
  final ProfileRepository _repository;

  ChangePasswordUseCase(this._repository);

  Future<void> call(ChangePasswordParams params) {
    return _repository.changePassword(
      currentPassword: params.currentPassword,
      newPassword: params.newPassword,
    );
  }
}

class ChangePasswordParams extends Equatable {
  final String currentPassword;
  final String newPassword;

  const ChangePasswordParams({
    required this.currentPassword,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [currentPassword, newPassword];
}
