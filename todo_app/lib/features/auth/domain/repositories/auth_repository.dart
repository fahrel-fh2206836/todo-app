import 'package:todo_app/features/auth/domain/entities/profile.dart';

abstract class AuthRepository {
  Future<void> login(String email, String password);
  Future<void> register(String email, String password, String displayName);
  Future<void> logout();
  Future<Profile> getUser();
}