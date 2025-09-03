import 'package:flutter/material.dart';
import 'package:icon_plus_app/app.dart';
import 'package:icon_plus_app/modules/core/di/di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const App());
}
