import 'package:equatable/equatable.dart';
import 'package:icon_plus_app/modules/auth/domain/entities/user.dart';
import 'package:icon_plus_app/modules/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateProfileUseCase {
  final ProfileRepository _repository;

  UpdateProfileUseCase(this._repository);

  Future<User> call(UpdateProfileParams params) {
    return _repository.updateProfile(
      name: params.name,
      jobTitle: params.jobTitle,
      company: params.company,
    );
  }
}

class UpdateProfileParams extends Equatable {
  final String name;
  final String jobTitle;
  final String company;

  const UpdateProfileParams({
    required this.name,
    required this.jobTitle,
    required this.company,
  });

  @override
  List<Object?> get props => [name, jobTitle, company];
}
