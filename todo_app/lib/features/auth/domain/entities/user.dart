class User {
  final String id;
  final String email;
  final String? firstName;
  final String? lastName;

  User({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
  });
}