import 'package:icon_plus_app/modules/auth/domain/entities/user.dart';
import 'package:icon_plus_app/modules/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProfileUseCase {
  final ProfileRepository _repository;

  GetProfileUseCase(this._repository);

  Future<User> call() {
    return _repository.getProfile();
  }
}
