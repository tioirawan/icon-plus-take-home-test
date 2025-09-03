import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_plus_app/modules/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:icon_plus_app/modules/auth/presentation/pages/login_page.dart';
import 'package:icon_plus_app/modules/core/di/di.dart';
import 'package:icon_plus_app/modules/core/utils/stream_to_listenable.dart';
import 'package:icon_plus_app/modules/profile/presentation/pages/profile_page.dart';

class AppRouter {
  static const String login = '/login';
  static const String profile = '/profile';

  static final router = GoRouter(
    refreshListenable: StreamToListenable([getIt<AuthBloc>().stream]),
    initialLocation: login,
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      final onLoginPage = state.matchedLocation == login;

      if (authState.status == AuthStatus.unauthenticated) {
        return login;
      }

      if (authState.status == AuthStatus.authenticated && onLoginPage) {
        return profile;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: login,
        name: login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: profile,
        name: profile,
        builder: (context, state) => const ProfilePage(),
      ),
    ],
  );
}
