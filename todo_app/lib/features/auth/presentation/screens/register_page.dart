import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/app_theme.dart';
import 'package:todo_app/core/router.dart';
import 'package:todo_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:todo_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:todo_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:todo_app/features/auth/presentation/widgets/auth_textfields.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.pushReplacementNamed(AppRouter.todoRoute.name);
          }
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Theme.of(context).colorScheme.error,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Create an account',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: AppTheme.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),
                    AuthTextField(
                      controller: _fullNameController,
                      labelText: 'Full Name',
                      prefixIcon: Icons.person_outline,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),
                    AuthTextField(
                      controller: _emailController,
                      labelText: 'Email',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),
                    AuthTextField(
                      controller: _passwordController,
                      labelText: 'Password',
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                      isPasswordVisible: _isPasswordVisible,
                      onVisibilityToggle: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),
                    AuthTextField(
                      controller: _confirmPasswordController,
                      labelText: 'Confirm Password',
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                      isPasswordVisible: _isConfirmPasswordVisible,
                      onVisibilityToggle: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        if (_fullNameController.text.trim().isEmpty ||
                            _emailController.text.isEmpty ||
                            _passwordController.text.isEmpty ||
                            _confirmPasswordController.text.isEmpty) {
                          // Show error for empty fields
                          context.read<AuthCubit>().setAuthFailure("Please fill in all fields");
                        } else if (_passwordController.text !=
                            _confirmPasswordController.text) {
                          // Show error for password mismatch
                          context.read<AuthCubit>().setAuthFailure("Passwords are not matching!");
                        } else {
                          context.read<AuthCubit>().register(
                            _emailController.text,
                            _passwordController.text,
                            _fullNameController.text.trim(),
                          );
                        }
                      },
                      child: const Text('Register'),
                    ),
                    const SizedBox(height: 30),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(color: AppTheme.primaryColor),
                        children: [
                          TextSpan(text: 'Already have an account? '),
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.pushReplacementNamed(AppRouter.loginRoute.name);
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
