import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_plus_app/modules/core/api/api_exceptions.dart';
import 'package:icon_plus_app/modules/profile/domain/usecases/change_password_usecase.dart';
import 'package:injectable/injectable.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

@injectable
class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordBloc(this._changePasswordUseCase)
    : super(const ChangePasswordState()) {
    on<ChangePasswordFormSubmitted>(_onFormSubmitted);
  }

  Future<void> _onFormSubmitted(
    ChangePasswordFormSubmitted event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(state.copyWith(status: ChangePasswordStatus.loading));
    try {
      await _changePasswordUseCase(
        ChangePasswordParams(
          currentPassword: event.currentPassword,
          newPassword: event.newPassword,
        ),
      );
      emit(state.copyWith(status: ChangePasswordStatus.success));
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          status: ChangePasswordStatus.failure,
          errorMessage: e.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: ChangePasswordStatus.failure,
          errorMessage: 'An unexpected error occurred.',
        ),
      );
    }
  }
}
