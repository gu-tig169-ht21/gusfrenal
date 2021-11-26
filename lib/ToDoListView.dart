import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'EditToDoView.dart';
import 'TodoList.dart';
import 'model.dart';

class TodoListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "TIG169 Att göra lista",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          PopupMenuButton(
              onSelected: (value) {
                Provider.of<MyState>(context, listen: false);
                    filterTodoModel(value);
              },
              itemBuilder: (context) => [
                    PopupMenuItem(child: Text('Alla'), value: 'Alla'),
                    PopupMenuItem(child: Text('Klara'), value: 'Klara'),
                    PopupMenuItem(child: Text('Ej klara'), value: 'Ej klara'),
                  ]),
        ],
      ),
      body: Consumer<MyState>(
        builder: (context, state, child) =>
            TodoList(_filter(state.list, state.filterValue)),
      ),
      floatingActionButton: _addTodoButton(context),
    );
  }

  List<TodoModel> _filter(list, filterValue) {
    if (filterValue == "Klar") {
      return list.where((todo) => todo.done == true).toList();
    } else if (filterValue == "Ej klar") {
      return list.where((todo) => todo.done == false).toList();
    }
    return list;
  }

  Widget _addTodoButton(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: (Colors.blue),
        child: Icon(Icons.add),
        onPressed: () async {
          var newTodo = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditTodoView(
                      TodoModel(
                        title: '', id: '',
                      ),
                    )),
          );
          if (newTodo != null) {
            Provider.of<MyState>(context, listen: false).addTodoModel(newTodo);
          }
        });
  }

  void filterTodoModel(Object? value) {}
}