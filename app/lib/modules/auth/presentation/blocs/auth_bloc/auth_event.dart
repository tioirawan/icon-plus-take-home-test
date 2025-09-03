part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

/// Event to check authentication status on app start.
class AuthStatusChecked extends AuthEvent {}

/// Event triggered when a user successfully logs in.
class AuthLoginSuccess extends AuthEvent {}

/// Event triggered to log a user out.
class AuthLogoutRequested extends AuthEvent {}
