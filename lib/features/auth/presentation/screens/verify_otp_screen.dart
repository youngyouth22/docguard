import 'package:docguard/common/app_colors.dart';
import 'package:docguard/features/auth/presentation/blocs/verify_otp_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String email;

  const VerifyOtpScreen({super.key, required this.email});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final _pinController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: AppColors.grey800,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.transparent),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.primary400),
        color: AppColors.white,
      ),
    );

    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      body: BlocListener<VerifyOtpBloc, VerifyOtpState>(
        listener: (context, state) {
          state.maybeWhen(
            success: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Verification successful!'),
                  backgroundColor: AppColors.success400,
                ),
              );
              // Navigation to dashboard is handled by refreshListenable in GoRouter
            },
            failure: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: AppColors.error400,
                ),
              );
              _pinController.clear();
            },
            orElse: () {},
          );
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Text(
                  'Verify Email',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey800,
                  ),
                ).animate().fadeIn().slideY(begin: -0.1, end: 0),
                const SizedBox(height: 12),
                Text(
                  'We sent a 6-digit code to\n${widget.email}',
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: AppColors.grey500),
                ).animate().fadeIn(delay: 200.ms),
                const SizedBox(height: 48),
                Pinput(
                      length: 6,
                      controller: _pinController,
                      focusNode: _focusNode,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      onCompleted: (pin) {
                        context.read<VerifyOtpBloc>().add(
                          VerifyOtpEvent.submitOtp(
                            email: widget.email,
                            token: pin,
                          ),
                        );
                      },
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 9),
                            width: 22,
                            height: 1,
                            color: AppColors.primary400,
                          ),
                        ],
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 400.ms)
                    .scale(
                      begin: const Offset(0.9, 0.9),
                      end: const Offset(1, 1),
                    ),
                const SizedBox(height: 48),
                BlocBuilder<VerifyOtpBloc, VerifyOtpState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      loading: () => const CircularProgressIndicator(),
                      orElse: () => Column(
                        children: [
                          const Text(
                            "Didn't receive code?",
                            style: TextStyle(color: AppColors.grey500),
                          ),
                          TextButton(
                            onPressed: () {
                              context.read<VerifyOtpBloc>().add(
                                VerifyOtpEvent.resendOtp(email: widget.email),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('OTP Resent'),
                                  backgroundColor: AppColors.primary400,
                                ),
                              );
                            },
                            child: const Text('Resend Code'),
                          ),
                        ],
                      ),
                    );
                  },
                ).animate().fadeIn(delay: 600.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
