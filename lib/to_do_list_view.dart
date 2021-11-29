import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'edit_to_do_view.dart';
import 'to_do_list.dart';
import 'model.dart';

class TodoListView extends StatefulWidget {
  const TodoListView({Key? key}) : super(key: key);

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  String _selectedChoice = 'Alla';
  @override
  void initState() {
    Provider.of<MyState>(context, listen: false).isLoading.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "TIG169 Att göra lista",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          PopupMenuButton<String>(
              onSelected: (value) {
                Provider.of<MyState>(context, listen: false)
                    .filterTodoModel(value);
                setState(() {
                  _selectedChoice = value;
                });
              },
              itemBuilder: (context) => [
                    PopupMenuItem(
                        child: Text('Alla',
                            style: TextStyle(
                                fontWeight: _selectedChoice == 'Alla'
                                    ? FontWeight.bold
                                    : FontWeight.normal)),
                        value: 'Alla'),
                    PopupMenuItem(
                      child: Text('Klara',
                          style: TextStyle(
                              fontWeight: _selectedChoice == 'Klara'
                                  ? FontWeight.bold
                                  : FontWeight.normal)),
                      value: 'Klara',
                    ),
                    PopupMenuItem(
                        child: Text('Ej klara',
                            style: TextStyle(
                                fontWeight: _selectedChoice == 'Ej klara'
                                    ? FontWeight.bold
                                    : FontWeight.normal)),
                        value: 'Ej klara'),
                  ]),
        ],
      ),
      body: Consumer<MyState>(
        builder: (context, state, child) => state.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : TodoList(state.list.where((element) {
                if (state.filterValue == 'Klara') {
                  return element.done;
                } else if (state.filterValue == 'Ej klara') {
                  return !element.done;
                }
                return true;
              }).toList()),
      ),
      floatingActionButton: _addTodoButton(context),
    );
  }

  // List<TodoModel> _filter(list, filterValue) {
  //   if (filterValue == "Klar") {
  //     return list.where((todo) => todo.done == true).toList();
  //   } else if (filterValue == "Ej klar") {
  //     return list.where((todo) => todo.done == false).toList();
  //   }
  //   return list;
  // }

  Widget _addTodoButton(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: (Colors.blue),
        child: const Icon(Icons.add),
        onPressed: () async {
          var newTodo = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditTodoView(
                      TodoModel(
                        title: '',
                        id: '',
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
