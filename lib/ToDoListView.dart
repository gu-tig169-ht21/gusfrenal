import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'EditToDoView.dart';
import 'ToDoList.dart';
import 'model.dart';

class TodoListView extends StatefulWidget {
  const TodoListView({Key? key}) : super(key: key);

  @override
  _TodoListViewState createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  final List<String> filteredAlternatives = ['Alla', 'Klara', 'Ej klara'];
  String? filterValue="1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "TIG169 Att göra lista",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          _todoFilter(),
        ],
      ),
      body: Consumer<MyState>(
        builder: (context, state, child) => TodoList(state.filter(filterValue!)),
      ),
      floatingActionButton: _addTodoButton(context),
    );
  }

  Widget _todoFilter() {
    return PopupMenuButton<String>(
      onSelected: (String value) {
        setState(() {
          filterValue = value;
        });
      },
      itemBuilder: (BuildContext context) {
        return filteredAlternatives
            .map((filterAlternatives) => PopupMenuItem(
                value: filterAlternatives, child: Text(filterAlternatives)))
            .toList();
      },
      icon: const Icon(Icons.more_vert, size: 22, color: Colors.black),
    );
  }

  Widget _addTodoButton(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: (Colors.blue),
        child: const Icon(Icons.add),
        onPressed: () async {
          var newTodo = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditTodoView(
                      Todo(
                        todoText: '',
                      ),
                    )),
          );
          if (newTodo != null) {
            Provider.of<MyState>(context, listen: false).addTodo(newTodo);
          }
        });
  }

  void whenComplete(Null Function() param0) {}
}