import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final supabase = Supabase.instance.client;

  @override
  Future<void> login(String email, String password) async {
    await supabase.auth.signInWithPassword(email: email, password: password);
  }

  @override
  Future<void> register(String email, String password, String fullName) async {
    final signUpResponse = await supabase.auth.signUp(
      email: email,
      password: password,
    );

    final user = signUpResponse.user;
    if (user == null) {
      debugPrint('Sign-up failed or email confirmation required.');
      return;
    }

    await supabase.from('profile').insert({
      'id': user.id,
      'full_name': fullName,
    });
  }

  @override
  Future<void> logout() async {
    await supabase.auth.signOut();
  }
}
