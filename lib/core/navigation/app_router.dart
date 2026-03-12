import 'package:docguard/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:docguard/features/auth/presentation/screens/dashboard_screen.dart';
import 'package:docguard/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:docguard/features/auth/presentation/screens/login_screen.dart';
import 'package:docguard/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:docguard/features/auth/presentation/screens/register_screen.dart';
import 'package:docguard/features/auth/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Application routes configuration with automatic redirection logic.
class AppRouter {
  final AuthBloc authBloc;

  AppRouter(this.authBloc);

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String dashboard = '/dashboard';

  late final GoRouter router = GoRouter(
    initialLocation: splash,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(path: login, builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),
    ],
    redirect: (context, state) {
      final authState = authBloc.state;
      final bool isAuthPath =
          state.uri.path == login ||
          state.uri.path == register ||
          state.uri.path == forgotPassword ||
          state.uri.path == onboarding ||
          state.uri.path == splash;

      return authState.maybeWhen(
        authenticated: (_) {
          if (isAuthPath) {
            return dashboard;
          }
          return null;
        },
        unauthenticated: () {
          if (state.uri.path == splash) {
            return onboarding;
          }
          if (state.uri.path == onboarding) {
            return null;
          }
          if (!isAuthPath) {
            return login;
          }
          return null;
        },
        orElse: () => null,
      );
    },
  );
}

/// Helper class to convert a Stream into a Listenable for GoRouter.
class GoRouterRefreshStream extends ChangeNotifier {
  late final dynamic _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
