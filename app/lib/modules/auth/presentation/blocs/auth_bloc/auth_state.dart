part of 'auth_bloc.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus status;
  final User? user; // We can store the user here for easy access

  const AuthState({this.status = AuthStatus.unknown, this.user});

  const AuthState.unknown() : this();
  const AuthState.authenticated(User user)
    : this(status: AuthStatus.authenticated, user: user);
  const AuthState.unauthenticated() : this(status: AuthStatus.unauthenticated);

  @override
  List<Object?> get props => [status, user];
}
