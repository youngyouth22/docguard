import 'package:docguard/common/app_themes.dart';
import 'package:docguard/core/navigation/app_router.dart';
import 'package:docguard/di/injection.dart';
import 'package:docguard/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:docguard/features/auth/presentation/blocs/forgot_password_bloc.dart';
import 'package:docguard/features/auth/presentation/blocs/login_bloc.dart';
import 'package:docguard/features/auth/presentation/blocs/register_bloc.dart';
import 'package:docguard/features/documents/presentation/blocs/document_bloc.dart';
import 'package:docguard/features/documents/presentation/blocs/document_event.dart';
import 'package:docguard/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:docguard/features/sync/presentation/bloc/sync_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  await setupDependencyInjection();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<AuthBloc>()..add(const AuthEvent.appStarted()),
        ),
        BlocProvider(create: (_) => getIt<LoginBloc>()),
        BlocProvider(create: (_) => getIt<RegisterBloc>()),
        BlocProvider(create: (_) => getIt<ForgotPasswordBloc>()),
        BlocProvider(
          create: (_) =>
              getIt<DocumentBloc>()..add(const DocumentEvent.started()),
        ),
        BlocProvider(
          create: (_) => getIt<SyncBloc>()..add(const SyncEvent.syncStarted()),
        ),
      ],
      child: Builder(
        builder: (context) {
          final authBloc = context.read<AuthBloc>();
          final appRouter = AppRouter(authBloc);

          return MaterialApp.router(
            title: 'DocGuard',
            theme: AppThemes.lightTheme,
            themeMode: ThemeMode.light,
            routerConfig: appRouter.router,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
