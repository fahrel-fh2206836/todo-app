import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final String title;
  final String time;
  final bool isChecked;
  final Function() onDelete;
  final Function(bool?) onChecked;

  const TodoCard({required this.title, required this.time, required this.onDelete,  required this.onChecked, required this.isChecked, super.key});

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
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          time,
          style: TextStyle(fontSize: 13, color: Colors.grey[600]),
        ),
        leading: Checkbox(
          value: isChecked,
          onChanged: onChecked,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        trailing: 
            IconButton(onPressed: onDelete, icon: Icon(Icons.delete, color: Colors.red,)),
      ),
    );
  }
}
