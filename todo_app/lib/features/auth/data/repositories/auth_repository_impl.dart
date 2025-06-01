import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/features/auth/data/datasources/supabase_auth_datasource.dart';
import 'package:todo_app/features/auth/data/models/user_model.dart';
import 'package:todo_app/features/auth/domain/entities/user.dart';
import 'package:todo_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, User>> signIn(String email, String password) async {
    try {
      final response = await dataSource.signIn(email, password);
      final user = UserModel.fromSupabaseUser(
        response.user!,
        userData: response.user!.userMetadata,
      );
      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthenticationFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signUp({
    required String email,
    required String password,
    String? firstName,
    String? lastName,
  }) async {
    try {
      final response = await dataSource.signUp(
        email,
        password,
        firstName: firstName,
        lastName: lastName,
      );
      final user = UserModel.fromSupabaseUser(
        response.user!,
        userData: response.user!.userMetadata,
      );
      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthenticationFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await dataSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}