import 'package:flutter/material.dart';
import 'package:icon_plus_app/modules/core/router/app_router.dart';
import 'package:icon_plus_app/modules/core/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

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
