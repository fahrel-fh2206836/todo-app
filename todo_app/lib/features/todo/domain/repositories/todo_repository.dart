abstract class TodoRepository {
  Future<void> getTodos(String userId);
  Future<void> editTodo(String todoId);
  Future<void> deleteTodo(String todoId);
  Future<void> addTodo();
}