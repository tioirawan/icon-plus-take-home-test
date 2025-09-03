import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_plus_app/modules/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:icon_plus_app/modules/core/di/di.dart';
import 'package:icon_plus_app/modules/core/router/app_router.dart';
import 'package:icon_plus_app/modules/core/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>()..add(AuthStatusChecked()),
      child: const _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ICON+ App',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
