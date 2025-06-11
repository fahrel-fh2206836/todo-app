import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final String title;
  final String time;

  const TodoCard({required this.title, required this.time, super.key});

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
          value: false,
          onChanged: (_) {},
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        trailing: 
            IconButton(onPressed: () {}, icon: Icon(Icons.delete, color: Colors.red,)),
      ),
    );
  }
}
