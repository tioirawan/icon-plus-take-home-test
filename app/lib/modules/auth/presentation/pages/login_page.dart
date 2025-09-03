import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_plus_app/modules/auth/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:icon_plus_app/modules/auth/presentation/widgets/login_form.dart';
import 'package:icon_plus_app/modules/core/di/di.dart';
import 'package:icon_plus_app/modules/core/router/app_router.dart';
import 'package:icon_plus_app/modules/core/theme/app_dimensions.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => getIt<LoginBloc>(),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.success) {
              // Navigate to profile on success
              context.go(AppRouter.profile);
            }
            if (state.status == LoginStatus.failure) {
              // Show error snackbar
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage ?? 'An error occurred'),
                    backgroundColor: Colors.redAccent,
                  ),
                );
            }
          },
          child: const SingleChildScrollView(
            padding: AppDimensions.pagePadding,
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}
