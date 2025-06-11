class Todo {
  final String id;
  final String profileId;
  String name;
  bool isCompleted;
  DateTime deadline;
  final DateTime createdAt;

  Todo({
    required this.id,
    required this.profileId,
    required this.name,
    required this.isCompleted,
    required this.deadline,
    required this.createdAt,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      profileId: json['profile_id'],
      name: json['name'],
      isCompleted: json['is_completed'],
      deadline: DateTime.parse(json['deadline']),
      createdAt: DateTime.parse(json['created_at']).toLocal(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profile_id': profileId,
      'name': name,
      'is_completed': isCompleted,
      'deadline': deadline.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
