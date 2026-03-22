import 'package:docguard/common/app_colors.dart';
import 'package:docguard/features/auth/presentation/blocs/forgot_password_bloc.dart';
import 'package:docguard/features/auth/presentation/widgets/auth_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state.status == ForgotPasswordStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Request Failed'),
                backgroundColor: AppColors.error400,
              ),
            );
          }
          if (state.status == ForgotPasswordStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Reset instructions sent to your email.'),
                backgroundColor: AppColors.success400,
              ),
            );
            Navigator.of(context).pop();
          }
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
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
                          'Forgot Password?',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.grey800,
                              ),
                        ).animate().fadeIn().slideX(begin: -0.1, end: 0),
                        const SizedBox(height: 8),
                        Text(
                          'Enter your email address and we will send you instructions to reset your password.',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: AppColors.grey500),
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
                        const SizedBox(height: 48),
                        BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                          builder: (context, state) {
                            return CustomButton(
                              text: 'Send Instructions',
                              isLoading:
                                  state.status == ForgotPasswordStatus.loading,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<ForgotPasswordBloc>().add(
                                    ForgotPasswordEvent.resetPasswordRequested(
                                      _emailController.text.trim(),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        ).animate().fadeIn(delay: 500.ms),
                      ],
                    ),
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
