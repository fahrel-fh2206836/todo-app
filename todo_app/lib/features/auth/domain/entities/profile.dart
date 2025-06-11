class Profile {
  final String id;
  final String displayName;

  Profile({required this.id, required this.displayName});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
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
