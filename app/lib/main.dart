import 'package:flutter/material.dart';
import 'package:icon_plus_app/app.dart';
import 'package:icon_plus_app/modules/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:icon_plus_app/modules/core/di/di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  getIt<AuthBloc>().add(AuthStatusChecked());
  runApp(const App());
}
