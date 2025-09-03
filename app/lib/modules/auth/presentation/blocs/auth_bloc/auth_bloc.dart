import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_plus_app/modules/auth/domain/entities/user.dart';
import 'package:icon_plus_app/modules/auth/domain/repositories/token_repository.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@singleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final TokenRepository _tokenRepository;

  AuthBloc(this._tokenRepository) : super(const AuthState.unknown()) {
    on<AuthStatusChecked>(_onAuthStatusChecked);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<AuthLoginSuccess>(_onAuthLoginSuccess);
  }

  Future<void> _onAuthStatusChecked(
    AuthStatusChecked event,
    Emitter<AuthState> emit,
  ) async {
    // On app start, check if we have a token.
    final token = await _tokenRepository.getAccessToken();
    if (token != null) {
      // In a real app, you'd verify the token or fetch the user profile here.
      // For simplicity, we'll assume a token means we are logged in.
      // The profile page will handle fetching the actual user.
      emit(const AuthState(status: AuthStatus.authenticated));
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  void _onAuthLoginSuccess(AuthLoginSuccess event, Emitter<AuthState> emit) {
    emit(const AuthState(status: AuthStatus.authenticated));
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    // Backend logout is handled in ProfileBloc/LogoutUseCase
    // Here, we just clear local tokens and update state.
    await _tokenRepository.clearTokens();
    emit(const AuthState.unauthenticated());
  }
}
