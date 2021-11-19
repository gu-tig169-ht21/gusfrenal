import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model.dart';

class TodoList extends StatefulWidget {
  final List<Todo> list;

  TodoList(this.list);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.list.length,
        itemBuilder: (context, index) => _todoItem(widget.list[index]));
  }

  Widget _todoItem(
    Todo todo,
  ) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(todo.todoText,
          style: TextStyle(
              decoration: (todo.completed
                  ? TextDecoration.lineThrough
                  : TextDecoration.none)
                  
                  )
                  ),

      value: todo.completed,
      onChanged: (bool? value) {
        var state = Provider.of<MyState>(context, listen: false);
        state.setCompletedTodo(todo, value!);
      },
      secondary: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          var state = Provider.of<MyState>(context, listen: false);
          state.removeTodo(todo);
        },
      ),
    );
  }
}