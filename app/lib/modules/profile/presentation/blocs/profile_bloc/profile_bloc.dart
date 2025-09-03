import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_plus_app/modules/auth/domain/entities/user.dart';
import 'package:icon_plus_app/modules/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:icon_plus_app/modules/profile/domain/usecases/get_profile_usecase.dart';
import 'package:icon_plus_app/modules/profile/domain/usecases/logout_usecase.dart';
import 'package:injectable/injectable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase _getProfileUseCase;
  final LogoutUseCase _logoutUseCase;
  final AuthBloc _authBloc;

  ProfileBloc(this._getProfileUseCase, this._logoutUseCase, this._authBloc)
    : super(const ProfileState()) {
    on<ProfileFetched>(_onProfileFetched);
    on<ProfileLogoutSubmitted>(_onProfileLogoutSubmitted);
  }

  Future<void> _onProfileFetched(
    ProfileFetched event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final user = await _getProfileUseCase();
      emit(state.copyWith(status: ProfileStatus.success, user: user));
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: 'Could not load your profile. Please try again.',
        ),
      );
    }
  }

  Future<void> _onProfileLogoutSubmitted(
    ProfileLogoutSubmitted event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      await _logoutUseCase();
    } finally {
      // call auth bloc, emit logout event to clear tokens
      _authBloc.add(AuthLogoutRequested());
    }
  }
}
