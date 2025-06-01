import 'package:todo_app/features/auth/domain/entities/user.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User? user;

  AuthSuccess([this.user]);
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
} 