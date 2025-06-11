import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo_app/features/todo/presentation/cubit/todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository todoRepository;

  TodoCubit(this.todoRepository) : super(TodoInitial());

  Future<void> getTodos(String userId) async {
    emit(TodoLoading());
    try {
      final todos = await todoRepository.getTodos(userId);
      emit(TodoLoaded(todos));
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }

  Future<void> addTodo(String userId, String name, DateTime deadline) async {
    try {
      await todoRepository.addTodo(name, deadline);
      await getTodos(userId);
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }

  Future<void> updateTodo(
    String userId,
    String todoId,
    String name,
    DateTime deadline,
    String isCompleted,
  ) async {
    try {
      await todoRepository.updateTodo(todoId, name, deadline, isCompleted);
      await getTodos(userId);
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }

  Future<void> deleteTodo(String userId, String todoId) async {
    try {
      await todoRepository.deleteTodo(todoId);
      await getTodos(userId);
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }
}
