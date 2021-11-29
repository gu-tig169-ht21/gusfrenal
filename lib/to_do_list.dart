import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model.dart';

class TodoList extends StatelessWidget {
  final List<TodoModel> list;

  const TodoList(this.list, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) => _todoItem(context, list[index]));
  }

  Widget _todoItem(
    context,
    TodoModel todo,
  ) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(todo.title,
          style: TextStyle(
              decoration: (todo.done
                  ? TextDecoration.lineThrough
                  : TextDecoration.none))),
      value: todo.done,
      onChanged: (bool? value) {
        var state = Provider.of<MyState>(context, listen: false);
        state.setDoneTodoModel(todo, value!);
      },
      secondary: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          var state = Provider.of<MyState>(context, listen: false);
          state.removeTodoModel(todo /* state.list[index] */);
        },
      ),
    );
  }
}
