import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthDataSource {
  Future<AuthResponse> signIn(String email, String password);
  Future<AuthResponse> signUp(String email, String password, {String? firstName, String? lastName});
  Future<void> signOut();
}

class SupabaseAuthDataSource implements AuthDataSource {
  final SupabaseClient _supabaseClient;

  SupabaseAuthDataSource(this._supabaseClient);

  @override
  Future<AuthResponse> signIn(String email, String password) async {
    return await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<AuthResponse> signUp(String email, String password, {String? firstName, String? lastName}) async {
    return await _supabaseClient.auth.signUp(
      email: email,
      password: password,
      data: {
        if (firstName != null) 'first_name': firstName,
        if (lastName != null) 'last_name': lastName,
      },
    );
  }

  @override
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }
}