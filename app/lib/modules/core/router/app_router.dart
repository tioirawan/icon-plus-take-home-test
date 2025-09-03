import 'package:go_router/go_router.dart';
import 'package:icon_plus_app/modules/auth/presentation/pages/login_page.dart';
import 'package:icon_plus_app/modules/profile/presentation/pages/profile_page.dart';

class AppRouter {
  static const String login = '/login';
  static const String profile = '/profile';

  static final router = GoRouter(
    initialLocation: login,
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
