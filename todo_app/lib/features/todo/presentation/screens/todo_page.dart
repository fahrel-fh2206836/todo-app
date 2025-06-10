import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/app_theme.dart';
import 'package:todo_app/features/todo/presentation/widgets/todo_stats.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Your Todos",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
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
              _sectionTitle("Todos"),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.add),),
    );
  }

  Widget _sectionTitle(String title) {
    return Container(
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
