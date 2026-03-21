import 'package:docguard/core/services/persistence_service.dart';
import 'package:docguard/di/injection.dart';
import 'package:docguard/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:docguard/features/auth/presentation/blocs/verify_otp_bloc.dart';
import 'package:docguard/features/auth/presentation/screens/dashboard_screen.dart';
import 'package:docguard/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:docguard/features/auth/presentation/screens/login_screen.dart';
import 'package:docguard/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:docguard/features/auth/presentation/screens/register_screen.dart';
import 'package:docguard/features/auth/presentation/screens/splash_screen.dart';
import 'package:docguard/features/auth/presentation/screens/verify_otp_screen.dart';
import 'package:docguard/features/documents/domain/entities/document_entity.dart';
import 'package:docguard/features/documents/presentation/screens/category_documents_screen.dart';
import 'package:docguard/features/documents/presentation/screens/pdf_viewer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  static const String verifyOtp = '/verify-otp';
  static const String dashboard = '/dashboard';
  static const String categoryDocuments = '/category-documents';
  static const String pdfViewer = '/pdf-viewer';

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
      GoRoute(
        path: verifyOtp,
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return BlocProvider(
            create: (context) => getIt<VerifyOtpBloc>(),
            child: VerifyOtpScreen(email: email),
          );
        },
      ),
      GoRoute(
        path: categoryDocuments,
        builder: (context, state) {
          final categoryName = state.extra as String;
          return CategoryDocumentsScreen(categoryName: categoryName);
        },
      ),
      GoRoute(
        path: pdfViewer,
        builder: (context, state) {
          final document = state.extra as DocumentEntity;
          return PdfViewerScreen(document: document);
        },
      ),
    ],
    redirect: (context, state) {
      final persistenceService = getIt<PersistenceService>();
      final authState = authBloc.state;
      final String location = state.uri.path;

      final bool isAuthPath =
          location == login ||
          location == register ||
          location == forgotPassword ||
          location == onboarding ||
          location == verifyOtp ||
          location == splash;

      return authState.maybeWhen(
        authenticated: (_) {
          if (isAuthPath) {
            return dashboard;
          }
          return null;
        },
        unauthenticated: () {
          if (location == splash) {
            return onboarding;
          }
          if (location == onboarding) {
            if (!persistenceService.shouldShowOnboarding()) {
              return login;
            }
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
