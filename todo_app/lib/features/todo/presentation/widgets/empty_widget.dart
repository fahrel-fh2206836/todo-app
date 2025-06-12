import 'package:flutter/material.dart';
import 'package:todo_app/core/app_theme.dart';

class EmptyWidget extends StatelessWidget {
  final String text;
  const EmptyWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.error_rounded,
            size: 50,
            color: AppTheme.secondaryTextColor,
          ),
          Text(text, style: TextStyle(fontSize: 17)),
        ],
      ),
    );
  }
}
