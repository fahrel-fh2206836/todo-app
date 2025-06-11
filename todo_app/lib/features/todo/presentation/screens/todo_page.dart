import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/app_theme.dart';
import 'package:todo_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:todo_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:todo_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:todo_app/features/todo/data/repositories/todo_repository.dart';
import 'package:todo_app/features/todo/presentation/cubit/todo_cubit.dart';
import 'package:todo_app/features/todo/presentation/cubit/todo_state.dart';
import 'package:todo_app/features/todo/presentation/widgets/todo_card.dart';
import 'package:todo_app/features/todo/presentation/widgets/todo_stats.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          return BlocProvider(
            create: (_) =>
                TodoCubit(TodoRepositoryImpl())..getTodos(state.profile.id),
            child: Scaffold(
              backgroundColor: AppTheme.backgroundColor,
              appBar: AppBar(
                title: Text(
                  "${state.profile.displayName}'s Todos",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    onPressed: () {
                      AuthRepositoryImpl().logout();
                      context.pop();
                    },
                    icon: Icon(Icons.logout),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      _sectionTitle("Todo Statistics"),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TodoStat(
                            icon: Icons.check,
                            iconBgColor: AppTheme.accentColor,
                            title: "Finished Todos",
                            value: "3",
                          ),
                          TodoStat(
                            icon: Icons.pending_actions,
                            iconBgColor: const Color.fromARGB(
                              255,
                              247,
                              227,
                              51,
                            ),
                            title: "Pending Todos",
                            value: "3",
                          ),
                          TodoStat(
                            icon: Icons.assignment_late,
                            iconBgColor: AppTheme.errorColor,
                            title: "Overdue Todos",
                            value: "3",
                          ),
                        ],
                      ),
                      Divider(height: 10),
                      BlocBuilder<TodoCubit, TodoState>(
                        builder: (context, state) {
                          if (state is TodoLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state is TodoFailure) {
                            return Center(child: Text(state.error));
                          }
                          if (state is TodoLoaded) {
                            return Expanded(
                              child: ListView.builder(
                                itemCount: state.todos.length,
                                itemBuilder: (context, index) {
                                  final todo = state.todos[index];
                                          
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    child: TodoCard(
                                      title: todo.name,
                                      time: todo.deadline.toIso8601String(),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  final title = await showDialog<String>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Add Todo'),
                      content: TextField(
                        controller: titleController,
                        decoration: const InputDecoration(labelText: 'Title'),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, titleController.text);
                          },
                          child: const Text('Add'),
                        ),
                      ],
                    ),
                  );
                  if (title != null && title.isNotEmpty) {
                    // context.read<TodoCubit>().addTodo(title);
                  }
                },
                child: Icon(Icons.add),
              ),
            ),
          );
        }
        return Center(child: Text("Authentication Failure!"));
      },
    );
  }

  Widget _sectionTitle(String title) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      decoration: BoxDecoration(
        color: AppTheme.secondaryColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Text(title, style: TextStyle(color: Colors.white, fontSize: 20)),
    );
  }
}
