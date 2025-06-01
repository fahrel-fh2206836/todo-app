import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signIn(String email, String password);
  Future<Either<Failure, User>> signUp({
    required String email,
    required String password,
    String? firstName,
    String? lastName,
  });
  Future<Either<Failure, void>> signOut();
}