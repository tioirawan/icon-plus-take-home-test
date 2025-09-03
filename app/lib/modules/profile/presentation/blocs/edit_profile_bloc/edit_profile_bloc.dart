import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_plus_app/modules/core/api/api_exceptions.dart';
import 'package:icon_plus_app/modules/profile/domain/usecases/update_profile_usecase.dart';
import 'package:injectable/injectable.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

@injectable
class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final UpdateProfileUseCase _updateProfileUseCase;

  EditProfileBloc(this._updateProfileUseCase)
    : super(const EditProfileState()) {
    on<EditProfileFormSubmitted>(_onFormSubmitted);
  }

  Future<void> _onFormSubmitted(
    EditProfileFormSubmitted event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(state.copyWith(status: EditProfileStatus.loading));
    try {
      await _updateProfileUseCase(
        UpdateProfileParams(
          name: event.name,
          jobTitle: event.jobTitle,
          company: event.company,
        ),
      );
      emit(state.copyWith(status: EditProfileStatus.success));
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          status: EditProfileStatus.failure,
          errorMessage: e.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: EditProfileStatus.failure,
          errorMessage: 'An unexpected error occurred.',
        ),
      );
    }
  }
}
