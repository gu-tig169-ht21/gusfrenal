import 'package:flutter/material.dart';
import './model.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;

  TodoWidget(this.todo);

  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(todo.todoText),
      ),
    );
  }
}