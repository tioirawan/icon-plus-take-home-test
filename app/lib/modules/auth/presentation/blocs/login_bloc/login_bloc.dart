import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_plus_app/modules/auth/domain/repositories/token_repository.dart';
import 'package:icon_plus_app/modules/auth/domain/usecases/login_usecase.dart';
import 'package:icon_plus_app/modules/core/api/api_exceptions.dart';
import 'package:injectable/injectable.dart';

part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  final TokenRepository _tokenRepository;

  LoginBloc(this._loginUseCase, this._tokenRepository)
    : super(const LoginState()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      final result = await _loginUseCase(
        LoginParams(email: event.email, password: event.password),
      );

      await _tokenRepository.saveTokens(
        accessToken: result.accessToken,
        refreshToken: result.refreshToken,
      );

      emit(state.copyWith(status: LoginStatus.success));
    } on ApiException catch (e) {
      emit(
        state.copyWith(status: LoginStatus.failure, errorMessage: e.message),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: 'An unexpected error occurred. Please try again.',
        ),
      );
    }
  }
}
