import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/app_constants.dart';
import 'package:todo_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo_app/features/todo/presentation/cubit/todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository todoRepository;

  TodoCubit(this.todoRepository) : super(TodoInitial());

  Future<void> getTodos(String userId, [bool? isCompleted]) async {
    emit(TodoLoading());
    try {
      final todos = (isCompleted == null)
          ? await todoRepository.getTodos(userId)
          : await todoRepository.getTodos(userId, isCompleted);
      emit(TodoLoaded(todos));
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }

  Future<void> addTodo(
    String userId,
    String name,
    DateTime deadline, [
    bool? showCompleted,
  ]) async {
    try {
      await todoRepository.addTodo(name, deadline);
      await getTodos(userId, showCompleted);
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }

  Future<void> updateTodo(
    String userId,
    String todoId,
    String name,
    DateTime deadline,
    bool isCompleted, [
    bool? showCompleted,
  ]) async {
    try {
      await todoRepository.updateTodo(todoId, name, deadline, isCompleted);
      await getTodos(userId, showCompleted);
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }

  Future<void> deleteTodo(
    String userId,
    String todoId, [
    bool? showCompleted,
  ]) async {
    try {
      await todoRepository.deleteTodo(todoId);
      await getTodos(userId, showCompleted);
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }

  void onTabChanged() {
    emit(TodoLoading());
  }
}
