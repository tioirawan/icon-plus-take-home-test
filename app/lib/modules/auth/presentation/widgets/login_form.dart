import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_plus_app/modules/auth/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:icon_plus_app/modules/core/theme/app_colors.dart';
import 'package:icon_plus_app/modules/core/theme/app_text_styles.dart';
import 'package:icon_plus_app/modules/core/utils/space_helpers.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginBloc>().add(
        LoginSubmitted(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
    }
  }

  Widget _buildGoogleIcon() {
    return Image.network(
      'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png',
      height: 22.0,
      width: 22.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (MediaQuery.of(context).size.height * 0.15).heightBox,
          Text(
            'Login',
            style: AppTextStyles.heading1.copyWith(
              color: AppColors.primaryDark,
            ),
          ),
          8.heightBox,
          Text(
            'Enter your credentials to continue.',
            style: AppTextStyles.caption.copyWith(fontSize: 16),
          ),
          48.heightBox,
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          16.heightBox,
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              suffixIcon: IconButton(
                onPressed:
                    () => setState(() {
                      _obscurePassword = !_obscurePassword;
                    }),
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                tooltip: _obscurePassword ? 'Show password' : 'Hide password',
              ),
            ),
            obscureText: _obscurePassword,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          12.heightBox,
          Row(
            children: [
              Checkbox(
                value: _rememberMe,
                onChanged: (v) => setState(() => _rememberMe = v ?? false),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              const SizedBox(width: 4),
              const Text('Remember me'),
            ],
          ),
          16.heightBox,
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              final isLoading = state.status == LoginStatus.loading;
              return ElevatedButton(
                onPressed: isLoading ? null : _onLoginPressed,
                child:
                    isLoading
                        ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                        : const Text('Login'),
              );
            },
          ),
          24.heightBox,
          _buildDivider(),
          24.heightBox,
          OutlinedButton.icon(
            icon: _buildGoogleIcon(),
            label: const Text('Sign in with Google'),
            onPressed: () {
              // TODO: Implement Google Sign-In
            },
          ),
          24.heightBox,
          Text.rich(
            TextSpan(
              text: "Don't have an account? ",
              style: AppTextStyles.caption.copyWith(
                fontSize: 15,
                color: AppColors.black,
              ),
              children: [
                TextSpan(
                  text: 'Register',
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap = () {
                          // TODO: Navigate to Register Page
                        },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.grey4, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'OR',
            style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.grey4, thickness: 1)),
      ],
    );
  }
}
