import 'package:flutter/material.dart';
import 'package:todo_app/core/app_constants.dart';
import 'package:todo_app/features/todo/presentation/cubit/todo_state.dart';

class TodoStat extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final String title;
  final TodoState todoState;
  final TodoStatus todoStatus;

  const TodoStat({
    required this.icon,
    required this.iconBgColor,
    required this.title,
    required this.todoState,
    required this.todoStatus,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(5),
                child: Icon(icon, color: Colors.white),
              ),
              SizedBox(width: 20),
              Text(title),
            ],
          ),
          if (todoState is TodoLoading) CircularProgressIndicator(),
          if (todoState is TodoLoaded)
            Text(
              "${todoStatus == TodoStatus.completed
                  ? (todoState as TodoLoaded).completedCount
                  : todoStatus == TodoStatus.pending
                  ? (todoState as TodoLoaded).pendingCount
                  : (todoState as TodoLoaded).overdueCount}",
            ),
        ],
      ),
    );
  }
}
