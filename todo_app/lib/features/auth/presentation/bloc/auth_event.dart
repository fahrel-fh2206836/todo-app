abstract class AuthEvent {}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested({
    required this.email,
    required this.password,
  });
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String? firstName;
  final String? lastName;

  SignUpRequested({
    required this.email,
    required this.password,
    this.firstName,
    this.lastName,
  });
}

class SignOutRequested extends AuthEvent {} 