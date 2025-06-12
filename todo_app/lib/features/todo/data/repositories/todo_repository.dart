import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final supabase = Supabase.instance.client;

  @override
  Future<void> addTodo(String name, DateTime deadline) async {
    final response = await supabase.from('todo').insert({
      'profile_id': supabase.auth.currentUser!.id,
      'name': name,
      'deadline': deadline.toIso8601String(),
    });

    if (response.error != null) {
      throw Exception('Failed to add todo: ${response.error!.message}');
    }
  }

  @override
  Future<void> deleteTodo(String todoId) async {
    final response = await supabase.from('todo').delete().eq('id', todoId);

    if (response.error != null) {
      throw Exception('Failed to delete todo: ${response.error!.message}');
    }
  }

  @override
  Future<void> updateTodo(
    String todoId,
    String name,
    DateTime deadline,
    bool isCompleted,
  ) async {
    final response = await supabase
        .from('todo')
        .update({
          'name': name,
          'deadline': deadline.toIso8601String(),
          'is_completed': isCompleted,
        })
        .eq('id', todoId);

    if (response.error != null) {
      throw Exception('Failed to update todo: ${response.error!.message}');
    }
  }

  @override
  Future<List<Todo>> getTodos(String userId) async {
    final data = await supabase
        .from('todo')
        .select()
        .eq('profile_id', userId)
        .order('deadline', ascending: false);

    final List<Todo> todos = data.map((item) => Todo.fromJson(item)).toList();

    return todos;
  }
}
