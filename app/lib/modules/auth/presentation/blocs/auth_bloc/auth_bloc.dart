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
    final token = await _tokenRepository.getAccessToken();
    if (token != null) {
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
    await _tokenRepository.clearTokens();
    emit(const AuthState.unauthenticated());
  }
}
