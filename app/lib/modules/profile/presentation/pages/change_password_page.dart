import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icon_plus_app/modules/core/di/di.dart';
import 'package:icon_plus_app/modules/core/theme/app_dimensions.dart';
import 'package:icon_plus_app/modules/core/utils/space_helpers.dart';
import 'package:icon_plus_app/modules/profile/presentation/blocs/change_password_bloc/change_password_bloc.dart'; // This BLoC would be created

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  void _onSave(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<ChangePasswordBloc>().add(
        ChangePasswordFormSubmitted(
          currentPassword: _currentPasswordController.text,
          newPassword: _newPasswordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChangePasswordBloc>(),
      child: BlocListener<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state.status == ChangePasswordStatus.success) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text("Password changed successfully!"),
                  backgroundColor: Colors.green,
                ),
              );
            context.pop();
          }
          if (state.status == ChangePasswordStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Update failed'),
                  backgroundColor: Colors.red,
                ),
              );
          }
        },
        child: Scaffold(
          appBar: AppBar(title: const Text('Change Password')),
          body: SingleChildScrollView(
            padding: AppDimensions.pagePadding,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  24.heightBox,
                  TextFormField(
                    controller: _currentPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Current Password',
                    ),
                    obscureText: true,
                    validator: (v) => v!.isEmpty ? 'Cannot be empty' : null,
                  ),
                  16.heightBox,
                  TextFormField(
                    controller: _newPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'New Password',
                    ),
                    obscureText: true,
                    validator:
                        (v) =>
                            (v?.length ?? 0) < 8
                                ? 'Must be at least 8 characters'
                                : null,
                  ),
                  32.heightBox,
                  BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed:
                            state.status == ChangePasswordStatus.loading
                                ? null
                                : () => _onSave(context),
                        child:
                            state.status == ChangePasswordStatus.loading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : const Text('Save New Password'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
