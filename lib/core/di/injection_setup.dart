import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/datasources/settings_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/usecases/auth/sign_in_usecase.dart';
import '../../domain/usecases/auth/sign_up_usecase.dart';
import '../../domain/usecases/auth/sign_out_usecase.dart';
import '../../domain/usecases/auth/forgot_password_usecase.dart';
import '../../domain/usecases/auth/delete_account_usecase.dart';
import '../../domain/usecases/settings/get_settings_usecase.dart';
import '../../domain/usecases/settings/update_settings_usecase.dart';
import '../../domain/usecases/settings/update_profile_usecase.dart';
import '../../domain/usecases/settings/change_password_usecase.dart';
import '../../presentation/providers/auth_provider.dart';
import '../../presentation/providers/settings_provider.dart';

final getIt = GetIt.instance;

/// Initialize all dependencies using GetIt
Future<void> setupDependencyInjection() async {
  // Firebase instances (singletons)
  getIt.registerLazySingleton<firebase_auth.FirebaseAuth>(
    () => firebase_auth.FirebaseAuth.instance,
  );

  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  // Data sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(
      firebaseAuth: getIt<firebase_auth.FirebaseAuth>(),
      firestore: getIt<FirebaseFirestore>(),
    ),
  );

  getIt.registerLazySingleton<SettingsRemoteDataSource>(
    () => SettingsRemoteDataSource(
      firestore: getIt<FirebaseFirestore>(),
      firebaseAuth: getIt<firebase_auth.FirebaseAuth>(),
    ),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
  );

  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(getIt<SettingsRemoteDataSource>()),
  );

  // Use cases - Authentication
  getIt.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<SignUpUseCase>(
    () => SignUpUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<ForgotPasswordUseCase>(
    () => ForgotPasswordUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<DeleteAccountUseCase>(
    () => DeleteAccountUseCase(getIt<AuthRepository>()),
  );

  // Use cases - Settings
  getIt.registerLazySingleton<GetSettingsUseCase>(
    () => GetSettingsUseCase(getIt<SettingsRepository>()),
  );

  getIt.registerLazySingleton<UpdateSettingsUseCase>(
    () => UpdateSettingsUseCase(getIt<SettingsRepository>()),
  );

  getIt.registerLazySingleton<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(getIt<SettingsRepository>()),
  );

  getIt.registerLazySingleton<ChangePasswordUseCase>(
    () => ChangePasswordUseCase(getIt<SettingsRepository>()),
  );

  // Providers (factory - new instance each time, but we'll use singleton for consistency with Provider)
  getIt.registerLazySingleton<AuthProvider>(
    () => AuthProvider(
      signInUseCase: getIt<SignInUseCase>(),
      signUpUseCase: getIt<SignUpUseCase>(),
      signOutUseCase: getIt<SignOutUseCase>(),
      forgotPasswordUseCase: getIt<ForgotPasswordUseCase>(),
      deleteAccountUseCase: getIt<DeleteAccountUseCase>(),
      authRepository: getIt<AuthRepository>(),
    ),
  );

  getIt.registerLazySingleton<SettingsProvider>(
    () => SettingsProvider(
      getSettingsUseCase: getIt<GetSettingsUseCase>(),
      updateSettingsUseCase: getIt<UpdateSettingsUseCase>(),
      updateProfileUseCase: getIt<UpdateProfileUseCase>(),
      changePasswordUseCase: getIt<ChangePasswordUseCase>(),
    ),
  );
}
