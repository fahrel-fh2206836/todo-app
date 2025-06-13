import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/app_theme.dart';
import 'package:todo_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:todo_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:todo_app/features/todo/domain/entities/todo.dart';
import 'package:todo_app/features/todo/presentation/cubit/todo_cubit.dart';
import 'package:todo_app/features/todo/presentation/cubit/todo_state.dart';
import 'package:todo_app/features/todo/presentation/widgets/empty_widget.dart';
import 'package:todo_app/features/todo/presentation/widgets/todo_card.dart';
import 'package:todo_app/features/todo/presentation/widgets/todo_stats.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage>
    with SingleTickerProviderStateMixin {
  final _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  late TabController _tabController;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
    final userId = context.read<AuthCubit>().state is AuthSuccess
        ? (context.read<AuthCubit>().state as AuthSuccess).profile.id
        : null;

    if (userId != null) {
      context.read<TodoCubit>().getTodos(userId, false); // false = Pending
    }
  }

  void _onTabChanged() {
    context.read<TodoCubit>().onTabChanged();
    if (_tabController.indexIsChanging)
      return; // Prevent during swipe animation
    final isCompleted = _tabController.index == 1;
    final userId = context.read<AuthCubit>().state is AuthSuccess
        ? (context.read<AuthCubit>().state as AuthSuccess).profile.id
        : null;

    if (userId != null) {
      context.read<TodoCubit>().getTodos(userId, isCompleted);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (authContext, authState) {
        if (authState is AuthSuccess) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppTheme.backgroundColor,
            appBar: AppBar(
              title: Text(
                "${authState.profile.displayName}'s Todos",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  onPressed: () {
                    authContext.read<AuthCubit>().logout();
                    authContext.pop();
                  },
                  icon: Icon(Icons.logout),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _sectionTitle("Todo Statistics"),
                    SizedBox(height: 10),
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
                          iconBgColor: const Color.fromARGB(255, 247, 227, 51),
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
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: AppTheme.primaryColor,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        controller: _tabController,
                        indicator: BoxDecoration(
                          color: AppTheme.accentColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: AppTheme.secondaryColor,
                        tabs: const [
                          Tab(text: 'Pending'),
                          Tab(text: 'Completed'),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: BlocBuilder<TodoCubit, TodoState>(
                        builder: (todoContext, todoState) {
                          if (todoState is TodoLoading) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (todoState is TodoFailure) {
                            return Center(child: Text(todoState.error));
                          }
                          if (todoState is TodoLoaded) {
                            return TabBarView(
                              controller: _tabController,
                              children: [
                                _todosList(
                                  todoContext,
                                  todoState,
                                  authState,
                                  "You do not have any pending todos.",
                                ),
                                _todosList(
                                  todoContext,
                                  todoState,
                                  authState,
                                  "You do not have any completed todos.",
                                ),
                              ],
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await showDialog<Todo>(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: const Text('Add Todo'),
                    content: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Column(
                        children: [
                          TextField(
                            controller: _titleController,
                            decoration: const InputDecoration(
                              labelText: 'Title',
                              prefixIcon: Icon(Icons.title),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: _dateController,
                            decoration: const InputDecoration(
                              labelText: 'Deadline',
                              filled: true,
                              prefixIcon: Icon(Icons.calendar_month),
                            ),
                            readOnly: true,
                            onTap: _selectDate,
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          if (_selectedDate == null ||
                              _titleController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Fill all fields!"),
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.error,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                            return;
                          }
                          context.read<TodoCubit>().addTodo(
                            authState.profile.id,
                            _titleController.text,
                            _selectedDate!,
                            _tabController.index == 1,
                          );
                          _selectedDate = null;
                          _titleController.text = "";
                          _dateController.text = "";
                          Navigator.pop(context);
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                );
              },
              child: Icon(Icons.add),
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

  Widget _todosList(
    BuildContext todoContext,
    TodoLoaded todoState,
    AuthSuccess authState,
    String emptyText,
  ) {
    if (todoState.todos.isEmpty) {
      return EmptyWidget(text: emptyText);
    }
    return ListView.builder(
      itemCount: todoState.todos.length,
      itemBuilder: (context, index) {
        final todo = todoState.todos[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: TodoCard(
            title: todo.name,
            deadline: todo.deadline,
            isChecked: todo.isCompleted,
            onDelete: () {
              todoContext.read<TodoCubit>().deleteTodo(
                authState.profile.id,
                todo.id,
                _tabController.index == 1,
              );
            },
            onChecked: (value) {
              todoContext.read<TodoCubit>().updateTodo(
                authState.profile.id,
                todo.id,
                todo.name,
                todo.deadline,
                value!,
                _tabController.index == 1,
              );
            },
          ),
        );
      },
    );
  }
}
