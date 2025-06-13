import 'package:todo_app/features/todo/domain/entities/todo.dart';

abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos;
  final int pendingCount;
  final int completedCount;
  final int overdueCount;

  TodoLoaded(this.todos, this.pendingCount, this.completedCount, this.overdueCount);
}

class TodoFailure extends TodoState {
  final String error;

  TodoFailure(this.error);
}