import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/features/auth/data/datasources/supabase_auth_datasource.dart';
import 'package:todo_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:todo_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:todo_app/features/auth/domain/usecases/sign_in.dart';
import 'package:todo_app/features/auth/domain/usecases/sign_up.dart';
import 'package:todo_app/features/auth/presentation/bloc/auth_bloc.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // Supabase
  final supabase = Supabase.instance.client;
  
  // DataSources
  getIt.registerLazySingleton<AuthDataSource>(
    () => SupabaseAuthDataSource(supabase),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );

  // Use Cases
  getIt.registerLazySingleton(() => SignIn(getIt()));
  getIt.registerLazySingleton(() => SignUp(getIt()));

  // BLoCs
  getIt.registerFactory(
    () => AuthBloc(getIt<AuthRepository>()),
  );
}