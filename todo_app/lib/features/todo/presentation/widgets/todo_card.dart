import 'package:flutter/material.dart';
import 'package:todo_app/core/app_theme.dart';

class TodoCard extends StatelessWidget {
  final String title;
  final DateTime deadline;
  final bool isChecked;
  final Function() onDelete;
  final Function(bool?) onChecked;

  const TodoCard({
    required this.title,
    required this.deadline,
    required this.onDelete,
    required this.onChecked,
    required this.isChecked,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            decoration: isChecked
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            color: isChecked ? AppTheme.secondaryTextColor : AppTheme.textColor,
          ),
        ),
        subtitle: Text(
          'Deadline: ${deadline.toIso8601String().substring(0,10)} ${deadline.isBefore(DateTime.now()) ? "Overdue" : ""}',
          style: TextStyle(
            fontSize: 13,
            color: deadline.isBefore(DateTime.now()) ? AppTheme.errorColor : Colors.green,
            decoration: isChecked
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        leading: Checkbox(
          value: isChecked,
          onChanged: onChecked,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        trailing: IconButton(
          onPressed: onDelete,
          icon: Icon(Icons.delete, color: Colors.red),
        ),
      ),
    );
  }
}
