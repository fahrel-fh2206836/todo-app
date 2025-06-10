class User {
  final String id;
  final String displayName;

  User({required this.id, required this.displayName});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      displayName: json['display_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'display_name': displayName,
    };
  }
}
