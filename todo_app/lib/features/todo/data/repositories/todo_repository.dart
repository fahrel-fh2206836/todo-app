import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final supabase = Supabase.instance.client;

  @override
  Future<void> addTodo(String name, DateTime deadline) async {
    await supabase.from('todo').insert({
      'profile_id': supabase.auth.currentUser!.id,
      'name': name,
      'deadline': deadline.toIso8601String(),
    });
  }

  @override
  Future<void> deleteTodo(String todoId) async {
    await supabase.from('todo').delete().eq('id', todoId);
  }

  @override
  Future<void> updateTodo(
    String todoId,
    String name,
    DateTime deadline,
    bool isCompleted,
  ) async {
    await supabase
        .from('todo')
        .update({
          'name': name,
          'deadline': deadline.toIso8601String(),
          'is_completed': isCompleted,
        })
        .eq('id', todoId);
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
