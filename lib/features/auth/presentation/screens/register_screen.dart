import 'package:docguard/common/app_colors.dart';
import 'package:docguard/core/navigation/app_router.dart';
import 'package:docguard/features/auth/presentation/blocs/register_bloc.dart';
import 'package:docguard/features/auth/presentation/widgets/auth_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.status == RegisterStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Registration Failed'),
                backgroundColor: AppColors.error400,
              ),
            );
          }
          if (state.status == RegisterStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Account created! Please enter the OTP sent to your email.',
                ),
                backgroundColor: AppColors.success400,
              ),
            );
            context.push(
              AppRouter.verifyOtp,
              extra: _emailController.text.trim(),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Create Account',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.grey800,
                            ),
                      ).animate().fadeIn().slideX(begin: -0.1, end: 0),
                      const SizedBox(height: 8),
                      Text(
                        'Join DocGuard to secure your documents today.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.grey500,
                        ),
                      ).animate().fadeIn(delay: 200.ms),
                      const SizedBox(height: 40),
                      CustomTextField(
                        label: 'Email',
                        hint: 'Enter your email',
                        // icon: Icons.email_rounded,
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
                      BlocBuilder<RegisterBloc, RegisterState>(
                        builder: (context, state) {
                          return CustomTextField(
                            label: 'Password',
                            hint: 'Create a password',
                            // icon: Icons.lock_rounded,
                            controller: _passwordController,
                            isPassword: true,
                            obscureText: state.obscurePassword,
                            onSuffixIconPressed: () {
                              context.read<RegisterBloc>().add(
                                const RegisterEvent.passwordVisibilityToggled(),
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
                      const SizedBox(height: 24),
                      BlocBuilder<RegisterBloc, RegisterState>(
                        builder: (context, state) {
                          return CustomTextField(
                            label: 'Confirm Password',
                            hint: 'Confirm your password',
                            // icon: Icons.lock_outline_rounded,
                            controller: _confirmPasswordController,
                            isPassword: true,
                            obscureText: state.obscureConfirmPassword,
                            onSuffixIconPressed: () {
                              context.read<RegisterBloc>().add(
                                const RegisterEvent.confirmPasswordVisibilityToggled(),
                              );
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          );
                        },
                      ).animate().fadeIn(delay: 600.ms),
                      const SizedBox(height: 48),
                      BlocBuilder<RegisterBloc, RegisterState>(
                        builder: (context, state) {
                          return CustomButton(
                            text: 'Create Account',
                            isLoading: state.status == RegisterStatus.loading,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<RegisterBloc>().add(
                                  RegisterEvent.registerSubmitted(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                    confirmPassword: _confirmPasswordController
                                        .text
                                        .trim(),
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
                          const Text("Already have an account?"),
                          TextButton(
                            onPressed: () => context.pop(),
                            child: const Text('Login'),
                          ),
                        ],
                      ).animate().fadeIn(delay: 800.ms),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
