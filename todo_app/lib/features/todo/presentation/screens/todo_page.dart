import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/app_theme.dart';
import 'package:todo_app/features/todo/presentation/widgets/todo_card.dart';
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
              Divider(height: 10),
              _sectionTitle("Todos"),
              TodoCard(
                icon: Icons.article,
                iconBgColor: Color(0xFFE3F2FD),
                title: 'Study lesson',
                time: '',
              ),
              TodoCard(
                icon: Icons.emoji_events,
                iconBgColor: Color(0xFFFFF3E0),
                title: 'Run 5k',
                time: '4:00pm',
              ),
              TodoCard(
                icon: Icons.calendar_today,
                iconBgColor: Color(0xFFEDE7F6),
                title: 'Go to party',
                time: '10:00pm',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
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
