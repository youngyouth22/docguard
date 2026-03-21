import 'package:docguard/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:docguard/features/auth/domain/repositories/auth_repository.dart';
import 'package:docguard/features/auth/domain/usecases/auth_usecases.dart';
import 'package:docguard/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:docguard/features/auth/presentation/blocs/forgot_password_bloc.dart';
import 'package:docguard/features/auth/presentation/blocs/login_bloc.dart';
import 'package:docguard/features/auth/presentation/blocs/register_bloc.dart';
import 'package:docguard/core/services/persistence_service.dart';
import 'package:docguard/features/auth/domain/usecases/resend_otp_use_case.dart';
import 'package:docguard/features/auth/domain/usecases/verify_otp_use_case.dart';
import 'package:docguard/features/auth/presentation/blocs/verify_otp_bloc.dart';
import 'package:docguard/core/attachments/queue.dart';
import 'package:docguard/features/documents/data/repositories/document_repository_impl.dart';
import 'package:docguard/features/documents/domain/repositories/i_document_repository.dart';
import 'package:docguard/features/documents/domain/usecases/toggle_favorite_use_case.dart';
import 'package:docguard/features/documents/domain/usecases/upload_and_sync_document_use_case.dart';
import 'package:docguard/features/documents/domain/usecases/upload_scanned_document_use_case.dart';
import 'package:docguard/features/documents/domain/usecases/watch_document_status_use_case.dart';
import 'package:docguard/features/documents/domain/usecases/watch_favorite_documents_use_case.dart';
import 'package:docguard/features/documents/domain/usecases/watch_categories_use_case.dart';
import 'package:docguard/features/documents/domain/usecases/watch_user_documents_use_case.dart';
import 'package:docguard/features/documents/presentation/blocs/document_bloc.dart';
import 'package:docguard/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:docguard/powersync/powersync.dart';
import 'package:get_it/get_it.dart';
import 'package:powersync/powersync.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  // Supabase
  final supabase = Supabase.instance.client;
  getIt.registerLazySingleton<SupabaseClient>(() => supabase);

  // PowerSync
  final powersync = await initPowerSyncDatabase();
  getIt.registerLazySingleton<PowerSyncDatabase>(() => powersync);

  // Attachment Queue
  await initializeAttachmentQueue(powersync);

  // SharedPreferences & Persistence
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<PersistenceService>(
    () => PersistenceService(getIt<SharedPreferences>()),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<SupabaseClient>()),
  );
  getIt.registerLazySingleton<IDocumentRepository>(
    () => DocumentRepositoryImpl(
      getIt<PowerSyncDatabase>(),
      getIt<SupabaseClient>(),
    ),
  );

  // Use Cases
  getIt.registerLazySingleton(() => SignInUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => SignUpUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => SignOutUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => GetSessionUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(
    () => ResetPasswordUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton(() => VerifyOtpUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => ResendOtpUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(
    () => UploadAndSyncDocumentUseCase(getIt<IDocumentRepository>()),
  );
  getIt.registerLazySingleton(
    () => UploadScannedDocumentUseCase(getIt<IDocumentRepository>()),
  );
  getIt.registerLazySingleton(
    () => WatchUserDocumentsUseCase(getIt<IDocumentRepository>()),
  );
  getIt.registerLazySingleton(
    () => WatchFavoriteDocumentsUseCase(getIt<IDocumentRepository>()),
  );
  getIt.registerLazySingleton(
    () => ToggleFavoriteUseCase(getIt<IDocumentRepository>()),
  );
  getIt.registerLazySingleton(
    () => WatchDocumentStatusUseCase(getIt<IDocumentRepository>()),
  );
  getIt.registerLazySingleton(
    () => WatchCategoriesUseCase(getIt<IDocumentRepository>()),
  );

  // BLoCs
  getIt.registerFactory(
    () => AuthBloc(
      getSessionUseCase: getIt<GetSessionUseCase>(),
      signOutUseCase: getIt<SignOutUseCase>(),
      supabaseClient: getIt<SupabaseClient>(),
    ),
  );
  getIt.registerFactory(
    () => LoginBloc(getIt<SignInUseCase>(), getIt<ResendOtpUseCase>()),
  );
  getIt.registerFactory(() => RegisterBloc(getIt<SignUpUseCase>()));
  getIt.registerFactory(
    () => ForgotPasswordBloc(getIt<ResetPasswordUseCase>()),
  );
  getIt.registerFactory(
    () => VerifyOtpBloc(
      verifyOtpUseCase: getIt<VerifyOtpUseCase>(),
      resendOtpUseCase: getIt<ResendOtpUseCase>(),
    ),
  );
  getIt.registerFactory(
    () => DocumentBloc(
      uploadUseCase: getIt<UploadAndSyncDocumentUseCase>(),
      uploadScannedUseCase: getIt<UploadScannedDocumentUseCase>(),
      watchUseCase: getIt<WatchUserDocumentsUseCase>(),
      watchFavoriteUseCase: getIt<WatchFavoriteDocumentsUseCase>(),
      toggleFavoriteUseCase: getIt<ToggleFavoriteUseCase>(),
      watchCategoriesUseCase: getIt<WatchCategoriesUseCase>(),
    ),
  );
  getIt.registerFactory(() => SyncBloc(getIt<PowerSyncDatabase>()));
}
