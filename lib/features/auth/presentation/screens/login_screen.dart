import 'package:docguard/common/app_colors.dart';
import 'package:docguard/common/app_typography.dart';
import 'package:docguard/core/navigation/app_router.dart';
import 'package:docguard/features/auth/presentation/blocs/login_bloc.dart';
import 'package:docguard/features/auth/presentation/widgets/auth_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Login Failed'),
                backgroundColor: AppColors.error400,
              ),
            );
          }
          if (state.status == LoginStatus.success) {
            context.go(AppRouter.dashboard);
          }
          if (state.status == LoginStatus.needsVerification) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Email not verified. Redirecting to OTP...'),
                backgroundColor: AppColors.primary400,
              ),
            );
            context.push(AppRouter.verifyOtp, extra: state.email);
          }
        },

        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  Text(
                    'Welcome Back!',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.grey800,
                    ),
                  ).animate().fadeIn().slideX(begin: -0.1, end: 0),
                  const SizedBox(height: 8),
                  Text(
                    'Login to continue accessing your secure vault.',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: AppColors.grey500),
                  ).animate().fadeIn(delay: 200.ms),
                  const SizedBox(height: 24),
                  CustomTextField(
                    label: 'Email',
                    hint: 'Enter your email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return 'Invalid email format';
                      }
                      return null;
                    },
                  ).animate().fadeIn(delay: 400.ms),
                  const SizedBox(height: 24),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return CustomTextField(
                        label: 'Password',
                        hint: 'Enter your password',
                        controller: _passwordController,
                        isPassword: true,
                        obscureText: state.obscurePassword,
                        onSuffixIconPressed: () {
                          context.read<LoginBloc>().add(
                            const LoginEvent.passwordVisibilityToggled(),
                          );
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      );
                    },
                  ).animate().fadeIn(delay: 500.ms),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => context.push(AppRouter.forgotPassword),
                      child: Text(
                        'Forgot Password?',
                        style: AppTypography.bodyMMedium.copyWith(
                          color: AppColors.primary400,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 600.ms),
                  const SizedBox(height: 32),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return CustomButton(
                        text: 'Login',
                        isLoading: state.status == LoginStatus.loading,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<LoginBloc>().add(
                              LoginEvent.loginSubmitted(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ).animate().fadeIn(delay: 700.ms),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () => context.push(AppRouter.register),
                        child: const Text('Register Now'),
                      ),
                    ],
                  ).animate().fadeIn(delay: 800.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
