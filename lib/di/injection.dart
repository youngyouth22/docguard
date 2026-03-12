import 'package:docguard/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:docguard/features/auth/domain/repositories/auth_repository.dart';
import 'package:docguard/features/auth/domain/usecases/auth_usecases.dart';
import 'package:docguard/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:docguard/features/auth/presentation/blocs/forgot_password_bloc.dart';
import 'package:docguard/features/auth/presentation/blocs/login_bloc.dart';
import 'package:docguard/features/auth/presentation/blocs/register_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  // Supabase
  final supabase = Supabase.instance.client;
  getIt.registerLazySingleton<SupabaseClient>(() => supabase);

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<SupabaseClient>()),
  );

  // Use Cases
  getIt.registerLazySingleton(() => SignInUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => SignUpUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => SignOutUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => GetSessionUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(
    () => ResetPasswordUseCase(getIt<AuthRepository>()),
  );

  // BLoCs
  getIt.registerFactory(
    () => AuthBloc(
      getSessionUseCase: getIt<GetSessionUseCase>(),
      signOutUseCase: getIt<SignOutUseCase>(),
    ),
  );
  getIt.registerFactory(() => LoginBloc(getIt<SignInUseCase>()));
  getIt.registerFactory(() => RegisterBloc(getIt<SignUpUseCase>()));
  getIt.registerFactory(
    () => ForgotPasswordBloc(getIt<ResetPasswordUseCase>()),
  );
}
