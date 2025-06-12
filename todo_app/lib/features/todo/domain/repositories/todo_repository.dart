import 'package:todo_app/features/todo/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodos(String userId);
  Future<void> deleteTodo(String todoId);
  Future<void> updateTodo(String todoId, String name, DateTime deadline, bool isCompleted);
  Future<void> addTodo(String name, DateTime deadline);
}