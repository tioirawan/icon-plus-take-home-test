import 'package:go_router/go_router.dart';
import 'package:icon_plus_app/modules/auth/domain/entities/user.dart';
import 'package:icon_plus_app/modules/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:icon_plus_app/modules/auth/presentation/pages/login_page.dart';
import 'package:icon_plus_app/modules/auth/presentation/pages/register_page.dart';
import 'package:icon_plus_app/modules/core/di/di.dart';
import 'package:icon_plus_app/modules/core/presentation/pages/splash_page.dart';
import 'package:icon_plus_app/modules/core/utils/stream_to_listenable.dart';
import 'package:icon_plus_app/modules/profile/presentation/pages/change_password_page.dart';
import 'package:icon_plus_app/modules/profile/presentation/pages/edit_profile_page.dart';
import 'package:icon_plus_app/modules/profile/presentation/pages/profile_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String profile = '/profile';
  static const String editProfile = '/profile/edit';
  static const String changePassword = '/profile/change-password';

  static final _authBloc = getIt<AuthBloc>();

  static final router = GoRouter(
    refreshListenable: StreamToListenable([_authBloc.stream]),
    initialLocation: splash,
    redirect: (context, state) {
      final authState = _authBloc.state;
      final onSplashPage = state.matchedLocation == splash;

      if (authState.status == AuthStatus.unknown) {
        return onSplashPage ? null : splash;
      }

      // If the status is resolved, and we are on the splash page,
      // redirect to the correct screen.
      if (onSplashPage) {
        return authState.status == AuthStatus.authenticated ? profile : login;
      }

      // Handle cases where a logged-in user tries to go to the login page.
      final onLoginPage = state.matchedLocation == login;
      if (authState.status == AuthStatus.authenticated && onLoginPage) {
        return profile;
      }

      final onRegisterPage = state.matchedLocation == register;
      // Handle cases where a logged-out user tries to access a protected page.
      if (authState.status == AuthStatus.unauthenticated &&
          !(onLoginPage || onRegisterPage)) {
        return login;
      }

      return null; // No redirect needed
    },
    routes: [
      GoRoute(
        path: splash,
        name: splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: register,
        name: register,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: login,
        name: login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: profile,
        name: profile,
        builder: (context, state) => const ProfilePage(),
        routes: [
          GoRoute(
            path: 'edit',
            name: editProfile,
            builder:
                (context, state) => EditProfilePage(user: state.extra as User),
          ),
          GoRoute(
            path: 'change-password',
            name: changePassword,
            builder: (context, state) => const ChangePasswordPage(),
          ),
        ],
      ),
    ],
  );
}
