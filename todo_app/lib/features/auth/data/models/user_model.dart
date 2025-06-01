import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:todo_app/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String id,
    required String email,
    String? firstName,
    String? lastName,
  }) : super(
          id: id,
          email: email,
          firstName: firstName,
          lastName: lastName,
        );

  factory UserModel.fromSupabaseUser(supabase.User user, {Map<String, dynamic>? userData}) {
    return UserModel(
      id: user.id,
      email: user.email ?? '',
      firstName: userData?['first_name'],
      lastName: userData?['last_name'],
    );
  }
}