import 'package:todo_app/features/auth/domain/entities/profile.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final Profile profile;

  AuthSuccess(this.profile);
}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);
}